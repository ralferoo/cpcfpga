#include "gpio.h"

extern int g_noisy;

int main(int argc, char **argv)
{
	jtagInit();
	devScanDevices();
	devDump();

//	g_noisy = 1;

#ifdef REPEAT
	printf("%c[2J",27);
	for(;;) {
	printf("%c[1;1f",27);
#endif
		struct Device *device = devGetFirstDevice();
		while (device) {
			jtagBoundaryScanDump(device);
			device = device->next;
			if (device)
				printf("\n");
		}
#ifdef REPEAT
	}
#endif
	exit(0);
}


