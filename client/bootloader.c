#include "gpio.h"
#include <usb.h>

extern int g_noisy;

int main(int argc, char **argv)
{
//	g_noisy = 1;

	jtagInit();
//	devScanDevices();
//	devDump();

	return atmegaReboot();
	exit(0);
}


