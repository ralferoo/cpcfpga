#include "lib/sidecar.h"

int main(int argc, char **argv)
{
	jtagInit();

	int i;
	uint8_t dummy = 0;
	for (i=0;i<10;i++) {
		jtagGetState(false);
		jtagSendAndReceiveBits(1, 1, &dummy, NULL); // RESET
		jtagFlush();
	}
	jtagSendAndReceiveBits(0, 1, &dummy, NULL);	// IDLE
	jtagFlush();
	for (i=0;i<10;i++) {
		jtagGetState(false);
		jtagSendAndReceiveBits(1, 1, &dummy, NULL); // RESET
		jtagFlush();
	}

	jtagExit();
	exit(0);
}
