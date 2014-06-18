#include <string.h>
#include "lib/sidecar.h"

#ifdef _MSC_VER
#include <windows.h>
#endif

// xapp188.pdf describes jtag protocol
// xapp452.pdf describes packet format
// xapp503.app has some other info

uint16_t reverse_crc(uint16_t crc)
{
	uint16_t o=0;
	int i;
	for (i=0;i<16;i++) {
		o<<=1;
		o|=crc&1;
		crc>>=1;
	}
	return o;
}

uint16_t update_crc(uint16_t crc, uint32_t bits, int count)
{
	uint16_t in=crc;
	uint32_t bi=bits;
	int ci=count;
	while (count-->0) {
		if ( ((crc>>15)^bits)&1 )
			crc = (crc<<1) ^ 0x8005;
		else
			crc = (crc<<1);
		bits>>=1;
	}
	//printf("[%04x+%x/%d->%04x]",in,bi,ci,crc);
	return crc;
}

// SVF part 1
// Examining 6 words
//       4: WRITE 30008001: type 1 op 2 reg 4 count 1
// CMD 00000008 AGHIGH

uint8_t initial_buffer[] = {
	0xff,0xff,0xff,0xff,
	0x55,0x99,0xaa,0x66,
	0x0c,0x00,0x01,0x80,
	0x00,0x00,0x00,0x10,
	0x04,0x00,0x00,0x00,
	0x04,0x00,0x00,0x00,
};

// 66 aa 99 55 ff ff ff ff
// 00 00 00 00 00 00 00 00
// 10 00 00 00 80 01 00 0c 66 aa 99 55) SMASK (

uint32_t read_buffer_count=0;
uint8_t read_buffer[256<<10];
uint8_t result_buffer[256<<10];

int processHexFile(uint8_t type, uint8_t len, uint16_t addr, uint8_t *data)
{
	static uint16_t hi=0;
	if (type==4) {
		hi = (data[0]<<8) | data[1];
//		printf("hi address %x\n", hi);
	}

	if (type==0)
	{
		uint32_t next = addr+(hi<<16);
		if (read_buffer_count != next)
		{
			printf("Discontinuity from %05x to %05x\n", read_buffer_count, next);
			return 1;
		}

		if (next<0x80) {
			uint16_t i;
			printf("%05x: ",next);
			for (i=0;i<len;i++) {
				printf("%02x ",data[i]);
			}
			printf("\n");
		}

		memcpy(read_buffer+read_buffer_count, data, len);

		read_buffer_count = next + len;
//		printf("t: %x, len: %2x, addr: %05x\n", type, len, addr+(hi<<16));
	}
	return 0;
}

uint32_t read_long(uint8_t **buffer, uint32_t *len)
{
	uint32_t r=0;
	int i,j;
	for (j=0;j<4;j++) {
		uint8_t a=*(*buffer)++;
		for (i=0;i<8;i++) {
			r=(r<<1)|(a&1);
			a>>=1;
		}
		(*len)--;
	}
	return r;
}

void patch_last_long(uint8_t *buffer, uint32_t r)
{
	int i,j;
	for (j=0;j<4;j++) {
		uint8_t a = 0;
		for (i=0;i<8;i++) {
			a=(a<<1)|(r&1);
			r>>=1;
		}
		*--buffer = a;
	}
}

int debug_fpga(uint8_t *buffer, uint32_t len)
{
	uint32_t r=0;
	while (len>=4 && r!=0xaa995566) {
		r = read_long(&buffer, &len);
		printf("SYNC %08x\n", r);
	}
	uint32_t cnt=0;
	uint32_t reg=0;
	uint8_t t, op, rsvd;
	uint16_t crc=0xffff,crc2=0xffff;		// dummy
	int nops=0;
	while (len>=4) {
		r = read_long(&buffer, &len);
		t = (r>>29)&7;
		op = (r>>27)&3;
		switch(t) {
			case 1:
				cnt = r&0x7ff;
				reg = (r>>13)&0x3fff;
				rsvd = (r>>11)&3;
				break;
			case 2:
				if (cnt) {
					printf("ERROR %08x\n",r);
					jtagExit();
					exit(0);
				}
				cnt = r&0x7ffffff;
				break;
			default:
				printf("ERROR %08x CRC %04x\n",r,crc);
				return 0;
		}
		switch(op) {
			case 0:
				if (nops++==0)
					printf("NOP   %08X: type %d op %d reg %x count %d crc %04x/%04x\n",r,t,op,reg,cnt,crc,crc2);
				break;
			case 2:
				if (nops>1)
					printf("(total %d nops)\n",nops);
				nops=0;
				printf("WRITE %08X: type %d op %d reg %x count %d crc %04x/%04x\n",r,t,op,reg,cnt,crc,crc2);
				break;
			default:
				if (nops>1)
					printf("(total %d nops)\n",nops);
				nops=0;
				printf("UNEXP %08x - unexpected packet op %d type %d cnt %d crc %04x/%04x\n",r,op,t,cnt,crc,crc2);
				return 0;
		}

		int idx =0;
		if (op==2) {
				char* regs[]={	"CRC", "FAR", "FDRI", "REG3",
						"CMD", "CTL", "MASK", "REG7",
						"LOUT","COR", "MFWR", "FLR",
						"REG12","REG13","IDCODE", "REG15"};
						
			printf("  %-8s%s", regs[reg&15], (++idx)&7?" ":"\n  ");
		}

		uint32_t i=cnt;
		while (i-- && len>=4) {
			r = read_long(&buffer, &len);
			uint16_t oldcrc=crc;
			crc = update_crc(crc, r, 32);
			crc = update_crc(crc, reg, 5);

			if (cnt==1)
				printf("%08x%s",r, (++idx)&7?" ":"\n  ");
			else if (i==0)
				printf("...");

			if (reg==4) {
				char* cmds[]={	"NULL","WCFG","MFWR","LFRM",
						"RCFG","START","RCAP","RCRC",
						"AGHIGH","SWITCH","GRESTORE","SHUTDOWN",
						"GCAPTURE","DESYNC","CMD14","CMD15"};

				//if (idx&7) printf("\n");
				//printf("CMD %08x %s\n",r,cmds[r&15]);
				//idx=0;
				printf("%-10s%s",cmds[r&15], (++idx)&7?" ":"\n  ");
			}

			if (reg==0) {
				//if (oldcrc != crc2)
					//printf("*** ERROR crc and crc2 mismatch!\n");
				uint16_t patch = reverse_crc(crc2);
				r=patch;
				printf("%-8s%s", "patched", (++idx)&7?" ":"\n  ");
				printf("%08x%s",r, (++idx)&7?" ":"\n  ");
				patch_last_long(buffer,r);
			}

			if (reg==9) {
				r=(r&0xfffe7fff)|0x00010000;
				printf("%-8s%s", "patched", (++idx)&7?" ":"\n  ");
				printf("%08x%s",r, (++idx)&7?" ":"\n  ");
				patch_last_long(buffer,r);
			}

			if (reg==5 || reg==6) {
				r=8; //r|9;
				printf("%-8s%s", "patched", (++idx)&7?" ":"\n  ");
				printf("%08x%s",r, (++idx)&7?" ":"\n  ");
				patch_last_long(buffer,r);
			}

			if (reg==4 && r==7) {
				//printf("Reset CRC\n");
				crc=0;
				crc2=0;
			}
			else {
				crc2 = update_crc(crc2, r, 32);
				crc2 = update_crc(crc2, reg, 5);
			}
		}
		if (idx&7) printf("\n");

		if (reg==2 && cnt && len>=4) {
			r = read_long(&buffer, &len);
			uint16_t patch = reverse_crc(crc2);
			printf("Auto CRC %04x (patch %04x) previous CRC %04x/%04x\n", r,patch, crc, crc2);
			crc = update_crc(crc, r, 16);

			crc2 = update_crc(crc2, patch, 16);
			patch_last_long(buffer,patch);
		}

		if (crc==0)
			printf("*** CRC  valid\n");
		if (crc2==0)
			printf("*** CRC2 valid\n");
	}
	printf("Final CRC %04x\n", crc);
	return 1;
}

int main(int argc, char **argv)
{
	hexStartFile(processHexFile);
	hexReadStream(0);

	debug_fpga(initial_buffer, sizeof(initial_buffer));

	printf("Read %d bytes from file\n", read_buffer_count);

	debug_fpga(read_buffer,read_buffer_count);
	printf("After patch:\n");
	debug_fpga(read_buffer,read_buffer_count);

	fflush(stdout);

	jtagInit();
	promBoot(1);
	devScanDevices();
	devDump();

	// test fpga
	struct Device *fpga = devFindDevice(FPGA_XC3S400);
	if( !fpga ) {
		printf("No FPGA found...\n");
		jtagExit();
		exit(1);
	}
	fpgaValidate(fpga);

	uint32_t nulls[]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};

	// bypass instruction
	jtagSendIR( 0x3f, fpga);

	jtagReset();
	jtagIdle();

	// jshutdown instruction
	jtagSendIR( 0x0d, fpga);

	// jprogram instruction
	jtagSendIR( 0x0b, fpga);

	// cfg_in instruction
	jtagSendIR( 0x05, fpga);
	jtagShiftDR();

	printf("Header of %d:\n", fpga->hdr);
	if (fpga->hdr!=1) {
		printf("HDR not 1: %d\n", fpga->hdr);
		jtagExit();
		exit(1);
	}
	uint8_t dummy=0xff;
	jtagSendAndReceiveBits(0, fpga->hdr, &dummy, NULL);

#ifdef _MSC_VER
	Sleep(500);
#else
	usleep(500000);
#endif
	jtagSendAndReceiveBits(0, sizeof(initial_buffer)*8, initial_buffer, NULL);
#ifdef _MSC_VER
	Sleep(500);
#else
	usleep(500000);
#endif

	uint8_t *buff=read_buffer;
	uint8_t *rbuff=result_buffer;
	uint32_t len=read_buffer_count;
	uint32_t bsz=1<<10;
	while (len>bsz) {
#ifdef _MSC_VER
		putchar('.');
		fflush(stdout);
#else
		write(1, ".", 1);
#endif
		jtagSendAndReceiveBits(0, bsz*8, buff, NULL); //rbuff);
		len-=bsz;
		buff+=bsz;
		rbuff+=bsz;
	}
#ifdef _MSC_VER
	putchar('\n');
#else
	write(1, "\n", 1);
#endif
	jtagSendAndReceiveBits(1, len*8, buff, NULL); //rbuff);

	// jstart instruction
	jtagSendIR( 0x0c, fpga);
	jtagRunTestTCK(13);

	// bypass instruction
	jtagSendIR( 0x3f, fpga);

	// bypass instruction
	jtagSendIR( 0x3f, fpga);

	// jstart instruction
	jtagSendIR( 0x0c, fpga);
	jtagRunTestTCK(13);

	// bypass instruction
	jtagSendIR( 0x3f, fpga);

	// bypass instruction
	jtagSendIR( 0x3f, fpga);
	jtagSendDR( 0, 32, fpga);

	jtagReset();

	// bypass instruction
	jtagSendIR( 0x3f, fpga);
	jtagReset();

#ifdef _MSC_VER
	Sleep(1000);
#else
	sleep(1);
#endif

	promBoot(0);

	jtagExit();
	exit(0);
}


