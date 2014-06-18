#include "lib/sidecar.h"

extern int g_noisy;

int usbControlMessage( int requesttype, int request, int value, int index, char *bytes, int size, int timeout);
void dump(const char* buffer, int bytes);

int atmegaFDC(int status, int data)
{
	return usbControlMessage(0x40, 'f', status, data, "", 0, 500);
}

int main(int argc, char **argv)
{
//	g_noisy = 1;

	if (argc<2) {
		printf("Usage: %s status [data]\n", argv[0]);
		jtagExit();
		exit(1);
	}
	
	jtagInit();

	int bytes=atmegaFDC(atoi(argv[1]), argc<3?0:atoi(argv[2]));
	printf("Received %d bytes:\n", bytes);

	char buffer2[512];

	bytes=usbControlMessage(0xc0, 's', 0, 0, buffer2, sizeof(buffer2), 500);
	if (bytes>=0) {
		buffer2[bytes]=0;
		printf("Log (%d): %s", bytes, buffer2);
		if (bytes==0 || buffer2[bytes-1]!='\n')
			printf("\n");
	} else {
		printf("No log (returned %d)\n", bytes);
	}
	jtagExit();
	exit(0);
}

void dump(const char* buffer, int bytes)
{
	int i,j;
	for (i=0; i<bytes; i+=16) {
		printf("%03x: ", i);
		for(j=0;j<16;j++) {
			if ((i+j)<bytes)
				printf("%02x ", (buffer[i+j])&0xff);
			else	printf("   ");
		}
		for(j=0;j<16;j++) {
			char c = buffer[i+j];
			if ((i+j)<bytes)
				printf("%c", (c>=0x20 && c<0x7f) ? c : '.');
		}
		printf("\n");
	}
}



