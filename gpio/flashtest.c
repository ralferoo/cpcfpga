#include "gpio.h"

int inout( int ibyte, char* out_dr, int totdr, char* test_dr, int write_sclk, int write_do, int read_di )
{
	int obyte = 0;

	int i;
	for (i=0; i<8; i++) {
		out_dr[ write_sclk ] = 0;				// clock falling edge
		out_dr[ write_do   ] = ibyte&0x80 ? 1 : 0;		// data out on falling edge
		send_dr_stream(out_dr, totdr, test_dr);			// send data to chip
		nsleep(50);						// send initial state

		out_dr[ write_sclk ] = 1;				// clock rising edge
		send_dr_stream(out_dr, totdr, test_dr);			// send data to chip
		nsleep(50);						// send initial state

		obyte <<= 1;
		obyte |= test_dr[ read_di ] ? 1 : 0;			// data in on rising edge
	}

	return obyte;
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
	char *out_dr	 = (char*) malloc( totdr );
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

	int read_di  , write_di  , control_di  , control_disable_di  ;
	int read_do  , write_do  , control_do  , control_disable_do  ;
	int read_hold, write_hold, control_hold, control_disable_hold;
	int read_sclk, write_sclk, control_sclk, control_disable_sclk;
	int read_sel , write_sel , control_sel , control_disable_sel ;
	int read_wp  , write_wp  , control_wp  , control_disable_wp  ;
	char* names[] = {"DI","DO","HOLD","SCLK","SEL","WP"};

	// spi control data lines
	find_pin( fpga, "IO_P79", fpga, prom, &read_di  , &write_di  , &control_di  , &control_disable_di   ); // DI
	find_pin( fpga, "IO_P73", fpga, prom, &read_do  , &write_do  , &control_do  , &control_disable_do   ); // DO
	find_pin( fpga, "IO_P82", fpga, prom, &read_hold, &write_hold, &control_hold, &control_disable_hold ); // HOLD
	find_pin( fpga, "IO_P80", fpga, prom, &read_sclk, &write_sclk, &control_sclk, &control_disable_sclk ); // SCLK 
	find_pin( fpga, "IO_P70", fpga, prom, &read_sel , &write_sel , &control_sel , &control_disable_sel  ); // SEL
	find_pin( fpga, "IO_P78", fpga, prom, &read_wp  , &write_wp  , &control_wp  , &control_disable_wp   ); // WP

	printf("di  : rd=%3d wr=%3d con=%3d dis=%d\n", read_di  , write_di  , control_di  , control_disable_di  );
	printf("do  : rd=%3d wr=%3d con=%3d dis=%d\n", read_do  , write_do  , control_do  , control_disable_do  );
	printf("sclk: rd=%3d wr=%3d con=%3d dis=%d\n", read_sclk, write_sclk, control_sclk, control_disable_sclk);
	printf("sel : rd=%3d wr=%3d con=%3d dis=%d\n", read_sel , write_sel , control_sel , control_disable_sel );
	printf("wp  : rd=%3d wr=%3d con=%3d dis=%d\n", read_wp  , write_wp  , control_wp  , control_disable_wp  );
	printf("hold: rd=%3d wr=%3d con=%3d dis=%d\n", read_hold, write_hold, control_hold, control_disable_hold);

	make_safe_dr_stream(out_dr, totdr, fpga, prom);
	out_dr[ control_di   ] =   control_disable_di  ; //  input
	out_dr[ control_do   ] = 1-control_disable_do  ; // output
	out_dr[ control_sclk ] = 1-control_disable_sclk; // output
	out_dr[ control_sel  ] = 1-control_disable_sel ; // output
	out_dr[ control_wp   ] = 1-control_disable_wp  ; // output
	out_dr[ control_hold ] = 1-control_disable_hold; // output

	out_dr[ write_do   ] = 0;
	out_dr[ write_sclk ] = 0;
	out_dr[ write_sel  ] = 1;					// initial data

	dump_dr_stream("out_dr", out_dr, totdr);

	send_dr_stream(out_dr, totdr, test_dr);				// send data to chip
	nsleep(50);							// send initial state

	int i;

	out_dr[ write_sel  ] = 0;					// select chip
	send_dr_stream(out_dr, totdr, test_dr);				// send data to chip
	nsleep(50);							// send initial state
	
	inout( 0x9f, out_dr, totdr, test_dr, write_sclk, write_do, read_di );

	for (i=0;i<4;i++) {
		int j= inout( 0x00, out_dr, totdr, test_dr, write_sclk, write_do, read_di );
		printf("jedec byte %d: %02x\n", i, j);
	}

	out_dr[ write_sel  ] = 1;					// disable chip
	send_dr_stream(out_dr, totdr, test_dr);				// send data to chip
	nsleep(50);							// send initial state

	////////////////

	out_dr[ write_sel  ] = 0;					// select chip
	send_dr_stream(out_dr, totdr, test_dr);				// send data to chip
	nsleep(50);							// send initial state
	
	inout( 0x90, out_dr, totdr, test_dr, write_sclk, write_do, read_di );
	inout( 0x00, out_dr, totdr, test_dr, write_sclk, write_do, read_di );
	inout( 0x00, out_dr, totdr, test_dr, write_sclk, write_do, read_di );
	inout( 0x00, out_dr, totdr, test_dr, write_sclk, write_do, read_di );

	for (i=0;i<4;i++) {
		int j= inout( 0x00, out_dr, totdr, test_dr, write_sclk, write_do, read_di );
		printf("devid byte %d: %02x\n", i, j);
	}

	out_dr[ write_sel  ] = 1;					// disable chip
	send_dr_stream(out_dr, totdr, test_dr);				// send data to chip
	nsleep(50);							// send initial state

	////////////////

	out_dr[ write_sel  ] = 0;					// select chip
	send_dr_stream(out_dr, totdr, test_dr);				// send data to chip
	nsleep(50);							// send initial state
	
	inout( 0x4b, out_dr, totdr, test_dr, write_sclk, write_do, read_di );
	inout( 0x00, out_dr, totdr, test_dr, write_sclk, write_do, read_di );
	inout( 0x00, out_dr, totdr, test_dr, write_sclk, write_do, read_di );
	inout( 0x00, out_dr, totdr, test_dr, write_sclk, write_do, read_di );

	for (i=0;i<8;i++) {
		int j= inout( 0x00, out_dr, totdr, test_dr, write_sclk, write_do, read_di );
		printf("serial byte %d: %02x\n", i, j);
	}

	out_dr[ write_sel  ] = 1;					// disable chip
	send_dr_stream(out_dr, totdr, test_dr);				// send data to chip
	nsleep(50);							// send initial state

	send_ir_stream(bypass_ir, totir);

	free(sample_ir);
	free(exload_ir);
	free(bypass_ir);

	free(safe_dr);
	free(initial_dr);
	free(out_dr);
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
