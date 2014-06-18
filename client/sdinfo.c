#include "lib/sidecar.h"

extern int g_noisy;

int usbControlMessage( int requesttype, int request, int value, int index, char *bytes, int size, int timeout);
void dump(const char* buffer, int bytes);

int main(int argc, char **argv)
{
//	g_noisy = 1;

	jtagInit();
	char buffer[1+18+18+4];
	int bytes=usbControlMessage(0xc0, 'S', 0, 0, buffer, sizeof(buffer), 500);
	printf("Received %d bytes\n", bytes);
	printf("Status %02x\n\n", (uint8_t)buffer[0]);
	printf("OCR %02x%02x%02x%02x\n\n", (uint8_t)buffer[37], (uint8_t)buffer[38], (uint8_t)buffer[39], (uint8_t)buffer[40]);
	printf("CSD:\n");
	dump(buffer+1,18);
	printf("\nCID:\n");
	dump(buffer+19,18);

	char buffer2[512];
	char buffer2b[512];

	buffer2b[0]=0;
	for(;;) {
		bytes=usbControlMessage(0xc0, 's', 0, 0, buffer2, sizeof(buffer2), 500);
		if (bytes>=0) {
			buffer2[bytes] = 0;
			if (strcmp(buffer2,buffer2b)) {
				printf("Log (%d): %s", bytes, buffer2);
				strcpy(buffer2b, buffer2);
				if (bytes==0 || buffer2[bytes-1]!='\n')
					printf("\n");
			}
			usleep(100*1000);
		} else {
			printf("No log (returned %d)\n", bytes);
			break;
		}
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


