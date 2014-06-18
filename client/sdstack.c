#include "lib/sidecar.h"

extern int g_noisy;

int usbControlMessage( int requesttype, int request, int value, int index, char *bytes, int size, int timeout);
void dump(const char* buffer, int bytes);

int unused(char* b)
{
	int i=0;
	while( ((unsigned char) *b++) == 0xe5)
		i++;
	return i;
}

int main(int argc, char **argv)
{
//	g_noisy = 1;

	jtagInit();
	char buffer[512];
	int bytes=usbControlMessage(0xc0, '&', 0, 0, buffer, sizeof(buffer), 500);
	printf("Received interrupt stack of %d bytes, unused %d, used %d\n", bytes, unused(buffer), bytes-unused(buffer));
	dump(buffer,bytes);

	bytes=usbControlMessage(0xc0, '%', 0, 0, buffer, sizeof(buffer), 500);
	printf("Received main stack of %d bytes, unused %d, used %d\n", bytes, unused(buffer), bytes-unused(buffer));
	dump(buffer,bytes);

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


