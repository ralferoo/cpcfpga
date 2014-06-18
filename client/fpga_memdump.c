#include "lib/sidecar.h"

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

	int st=0x400, end=0x1000;
	if (argc>1) sscanf(argv[1], "%d", &st);
	if (argc>2) sscanf(argv[2], "%d", &end);

	uint32_t i,j,k;
	for (i=st; i<end; i++) {
		uint32_t result = fpga_user_get(fpga, i);

		if( (i&15)==0) {
			if (i) printf("\n");
			printf("%04x: ", i);
		} else if ((i&3)==0)
			printf(" ");
		printf("%04x", result & 0xffff);
		if (i==0x41f)
			i=0x7ff;
	}
	printf("\n");

	jtagReset();

	jtagExit();
	exit(0);
}
