#include "gpio.h"

extern int g_noisy;

int main(int argc, char **argv)
{
//	g_noisy = 1;

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
	promDump(prom);

	exit(0);
}


