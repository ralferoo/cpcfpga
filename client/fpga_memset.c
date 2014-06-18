#include "lib/sidecar.h"

int vals[0x1000] = {0};

int main(int argc, char **argv)
{
	jtagInit();
	devScanDevices();
	devDump();

	// test prom
	struct Device *fpga = devFindDevice(FPGA_XC3S400);
	if( !fpga ) {
		printf("No FPGA found...\n");
		jtagExit();
		exit(1);
	}
	fpgaValidate(fpga);

	uint32_t usercode = fpgaUserCode(fpga);
	printf("\nFPGA user code is %0X\n", usercode);

	uint32_t i,j,k;

	memset(vals, 0xff, sizeof(vals));

	int cnt=0;
	while( scanf("%d %d", &i, &j) > 0) { //!= EOF ) {
		j &= 0xffff;
		if (vals[i] != j || (i&0x700)==0x400) {
			vals[i]=j;
//			printf("[%04x]=%04x\n", i,j );
			fpga_user_set(fpga,i,j);
			cnt++;
		}
		if(i==1027) {
			static int last=0;
			printf("Frame %5d time %3d.%02d cnt %5d delta %5d\n", j, j/50, 2*(j%50), cnt, cnt-last);
			last = cnt;
		}
	}
	i=0x403;j=0;
//	printf("[%04x]=%04x\n", i,j );
	fpga_user_set(fpga,i,j);

/*
fern_ifs_conv:
	defw	#0000,#0000,#1700,-1, #0000,#0280,#27e6,-1
	defw	#0d90,#fec0,#09cc,-1, #00a0,#0d90,#fe54,-1
	defw	#0330,#0850,#fa4d,-1, #fc60,#0380,#21a6,-1
	defw	#fda0,#f710,#3499,-1, #fbe0,#03d0,#2719,-1
*/

/*
	set(fpga,0x002,0x27e6);
	set(fpga,0x006,0x1700);
	set(fpga,0x00a,0xfe54);
	set(fpga,0x00e,0x09cc);
	set(fpga,0x012,0x21a6);
	set(fpga,0x016,0xfa4d);
	set(fpga,0x01a,0x2719);
	set(fpga,0x01e,0x3499);
*/

/*
sier_ifs_conv:
	defw	#0800,#0000,#1680,-1, #0000,#0800,#0000,-1
	defw	#0800,#0000,#0000,-1, #0000,#0800,#2000,-1
	defw	#0800,#0000,#2d00,-1, #0000,#0800,#2000,-1
	defw	#1000,#0000,#0000,-1, #0000,#1000,#0000,-1
*/

/*
	set(fpga,0x030,1146);
	set(fpga,0x031,-1638);
	set(fpga,0x034,1638);
	set(fpga,0x035,1146);
*/

/*
fern_ifs_conv:
	defw	#0000,#0000,#16e0,-1, #0000,#028f,#27e6,-1
	defw	#0d99,#00a3,#09ac,-1, #feb9,#0d99,#fe54,-1
	defw	#0333,#fc52,#fa2d,-1, #0851,#0385,#21a6,-1
	defw	#fd9a,#fbd8,#3479,-1, #f70b,#03d7,#2719,-1
*/

/*
static int values[] = {
	0x0000,0x0000,0x16e0,-1, 0x0000,0x028f,0x27e6,-1,
	0x0d99,0x00a3,0x09ac,-1, 0xfeb9,0x0d99,0xfe54,-1,
	0x0333,0xfc52,0xfa2d,-1, 0x0851,0x0385,0x21a6,-1,
	0xfd9a,0xfbd8,0x3479,-1, 0xf70b,0x03d7,0x2719,-1,
};
	for( i=0; i<sizeof(values)/sizeof(values[0]); i++) {
		set(fpga,i,values[i]);
	}
*/

//	set(fpga,0x800,0);

/*
	for (i=0xb00; i<0xc00;i++) {
		set(fpga,i,12+(i&3));
	}
	for (i=0xf00; i<0x1000;i++) {
		set(fpga,i,12+(i&3));
	}
*/
/*
	for (i=0xd00; i<0xe00;i++) {
		set(fpga,i,4+(i%3));
	}
	for (i=0x900; i<0xa00;i++) {
		set(fpga,i,4+(i%3));
	}
*/

/*
	for (i=0; i<0x400; i++) {
		// send address
		jtagSendIR(0x02, fpga);
		jtagSendDR(i, 13, fpga);
		jtagUpdateOrIdle();

		// get data
		jtagSendIR(0x03, fpga);
		uint32_t result = jtagSendDR(0, 16, fpga);
		jtagUpdateOrIdle();

	}

	jtagExit();
	exit(0);
*/

/*
	for (i=0; i<32; i+=8 ) {
		set(fpga,i+0,0x60);
		set(fpga,i+1,0x20);
//		set(fpga,i+2,(i&0x18)<<11);
		set(fpga,i+2,i&8?0x3000:0x0000);
		set(fpga,i+3,('x'<<8)|i);

		set(fpga,i+4,0xffe0);
//		set(fpga,i+5,0xffe0);
		set(fpga,i+5,0x60);
		set(fpga,i+6,i&16?0x2800:0x0800);
//		set(fpga,i+6,0x8000);
		set(fpga,i+7,('y'<<8)|i);
	}
*/

/*
	for (i=0; i<0x20; i+=8 ) {
		set(fpga,i+0,(i&0x18)==0x18?0x100:0x80);
		set(fpga,i+1,0);
		set(fpga,i+2,(i&0x18)==0?0x1000:((i&0x18)==0x10?0x2000:0));
		set(fpga,i+3,('x'<<8)|i);

		set(fpga,i+4,0x00);
		set(fpga,i+5,(i&0x18)==0x18?0x100:0x80);
		set(fpga,i+6,(i&0x18)==8?0x2000:((i&0x18)==0x10?0x2000:0));
//		set(fpga,i+6,0x8000);
		set(fpga,i+7,('y'<<8)|i);
	}
*/

/*
	for (i=2; i<0x20; i+=4) {
		// send address
		jtagSendIR(0x02, fpga);
		jtagSendDR(i, 13, fpga);
		jtagUpdateOrIdle();

		// get data
		jtagSendIR(0x03, fpga);
		uint32_t result = jtagSendDR(0, 16, fpga) &0xffff;
		jtagUpdateOrIdle();

		int16_t shift = (int16_t) result;
		shift >>= 1;
		uint32_t upd = (uint32_t) shift;

		printf("%04x: %04x -> %04x\n", i, result, upd);
		set(fpga,i,upd);
	}
*/

/*
	for (i=0x800; i<0x840; i++) {
		// send address
		jtagSendIR(0x02, fpga);
		jtagSendDR(i, 13, fpga);
		jtagUpdateOrIdle();

		// get data
		jtagSendIR(0x03, fpga);
		uint32_t result = jtagSendDR(0, 16, fpga);
		jtagUpdateOrIdle();

		if( (i&15)==0) {
			if (i) printf("\n");
			printf("%04x: ", i);
		} else if ((i&3)==0)
			printf(" ");
		printf("%04x", result & 0xffff);
	}
	printf("\n");
*/

	jtagReset();

	jtagExit();
	exit(0);
}
