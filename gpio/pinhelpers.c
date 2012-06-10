#include "gpio.h"

#include "xc3s400_tq144_1532.h"
#include "xcf02s_vo20.h"

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

void send_dr_stream(char* dr_stream, int totdr, char* result_stream)
{
	int i, bit;
	jtagShiftDR();						// enter shift DR phase

	for (i=0; i<totdr; i++) {
		result_stream[i] = jtagOutput(dr_stream[i], i==(totdr-1));  // output the DR stream, setting TMS at the end
	}

	jtagSelectDR();						// force progression through update DR
}

void dump_dr_stream(const char* name, char* dr_stream, int totdr)
{
	printf("\nDR stream for %s:\n", name);
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

void diff_dr_stream(const char* name, const char* ignore, char* dr_stream, char* dr2_stream, int totdr, struct Device *fpga, struct Device *prom)
{
	if (name)
		printf("%s:\n", name);
	int d;
	for (d=0; d<2; d++) {
		struct Device* device = d ? fpga : prom;
		struct BoundaryScan* cells = d ? XC3S400_TQ144_BSCAN : XCF02S_VO20_BSCAN;

		for (;cells->cellnum >= 0; cells++) {
			int pos=device->user + cells->cellnum;
			if (dr_stream[pos] != dr2_stream[pos] ) {
				char* port = cells->port ? cells->port : "???";

				if( strcmp(port, "IO_P56") && ( ignore==0 || strcmp(port,ignore) ) ) {
					char* type = "???";
					switch(cells->function) {
						case BC_F_INTERNAL: type="internal";	break;
						case BC_F_INPUT	  : type="input";	break;
						case BC_F_OUTPUT3 : type="output3";	break;
						case BC_F_CONTROLR: type="controlr";	continue; //break;
					}
					printf("%10s %3d %-8s (%3d) %20s %d %d\n",
						device->name, cells->cellnum, type, pos, port,
						dr_stream[pos], dr2_stream[pos] );
				}

			}
		}
	}
}

void copy_safe_bits(char* safe_dr, int totdr, struct Device *device, struct BoundaryScan *cells)
{
	if (device->user + device->bsrlen > totdr) {
		printf("copy_safe_bits: BSR bits for %s go beyond end of DR stream (start %d, len %d, end %d, totdr %d)\n",
			device->name, device->user, device->bsrlen, device->user + device->bsrlen, totdr);
		jtagReset();
		exit(1);
	}

	int cellsdone = 0;
	while (cells->cellnum >= 0) {
		int pos = cells->cellnum + device->user;

		if (pos >= totdr) {
			printf("copy_safe_bits: cellNum %d out of range on device %s (%d)\n", cells->cellnum, device->name, pos);
			jtagReset();
			exit(1);
		}
		safe_dr[pos] = cells->safe;

		cells++;
		cellsdone++;
	}

	printf("Copied %d cells from %s to safe bits to postion %d\n", cellsdone, device->name, device->user);
}

void make_safe_dr_stream(char* safe_dr, int totdr, struct Device *fpga, struct Device *prom)
{
	int i;
	for (i=0; i<totdr; i++)
		safe_dr[i]=1;				// initialise to all ones

	copy_safe_bits(safe_dr, totdr, fpga, XC3S400_TQ144_BSCAN);
	copy_safe_bits(safe_dr, totdr, prom, XCF02S_VO20_BSCAN);
}

void test_candidate_pins(char* safe_dr, int totdr, struct Device *fpga, struct Device *prom)
{
	printf("Candidates for output pin tests:\n");
	int d;
	for (d=0; d<2; d++) {
		struct Device* device = d ? fpga : prom;
		struct BoundaryScan* cells = d ? XC3S400_TQ144_BSCAN : XCF02S_VO20_BSCAN;

		for (;cells->cellnum >= 0; cells++) {
			int pos=device->user + cells->cellnum;
			char* port = cells->port ? cells->port : "???";

			if( cells->function == BC_F_OUTPUT3 ) {
				int ctrl = cells->control >= 0 ? cells->control + device->user : -1;

				int test = ctrl >=0 ? safe_dr[ctrl] : -1;
				int disabled = ctrl >= 0 ? (safe_dr[ctrl]==cells->disable_control) : 2;

				printf("%10s %3d (%3d) control %3d (%3d ) %-8s %20s %d\n",
					device->name, cells->cellnum, pos,
					cells->control, ctrl, 
					disabled ? "DISABLED" : "OUTPUT",
					port, safe_dr[pos] );
			}
		}
	}
	printf("\n");
}

void real_test_pin( struct Device *device, struct BoundaryScan* cells,
		char* safe_dr, int totdr, char* test_dr, char* test2_dr, char* test3_dr,
		struct Device *fpga, struct Device *prom)
{
	memcpy(test_dr, safe_dr, totdr);

	int pos=device->user + cells->cellnum;
	int ctrl = cells->control >= 0 ? cells->control + device->user : -1;

	printf("Testing pin %s on %s, %3d (%3d) control %3d (%3d) DC=%d:\n", cells->port, device->name,
		cells->cellnum, pos, cells->control, ctrl, cells->disable_control);

	if (ctrl >= 0 && (cells->disable_control==0 || cells->disable_control==1) )
		test_dr[ctrl] = 1-cells->disable_control;

	test_dr[pos] = 1;

	nsleep(5000);
	send_dr_stream(test_dr, totdr, test2_dr);			// send the initial test vector
	nsleep(1000);
	send_dr_stream(test_dr, totdr, test3_dr);			// send it again just to be sure
	nsleep(1000);
	send_dr_stream(test_dr, totdr, test3_dr);			// send it again just to be sure

	int i;
	for (i=0; i<8; i++) {
		if (i&2) {
			test_dr[pos] = 1;
		} else {
			test_dr[pos] = 0;
		}

		nsleep(1000);
		if (i&1) 						// alternate results between test2 and test3
			send_dr_stream(test_dr, totdr, test3_dr);
		else
			send_dr_stream(test_dr, totdr, test2_dr);

		diff_dr_stream(0, cells->port, test2_dr, test3_dr, totdr, fpga, prom);
	}
}

void test_pin( struct Device *device, char* pin, char* safe_dr, int totdr, char* test_dr, char* test2_dr, char* test3_dr,
		struct Device *fpga, struct Device *prom)
{
	struct BoundaryScan* cells;
	if (device == prom)
		cells = XCF02S_VO20_BSCAN;
	else if (device == fpga)
		cells = XC3S400_TQ144_BSCAN;
	else {
		printf("Can't test pin %s as device isn't FPGA or PROM!\n", pin);
		return;
	}

	for (;cells->cellnum >= 0; cells++) {
		if( cells->function == BC_F_OUTPUT3 && cells->port && strcmp(cells->port, pin)==0 ) {
			real_test_pin( device, cells, safe_dr, totdr, test_dr, test2_dr, test3_dr, fpga, prom );
			return;
		}
	}

	printf("Can't find output pin %s to test in device %s!\n", pin, device->name);
}

void find_pin( struct Device *device, char* pin, struct Device *fpga, struct Device *prom,
		int *read_pin, int *write_pin, int *control_pin, int *control_disable)
{
	struct BoundaryScan* cells;
	if (device == prom)
		cells = XCF02S_VO20_BSCAN;
	else if (device == fpga)
		cells = XC3S400_TQ144_BSCAN;
	else {
		printf("Can't test pin %s as device isn't FPGA or PROM!\n", pin);
		return;
	}

	*read_pin = *write_pin = *control_pin = -1;
	*control_disable = 0;

	for (;cells->cellnum >= 0; cells++) {
		if( cells->port && strcmp(cells->port, pin)==0 ) {
			switch (cells->function) {
			case BC_F_OUTPUT3:
				*write_pin	 = device->user + cells->cellnum;
				*control_pin	 = device->user + cells->control;
				*control_disable = cells->disable_control;
				break;
			case BC_F_INPUT:
				*read_pin	 = device->user + cells->cellnum;
				break;
			}
		}
	}

	if (*read_pin == -1 && *write_pin == -1 && *control_pin == -1) {
		printf("Can't find pin %s to test in device %s!\n", pin, device->name);
	}
}
