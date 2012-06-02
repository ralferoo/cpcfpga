#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include "gpio.h"

int main(int argc, char **argv)
{
	jtagInit();
	devScanDevices();

	exit(0);
}


