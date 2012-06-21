#include <string.h>
#include "gpio.h"

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
	promReload(prom);

	exit(0);
}


