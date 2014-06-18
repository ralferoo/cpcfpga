#include "lib/sidecar.h"

void pintest(void)
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

	dump_dr_stream("initial_dr", initial_dr, totdr);
	dump_dr_stream("safe_dr", safe_dr, totdr);

	send_ir_stream(exload_ir, totir);

	nsleep(1000);
	send_dr_stream(safe_dr, totdr, test_dr);
	dump_dr_stream("test_dr during safe", test_dr, totdr);

	nsleep(1000);
	send_dr_stream(safe_dr, totdr, test2_dr);
//	dump_dr_stream("test2_dr during safe", test2_dr, totdr);

	diff_dr_stream("Differences from test_dr and test2_dr", 0, test_dr, test2_dr, totdr, fpga, prom,0);

	nsleep(1000);
	send_dr_stream(safe_dr, totdr, test3_dr);
//	dump_dr_stream("test3_dr during safe", test3_dr, totdr);

	diff_dr_stream("Differences from test2_dr and test3_dr", 0, test2_dr, test3_dr, totdr, fpga, prom,0);

	nsleep(1000);
	send_dr_stream(safe_dr, totdr, test4_dr);
//	dump_dr_stream("test4_dr during safe", test4_dr, totdr);

	diff_dr_stream("Differences from test3_dr and test4_dr", 0, test3_dr, test4_dr, totdr, fpga, prom,0);

	nsleep(1000);
	send_dr_stream(initial_dr, totdr, test_dr);
//	dump_dr_stream("test_dr after safe", test_dr, totdr);

	test_candidate_pins(initial_dr, totdr, fpga, prom);

	// ram address lines
	test_pin( fpga, "IO_P5", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P24", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P23", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P21", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P20", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P18", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P17", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P15", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P14", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P4", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P2", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P35", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P1", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P13", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P5", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P12", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P8", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P11", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P7", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P10", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );

	// ram control lines
	test_pin( fpga, "IO_P36", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P6", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );

	// video
	test_pin( fpga, "IO_P63", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P60", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P55", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P53", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P59", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P57", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P52", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );

	test_pin( fpga, "IO_P68", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P69", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );

	// tape and exp control lines
	test_pin( fpga, "IO_P131", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P47", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P50", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P51", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );

	test_pin( fpga, "IO_P76", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P74", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P77", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );

	// gpio
	test_pin( fpga, "IO_P137", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P135", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P132", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P130", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P129", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P127", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
//	test_pin( fpga, "IO_P128", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P123", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );

	// leds
	test_pin( fpga, "IO_P85", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P83", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P84", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P86", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P87", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );

	// joy0
	test_pin( fpga, "IO_P118", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P116", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P119", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P113", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P112", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P122", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );

	// joy1
	test_pin( fpga, "IO_P105", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P104", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P107", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P103", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P102", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P108", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );

	// sd slot
	test_pin( fpga, "IO_P40", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P140", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P141", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P41", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );

	// ps2
	test_pin( fpga, "IO_P46", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P44", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );

	// extclk
	test_pin( fpga, "IO_P100", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );

	// avr
	test_pin( fpga, "IO_P98", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P99", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P125", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P97", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P96", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P95", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P93", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P92", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P90", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P89", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );

	// flash
	test_pin( fpga, "IO_P79", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P73", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P82", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P80", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P70", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
	test_pin( fpga, "IO_P78", safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );

	// possible shorts:
	//	P1,P2,P4 x lots - FIXED
	//
	//	P131,P140 occasional (casin, sd_di)
	//	P118,119,122 (down, fire2, up on joy0)
	//	P113,116,118 (left, fire1, down on joy0)
	//	P122, P123 (up, gpio10)
	//	P59, P57 (video, ok)
	//	P53, P55 (video, ok)
	//	P60, P63 (video, ok)

	// second board:
	//	P60&P63, P53&P55, P57&P59 (video)

	// third board
	//	P140 & P131
	//	P125 & P124

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

/*
	// output the BSR command on both prom and fpga

	jtagShiftIR();
*/
}

int main(int argc, char **argv)
{
	jtagInit();
	devScanDevices();
	devDump();
	printf("\n");
	pintest();

	jtagReset();
	exit(0);
}
