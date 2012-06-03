#include "gpio.h"

extern int g_noisy;

int main(int argc, char **argv)
{
	jtagInit();
	devScanDevices();
	devDump();

//	g_noisy = 1;

	struct Device *device = devGetFirstDevice();
	while (device) {
		jtagBoundaryScanDump(device);
		device = device->next;
		if (device)
			printf("\n");
	}

	exit(0);
}


