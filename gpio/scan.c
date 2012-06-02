#include "gpio.h"

int main(int argc, char **argv)
{
	jtagInit();
	devScanDevices();
	devDump();

	exit(0);
}


