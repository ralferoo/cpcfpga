#include "lib/sidecar.h"

extern int g_noisy;

int usbControlMessage( int requesttype, int request, int value, int index, char *bytes, int size, int timeout);

int main(int argc, char **argv)
{
//	g_noisy = 1;

	jtagInit();

	int bytes=usbControlMessage(0x40, 'H', 0, 0, "", 0, 500);
	printf("Received %d bytes:\n", bytes);
	exit(0);
}
