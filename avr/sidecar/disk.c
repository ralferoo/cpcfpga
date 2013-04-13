#include "disk.h"

static char sector_buffer[512];
//static char sector_buffer[1];

void DISK_Init()
{
	int i;
	for (i=0; i<sizeof(sector_buffer); i++)
		sector_buffer[i]=i;
}
