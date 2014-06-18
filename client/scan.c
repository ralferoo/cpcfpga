#include "lib/sidecar.h"

extern int g_noisy;

int main(int argc, char **argv)
{
//	g_noisy = 1;

	jtagInit();
	devScanDevices();
	devDump();

	jtagExit();
	exit(0);
}


