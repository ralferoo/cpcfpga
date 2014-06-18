#include "lib/sidecar.h"

extern int g_noisy;

int usbControlMessage( int requesttype, int request, int value, int index, char *bytes, int size, int timeout);

int main(int argc, char **argv)
{
	jtagLog();
	exit(0);
}

