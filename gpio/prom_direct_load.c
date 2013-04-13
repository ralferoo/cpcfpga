#include <string.h>
#include "gpio.h"

int processHexFile(uint8_t type, uint8_t len, uint16_t addr, uint8_t *data)
{
	printf("t: %x, len: %2x, addr: %05x\n", type, len, addr);
	return 0;
}

int main(int argc, char **argv)
{
/*
	jtagInit();
	devScanDevices();
	devDump();

	// test prom
	struct Device *prom = devFindDevice(PROM_XCF02S);
	if( !prom ) {
		printf("No PROM found...\n");
		exit(1);
	}
*/

	// read the hex file from stdin
//	promValidate(prom);
//	promProgramStart(prom);
	hexStartFile(processHexFile);
	hexReadStream(0);

	// force end marker
//	promProgramData( 1, 0, 0, (uint8_t*)"");

	exit(0);
}


