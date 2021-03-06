#include <string.h>
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

	// read the hex file from stdin
	promValidate(prom);
	promErase(prom);

	promValidate(prom);
	promProgramStart(prom);
	hexStartFile(promProgramData);
	hexReadStream(0);

	// force end marker
	promProgramData( 1, 0, 0, (uint8_t*)"");

	promBoot(0);
	promValidate(prom);
	promReload(prom);

	exit(0);
}


