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

	uint32_t i,j,k;
	for (i=0; i<256; i+=13) {
		cpcSetCommand(fpga, i);
		j=i*i;
		k=cpcTransferData(fpga, j);
		printf("Command %02x sent %08x recv %08x\n", i, j, k);
	}

	jtagReset();

	jtagExit();
	exit(0);
}



