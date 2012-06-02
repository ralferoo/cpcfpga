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
	promProgramStart(prom);

	char* testdata="Hello there!";
	int i=promProgramData( 0, strlen(testdata), 0, (uint8_t*) testdata);
	int j=promProgramData( 1, 0, 0, (uint8_t*)"");

	printf("program results: %d %d\n", i, j);

	exit(0);
}


