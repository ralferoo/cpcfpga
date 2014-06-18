#include "lib/sidecar.h"

int main(int argc, char **argv)
{
	jtagInit();
	devScanDevices();
	devDump();

	// test prom
	struct Device *prom = devFindDevice(PROM_XCF02S);
	if( !prom ) {
		printf("No PROM found...\n");
		exit(1);
	}
	promValidate(prom);
	promErase(prom);

	exit(0);
}


