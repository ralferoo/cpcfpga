#include "gpio.h"

int main(int argc, char **argv)
{
	jtagInit();
	devScanDevices();

	exit(0);
}


