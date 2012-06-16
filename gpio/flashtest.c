#include "gpio.h"

void dump_bits(char *bits, int read, int write, int control, int control_disable)
{
	printf("%d%c%d ", bits[read], bits[control]==control_disable ? 'R' : 'W', bits[write]);
}

int dump_sram_bits(char *bits,
			int *read_a, int *write_a, int *control_a, int *control_disable_a,
			int *read_d, int *write_d, int *control_d, int *control_disable_d,
			int read_we, int write_we, int control_we, int control_disable_we,
			int read_oe, int write_oe, int control_oe, int control_disable_oe)
{
	int i;
	printf("A: ");
	for (i=18; i>=0; i--)
		dump_bits(bits, read_a[i], write_a[i], control_a[i], control_disable_a[i]);
	printf("\nD: ");
	for (i=7; i>=0; i--)
		dump_bits(bits, read_d[i], write_d[i], control_d[i], control_disable_d[i]);
	printf("    WE: ");
	dump_bits(bits, read_we, write_we, control_we, control_disable_we);
	printf("OE: ");
	dump_bits(bits, read_oe, write_oe, control_oe, control_disable_oe);
	printf("\n");
}

int read_sram_byte(char *safe_dr, int totdr, int addr,
			int *read_a, int *write_a, int *control_a, int *control_disable_a,
			int *read_d, int *write_d, int *control_d, int *control_disable_d,
			int read_we, int write_we, int control_we, int control_disable_we,
			int read_oe, int write_oe, int control_oe, int control_disable_oe)
{
	char *out_dr	= (char*) malloc( totdr );
	char *result_dr	= (char*) malloc( totdr );

	memcpy(out_dr, safe_dr, totdr);

	int i;
	for (i=0; i<19; i++) {
		out_dr[   write_a[i] ] = (addr>>i)&1;
		out_dr[ control_a[i] ] = 1-control_disable_a[i];	// output
	}
	for (i=0; i<8; i++) {
		out_dr[ control_d[i] ] =   control_disable_d[i];	// input
	}

	out_dr[   write_oe ] = 0;
	out_dr[ control_oe ] = 1-control_disable_a[i];	// output

	out_dr[   write_we ] = 1;
	out_dr[ control_we ] = 1-control_disable_a[i];	// output

	send_dr_stream(out_dr, totdr, result_dr);			// send data to chip
	nsleep(50);							// wait for read

	out_dr[   write_oe ] = 1;					// disable output
	send_dr_stream(safe_dr, totdr, result_dr);			// get data from chip

#if 0
//	dump_dr_stream("bits after read", result_dr, totdr);
	dump_sram_bits(result_dr,
			read_a, write_a, control_a, control_disable_a,
			read_d, write_d, control_d, control_disable_d,
			read_we, write_we, control_we, control_disable_we,
			read_oe, write_oe, control_oe, control_disable_oe);
#endif

	int byte = 0;
	for (i=0; i<8; i++) {
		if (result_dr[ read_d[i] ])
			byte |= 1<<i;
	}

	free(out_dr);
	free(result_dr);

	return byte;
}

int write_sram_byte(char *safe_dr, int totdr, int addr, int byte,
			int *read_a, int *write_a, int *control_a, int *control_disable_a,
			int *read_d, int *write_d, int *control_d, int *control_disable_d,
			int read_we, int write_we, int control_we, int control_disable_we,
			int read_oe, int write_oe, int control_oe, int control_disable_oe)
{
	char *out_dr	= (char*) malloc( totdr );
	char *result_dr	= (char*) malloc( totdr );

	memcpy(out_dr, safe_dr, totdr);

	int i;
	for (i=0; i<19; i++) {
		out_dr[   write_a[i] ] = (addr>>i)&1;
		out_dr[ control_a[i] ] = 1-control_disable_a[i];	// output
	}
	for (i=0; i<8; i++) {
		out_dr[   write_d[i] ] = (byte>>i)&1;
		out_dr[ control_d[i] ] = 1-control_disable_d[i];	// output
	}

	out_dr[   write_oe ] = 1;
	out_dr[ control_oe ] = 1-control_disable_a[i];	// output

	out_dr[   write_we ] = 0;
	out_dr[ control_we ] = 1-control_disable_a[i];	// output

	send_dr_stream(out_dr, totdr, result_dr);			// send data to chip
	nsleep(50);							// wait for read

	out_dr[   write_oe ] = 0;					//  enable output
	out_dr[   write_we ] = 1;					// disable write
	send_dr_stream(out_dr, totdr, result_dr);			// send data to chip
//	nsleep(5);							// wait for read

	send_dr_stream(safe_dr, totdr, result_dr);			// get data from chip

#if 0
//	dump_dr_stream("bits after read", result_dr, totdr);
	dump_sram_bits(result_dr,
			read_a, write_a, control_a, control_disable_a,
			read_d, write_d, control_d, control_disable_d,
			read_we, write_we, control_we, control_disable_we,
			read_oe, write_oe, control_oe, control_disable_oe);
#endif

	byte = 0;
	for (i=0; i<8; i++) {
		if (result_dr[ read_d[i] ])
			byte |= 1<<i;
	}

	free(out_dr);
	free(result_dr);

	return byte;
}

void sramtest(void)
{
	struct Device *fpga = devFindDevice(FPGA_XC3S400);
	struct Device *prom = devFindDevice(PROM_XCF02S);

	if (fpga==0 || prom==0) {
		printf("Can't find suitable PROM and FPGA.\n");
		exit(1);
	}

	struct Device *first, *second;
	if (fpga->hir < prom->hir) {
		first = fpga; second = prom;
	} else {
		first = prom; second = fpga;
	}

	int mir = second->hir - first->hir - first->len;
	int mdr = second->hdr - first->hdr - 1;

	int totir = first->hir + first->   len + mir + second->   len + second->tir;
	int totdr = first->hdr + first->bsrlen + mdr + second->bsrlen + second->tdr;

	first ->user = first->hdr;
	second->user = first->hdr + first->bsrlen + mdr;

	printf("BSR chain is: pre(%d/%d) %s(%d/%d) mid(%d/%d) %s(%d/%d) end(%d/%d) => %d/%d\n",
				first->hir, first->hdr,
		first->name,	first->len, first->bsrlen,
				mir, mdr,
		second->name,	second->len, second->bsrlen,
				second->tir, second->tdr,
				totir, totdr);

	//printf("FPGA data start at %d, PROM data bits start at %d\n", fpga->user, prom->user);

	if (second->hir != (first->hir + first->len + mir) ) {
		printf("Calculation error: second hir is %d but should be %d+%d+%d = %d\n", 
			second->hir, first->hir, first->len, mir, first->hir + first->len + mir );
		exit(1);
	}

	if (totir != (second->hir + second->len + second->tir) ) {
		printf("Calculation error: totir is %d but should be %d+%d+%d = %d\n", 
			totir, second->hir, second->len, second->tir, second->hir + second->len + second->tir );
		exit(1);
	}

	char *sample_ir	 = (char*) malloc( totir );
	char *exload_ir	 = (char*) malloc( totir );
	char *bypass_ir	 = (char*) malloc( totir );

	char *safe_dr	 = (char*) malloc( totdr );
	char *initial_dr = (char*) malloc( totdr );
	char *test_dr	 = (char*) malloc( totdr );
	char *test2_dr	 = (char*) malloc( totdr );
	char *test3_dr	 = (char*) malloc( totdr );
	char *test4_dr	 = (char*) malloc( totdr );

	make_ir_stream(sample_ir, first, second, mir, first->bsrsample, second->bsrsample);
	make_ir_stream(exload_ir, first, second, mir, 0, 0);
	make_ir_stream(bypass_ir, first, second, mir, 0xff, 0xff);

	send_ir_stream(sample_ir, totir);
	sample_dr_stream(initial_dr, totdr);
	make_safe_dr_stream(safe_dr, totdr, fpga, prom);

//	dump_dr_stream("initial_dr", initial_dr, totdr);
//	dump_dr_stream("safe_dr", safe_dr, totdr);

	send_ir_stream(exload_ir, totir);

	int read[6], write[6], control[6], control_disable[6];
	char* names[] = {"DI","DO","HOLD","SCLK","SEL","WP"};

	// spi control data lines
	find_pin( fpga, "IO_P79", fpga, prom, &read[ 0], &write[ 0], &control[ 0], &control_disable[ 0] ); // DI
	find_pin( fpga, "IO_P73", fpga, prom, &read[ 1], &write[ 1], &control[ 1], &control_disable[ 1] ); // DO
	find_pin( fpga, "IO_P82", fpga, prom, &read[ 2], &write[ 2], &control[ 2], &control_disable[ 2] ); // HOLD
	find_pin( fpga, "IO_P80", fpga, prom, &read[ 3], &write[ 3], &control[ 3], &control_disable[ 3] ); // SCLK
	find_pin( fpga, "IO_P70", fpga, prom, &read[ 4], &write[ 4], &control[ 4], &control_disable[ 4] ); // SEL
	find_pin( fpga, "IO_P78", fpga, prom, &read[ 5], &write[ 5], &control[ 5], &control_disable[ 5] ); // WP

	int i,j;
	for (j=0; j<5; j++) {
		int* data;
		switch(j) {
		case 0: printf("%-4s", "");
			break;
		case 1: 
			printf("%4s", "rd");
			data = read;
			break;
		case 2: 
			printf("%4s", "wr");
			data = write;
			break;
		case 3: 
			printf("%4s", "con");
			data = control;
			break;
		case 4: 
			printf("%4s", "dis");
			data = control_disable;
			break;
		}
		for (i=0; i < 6 ;i++) {
			if (j)
				printf(" %4d", *data++);
			else
				printf(" %4s", names[i]);
		}
		printf("\n");
	}
/*
	int addr;
	printf("Writing dummy data\n");
	char* data = "This is test data...";
	for (addr=0xfe00;addr<0x10000;addr++) {
		if ( (addr&0x1ff)==0 )
			printf("Addr: %05x\n", addr);

//	for (;*data;addr++,data++) {
		int obyte = *data;
		if (obyte) data++; 
		else obyte = addr + (addr>>11) + (addr>>16);
		int byte = write_sram_byte(safe_dr, totdr, addr, obyte,
					read_a, write_a, control_a, control_disable_a,
					read_d, write_d, control_d, control_disable_d,
					read_we, write_we, control_we, control_disable_we,
					read_oe, write_oe, control_oe, control_disable_oe);
	
//		printf("write byte at %05x is %02x (should be %02x)\n", addr, byte, obyte);
	}

	for (addr=0; addr<48; addr++) {
		int byte = read_sram_byte(safe_dr, totdr, addr,
					read_a, write_a, control_a, control_disable_a,
					read_d, write_d, control_d, control_disable_d,
					read_we, write_we, control_we, control_disable_we,
					read_oe, write_oe, control_oe, control_disable_oe);
	
//		printf(" read byte at %05x is %02x\n", addr, byte);
	}

	printf("Testing low bits:\n");

	for (addr=0; addr<255; addr++) {
		int obyte = (addr * 17) & 255;
		int byte = write_sram_byte(safe_dr, totdr, addr, obyte,
					read_a, write_a, control_a, control_disable_a,
					read_d, write_d, control_d, control_disable_d,
					read_we, write_we, control_we, control_disable_we,
					read_oe, write_oe, control_oe, control_disable_oe);
	}
	for (addr=0; addr<255; addr++) {
		int obyte = (addr * 17) & 255;
		int byte = read_sram_byte(safe_dr, totdr, addr, 
					read_a, write_a, control_a, control_disable_a,
					read_d, write_d, control_d, control_disable_d,
					read_we, write_we, control_we, control_disable_we,
					read_oe, write_oe, control_oe, control_disable_oe);

		if (byte != obyte)
			printf("Byte at %05x was %02x not %02x\n", addr, byte, obyte);
	}

	printf("Testing high bits:\n");

	for (addr=0; addr< (1<<19); addr+=256) {
		int obyte = (addr>>8)*5 + (addr>>16)*11;
		int byte = write_sram_byte(safe_dr, totdr, addr, obyte,
					read_a, write_a, control_a, control_disable_a,
					read_d, write_d, control_d, control_disable_d,
					read_we, write_we, control_we, control_disable_we,
					read_oe, write_oe, control_oe, control_disable_oe);
	}

	for (addr=0; addr< (1<<19); addr+=256) {
		int obyte = (addr>>8)*5 + (addr>>16)*11;
		int byte = read_sram_byte(safe_dr, totdr, addr, 
					read_a, write_a, control_a, control_disable_a,
					read_d, write_d, control_d, control_disable_d,
					read_we, write_we, control_we, control_disable_we,
					read_oe, write_oe, control_oe, control_disable_oe);

		if (byte != (obyte&0xff))
			printf("Byte at %05x was %02x not %02x\n", addr, byte, obyte);
	}

	// flash
//	find_pin( fpga, "IO_P79", fpga, prom, &read_a[ 0], &write_a[ 0], &control_a[ 0], &control_disable_a[ 0] );
//	find_pin( fpga, "IO_P73", fpga, prom, &read_a[ 0], &write_a[ 0], &control_a[ 0], &control_disable_a[ 0] );
//	find_pin( fpga, "IO_P82", fpga, prom, &read_a[ 0], &write_a[ 0], &control_a[ 0], &control_disable_a[ 0] );
//	find_pin( fpga, "IO_P80", fpga, prom, &read_a[ 0], &write_a[ 0], &control_a[ 0], &control_disable_a[ 0] );
//	find_pin( fpga, "IO_P70", fpga, prom, &read_a[ 0], &write_a[ 0], &control_a[ 0], &control_disable_a[ 0] );
//	find_pin( fpga, "IO_P78", fpga, prom, &read_a[ 0], &write_a[ 0], &control_a[ 0], &control_disable_a[ 0] );
*/

	send_ir_stream(bypass_ir, totir);

	free(sample_ir);
	free(exload_ir);
	free(bypass_ir);

	free(safe_dr);
	free(initial_dr);
	free(test_dr);
	free(test2_dr);
	free(test3_dr);
	free(test4_dr);
}

int main(int argc, char **argv)
{
	jtagInit();
	devScanDevices();
	devDump();
	printf("\n");
	sramtest();

	jtagReset();
	exit(0);
}
