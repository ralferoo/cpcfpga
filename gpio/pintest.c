#include "gpio.h"

#include "xc3s400_tq144_1532.h"
#include "xcf02s_vo20.h"

extern int g_noisy;

void make_ir_stream(char* sample, struct Device *first, struct Device *second, int mir, 
		 int first_cmd, int second_cmd)
{
	int i,bits,left;
	for (i=0; i<first->hir; i++)
		*sample++ = 1;				// pre bits

	bits = first_cmd;
	for (i=0; i<first->len; i++) {
		*sample++ = bits&1;			// first bits
		bits >>= 1;
	}

	for (i=0; i<mir; i++)
		*sample++ = 1;				// mid bits

	bits = second_cmd;
	for (i=0; i<second->len; i++) {
		*sample++ = bits&1;			// second bits
		bits >>= 1;
	}

	for (i=0; i<second->tir; i++)
		*sample++ = 1;				// trail bits
}

void send_ir_stream(char* ir_stream, int totir)
{
	int i, bit;
	jtagShiftIR();					// enter shift IR phase

	for (i=0; i<totir; i++)
		jtagOutput(ir_stream[i], 0);		// output the IR stream

	for (i=0; i<totir; i++) {
		bit = jtagOutput(ir_stream[i], i==(totir-1));	// output the IR stream again, setting TMS at the end
		if (bit != ir_stream[i]) {		// this time making sure it's correct
			printf("send_ir_stream: calculated ir stream length of %d bits seems to be incorrect at bit %d\n", totir, i);
			jtagReset();
			exit(1);
		}
	}
}

void sample_dr_stream(char* dr_stream, int totdr)
{
	int i, bit;
	jtagShiftDR();						// enter shift DR phase

	for (i=0; i<totdr; i++)
		dr_stream[i] = jtagOutput(1, 0);		// sample the DR stream, writing out 1s

	for (i=0; i<totdr; i++) {
		bit = jtagOutput(0, 0);				// output a stream of 0s, checking for expected 1s
		if (bit != 1) {
			printf("sample_dr_stream: expected to find 1 at bit %d\n", i);
			jtagReset();
			exit(1);
		}
	}

	for (i=0; i<totdr; i++) {
		bit = jtagOutput(1, 0);				// output a stream of 1s, checking for expected 0s
		if (bit != 0) {
			printf("sample_dr_stream: expected to find 0 at bit %d\n", i);
			jtagReset();
			exit(1);
		}
	}

	for (i=0; i<totdr; i++) {
		bit = jtagOutput(dr_stream[i], 0);		// output the DR stream, checking for expected 1s
		if (bit != 1) {
			printf("sample_dr_stream: expected to find 1 at bit %d\n", i);
			jtagReset();
			exit(1);
		}
	}

	for (i=0; i<totdr; i++) {
		bit = jtagOutput(dr_stream[i], i==(totdr-1));	// output the DR stream again, setting TMS at the end
		if (bit != dr_stream[i]) {		// this time making sure it's correct
			printf("sample_dr_stream: didn't find expected bit %d\n", i);
			jtagReset();
			exit(1);
		}
	}
}

void dump_dr_stream(const char* name, char* dr_stream, int totdr)
{
	printf("DR stream for %s:\n", name);
	printf("     01234 56789 01234 56789 01234 56789 01234 56789 01234 56789 01234 56789\n");
	printf("     ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----");
	int i;
	for (i=0; i<totdr; i++) {
		if ( (i%60) == 0 )
			printf("\n%3d:", i);
		if ( (i%5) == 0)
			printf(" ");
		printf("%d", dr_stream[i]);
	}
	printf("\n");
}

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

//	char *safe_dr	 = (char*) malloc( totdr );
	char *initial_dr = (char*) malloc( totdr );
	char *test_dr	 = (char*) malloc( totdr );

	make_ir_stream(sample_ir, first, second, mir, first->bsrsample, second->bsrsample);
	make_ir_stream(exload_ir, first, second, mir, 0, 0);
	make_ir_stream(bypass_ir, first, second, mir, 0xff, 0xff);

	send_ir_stream(sample_ir, totir);
	sample_dr_stream(initial_dr, totdr);

	dump_dr_stream("initial_dr", initial_dr, totdr);

	send_ir_stream(bypass_ir, totir);

	free(sample_ir);
	free(exload_ir);
	free(bypass_ir);

//	free(safe_dr);
	free(initial_dr);
	free(test_dr);

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

/*
//	g_noisy = 1;

#ifdef REPEAT
	printf("%c[2J",27);
	for(;;) {
	printf("%c[1;1f",27);
#endif
		struct Device *device = devGetFirstDevice();
		while (device) {
			jtagBoundaryScanDump(device);
			device = device->next;
			if (device)
				printf("\n");
		}
#ifdef REPEAT
	}
#endif
*/
	exit(0);
}
