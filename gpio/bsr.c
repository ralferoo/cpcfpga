#include "gpio.h"

int main(int argc, char **argv)
{
	jtagInit();
	devScanDevices();
	devDump();

	struct Device *device = devGetFirstDevice();
	while (device) {
		jtagBoundaryScanDump(device);
		device = device->next;
		if (device)
			printf("\n");
	}

	exit(0);
}


