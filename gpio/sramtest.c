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
/*
	nsleep(1000);
	send_dr_stream(safe_dr, totdr, test_dr);
	dump_dr_stream("test_dr during safe", test_dr, totdr);

	nsleep(1000);
	send_dr_stream(safe_dr, totdr, test2_dr);
//	dump_dr_stream("test2_dr during safe", test2_dr, totdr);

	diff_dr_stream("Differences from test_dr and test2_dr", 0, test_dr, test2_dr, totdr, fpga, prom);

	nsleep(1000);
	send_dr_stream(safe_dr, totdr, test3_dr);
//	dump_dr_stream("test3_dr during safe", test3_dr, totdr);

	diff_dr_stream("Differences from test2_dr and test3_dr", 0, test2_dr, test3_dr, totdr, fpga, prom);

	nsleep(1000);
	send_dr_stream(safe_dr, totdr, test4_dr);
//	dump_dr_stream("test4_dr during safe", test4_dr, totdr);

	diff_dr_stream("Differences from test3_dr and test4_dr", 0, test3_dr, test4_dr, totdr, fpga, prom);

	nsleep(1000);
	send_dr_stream(initial_dr, totdr, test_dr);
//	dump_dr_stream("test_dr after safe", test_dr, totdr);

	test_candidate_pins(initial_dr, totdr, fpga, prom);
*/

	int read_d[19], write_d[19], control_d[19], control_disable_d[19];
	int read_a[19], write_a[19], control_a[19], control_disable_a[19];
	int read_we, write_we, control_we, control_disable_we;
	int read_oe, write_oe, control_oe, control_disable_oe;

	// ram control lines
	find_pin( fpga, "IO_P36", fpga, prom, &read_oe, &write_oe, &control_oe, &control_disable_oe );
	find_pin( fpga, "IO_P6",  fpga, prom, &read_we, &write_we, &control_we, &control_disable_we );

	// ram data lines
	find_pin( fpga, "IO_P25", fpga, prom, &read_d[ 0], &write_d[ 0], &control_d[ 0], &control_disable_d[ 0] );
	find_pin( fpga, "IO_P26", fpga, prom, &read_d[ 1], &write_d[ 1], &control_d[ 1], &control_disable_d[ 1] );
	find_pin( fpga, "IO_P27", fpga, prom, &read_d[ 2], &write_d[ 2], &control_d[ 2], &control_disable_d[ 2] );
	find_pin( fpga, "IO_P28", fpga, prom, &read_d[ 3], &write_d[ 3], &control_d[ 3], &control_disable_d[ 3] );
	find_pin( fpga, "IO_P30", fpga, prom, &read_d[ 4], &write_d[ 4], &control_d[ 4], &control_disable_d[ 4] );
	find_pin( fpga, "IO_P31", fpga, prom, &read_d[ 5], &write_d[ 5], &control_d[ 5], &control_disable_d[ 5] );
	find_pin( fpga, "IO_P32", fpga, prom, &read_d[ 6], &write_d[ 6], &control_d[ 6], &control_disable_d[ 6] );
	find_pin( fpga, "IO_P33", fpga, prom, &read_d[ 7], &write_d[ 7], &control_d[ 7], &control_disable_d[ 7] );

	// ram address lines
	find_pin( fpga, "IO_P24", fpga, prom, &read_a[ 0], &write_a[ 0], &control_a[ 0], &control_disable_a[ 0] );
	find_pin( fpga, "IO_P23", fpga, prom, &read_a[ 1], &write_a[ 1], &control_a[ 1], &control_disable_a[ 1] );
	find_pin( fpga, "IO_P21", fpga, prom, &read_a[ 2], &write_a[ 2], &control_a[ 2], &control_disable_a[ 2] );
	find_pin( fpga, "IO_P20", fpga, prom, &read_a[ 3], &write_a[ 3], &control_a[ 3], &control_disable_a[ 3] );
	find_pin( fpga, "IO_P18", fpga, prom, &read_a[ 4], &write_a[ 4], &control_a[ 4], &control_disable_a[ 4] );
	find_pin( fpga, "IO_P17", fpga, prom, &read_a[ 5], &write_a[ 5], &control_a[ 5], &control_disable_a[ 5] );
	find_pin( fpga, "IO_P15", fpga, prom, &read_a[ 6], &write_a[ 6], &control_a[ 6], &control_disable_a[ 6] );
	find_pin( fpga, "IO_P14", fpga, prom, &read_a[ 7], &write_a[ 7], &control_a[ 7], &control_disable_a[ 7] );
	find_pin( fpga, "IO_P4",  fpga, prom, &read_a[ 8], &write_a[ 8], &control_a[ 8], &control_disable_a[ 8] );
	find_pin( fpga, "IO_P2",  fpga, prom, &read_a[ 9], &write_a[ 9], &control_a[ 9], &control_disable_a[ 9] );
	find_pin( fpga, "IO_P35", fpga, prom, &read_a[10], &write_a[10], &control_a[10], &control_disable_a[10] );
	find_pin( fpga, "IO_P1",  fpga, prom, &read_a[11], &write_a[11], &control_a[11], &control_disable_a[11] );
	find_pin( fpga, "IO_P13", fpga, prom, &read_a[12], &write_a[12], &control_a[12], &control_disable_a[12] );
	find_pin( fpga, "IO_P5",  fpga, prom, &read_a[13], &write_a[13], &control_a[13], &control_disable_a[13] );
	find_pin( fpga, "IO_P12", fpga, prom, &read_a[14], &write_a[14], &control_a[14], &control_disable_a[14] );
	find_pin( fpga, "IO_P8",  fpga, prom, &read_a[15], &write_a[15], &control_a[15], &control_disable_a[15] );
	find_pin( fpga, "IO_P11", fpga, prom, &read_a[16], &write_a[16], &control_a[16], &control_disable_a[16] );
	find_pin( fpga, "IO_P7",  fpga, prom, &read_a[17], &write_a[17], &control_a[17], &control_disable_a[17] );
	find_pin( fpga, "IO_P10", fpga, prom, &read_a[18], &write_a[18], &control_a[18], &control_disable_a[18] );

	int i,j;
	for (j=0; j<10; j++) {
		int* data;
		switch(j) {
		case 0: printf("%-4s", "Addr");
			break;
		case 5: printf("\n%-4s", "Data");
			break;
		case 1: case 6:
			printf("%4s", "rd");
			data = j<5 ? read_a : read_d;
			break;
		case 2: case 7:
			printf("%4s", "wr");
			data = j<5 ? write_a : write_d;
			break;
		case 3: case 8:
			printf("%4s", "con");
			data = j<5 ? control_a : control_d;
			break;
		case 4: case 9:
			printf("%4s", "dis");
			data = j<5 ? control_disable_a : control_disable_d;
			break;
		}
		for (i=0; i < (j<5?19:8) ;i++) {
			int k=i;
			if (j!=0 && j!=5)
				k=*data++;
			printf(" %3d", k);
		}
		printf("\n");
	}
	printf("WE: rd=%3d wr=%3d con=%3d dis=%d\n", read_we, write_we, control_we, control_disable_we);
	printf("OE: rd=%3d wr=%3d con=%3d dis=%d\n", read_oe, write_oe, control_oe, control_disable_oe);

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
