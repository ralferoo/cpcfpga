#include "lib/sidecar.h"

extern int g_noisy;

int atmegaReadSector(int track, int head, int sector, char* buffer)
{
	return usbControlMessage(0xc0, 'R', 0, (head?0x8000:0)+track*256+sector, buffer, 512, 500);
}

int usbControlMessage( int requesttype, int request, int value, int index, char *bytes, int size, int timeout);

int main(int argc, char **argv)
{
//	g_noisy = 1;

	if (argc!=4) {
		printf("Usage: %s track head sect\n", argv[0]);
		jtagExit();
		exit(1);
	}
	
	jtagInit();

	char buffer[512];
	int bytes=atmegaReadSector(atoi(argv[1]), atoi(argv[2]), atoi(argv[3]), buffer);
	printf("Received %d bytes:\n", bytes);
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
	jtagExit();
	exit(0);
}


