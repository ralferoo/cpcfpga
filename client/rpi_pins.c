#define DUMP_ALL_JTAG_TRAFFIC

#include <time.h>
#include <errno.h>

#include "gpio.h"

//#define GPIO_TMS 21
//#define GPIO_TCK 17
//#define GPIO_TDI 4
//#define GPIO_TDO 18 //22

#define GPIO_TMS 8
#define GPIO_TCK 25
#define GPIO_TDI 23
#define GPIO_TDO 24

#include <unistd.h>

#define BCM2708_PERI_BASE        0x20000000
#define GPIO_BASE                (BCM2708_PERI_BASE + 0x200000) /* GPIO controller */


#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <dirent.h>
#include <fcntl.h>
#include <assert.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>

#include <unistd.h>

#define PAGE_SIZE (4*1024)
#define BLOCK_SIZE (4*1024)

int  mem_fd;
char *gpio_mem, *gpio_map;
char *spi0_mem, *spi0_map;


// I/O access
volatile unsigned *gpio;


// GPIO setup macros. Always use INP_GPIO(x) before using OUT_GPIO(x) or SET_GPIO_ALT(x,y)
#define INP_GPIO(g) *(gpio+((g)/10)) &= ~(7<<(((g)%10)*3))
#define OUT_GPIO(g) *(gpio+((g)/10)) |=  (1<<(((g)%10)*3))
#define SET_GPIO_ALT(g,a) *(gpio+(((g)/10))) |= (((a)<=3?(a)+4:(a)==4?3:2)<<(((g)%10)*3))

#define GPIO_SET *(gpio+7)  // sets   bits which are 1 ignores bits which are 0
#define GPIO_CLR *(gpio+10) // clears bits which are 1 ignores bits which are 0
#define GPIO_LEV *(gpio+13) // gets levels of bits

void pinSetupIO();


#ifdef DUMP_ALL_JTAG_TRAFFIC
int dumper_fd = -1;
unsigned char dumper_buffer[10000];
int dumper_bufptr = 0;
int dumper_total = 0;
#endif

void TrafficDumpExit(void)
{
#ifdef DUMP_ALL_JTAG_TRAFFIC
	if (dumper_fd >= 0) {
//		printf("TrafficDumpExit flush\n");
		dumper_buffer[ dumper_bufptr++ ] = '\n';
		if (dumper_bufptr) {
			int wlen = write(dumper_fd, dumper_buffer, dumper_bufptr);
			if (dumper_bufptr != wlen)
				printf("Error flushing final jtag buffer wrote %d instead of %d bytes\n", wlen, dumper_bufptr);
		}
		close(dumper_fd);
		dumper_fd = -1;
		dumper_bufptr = 0;
	}
#endif
}

void TrafficDumpBit(int tms, int tdi, int tdo)
{
#ifdef DUMP_ALL_JTAG_TRAFFIC
	unsigned char out = tdi ?         '1' : '0';		//    1=TDI (from us to JTAG)
	if (tdo)		out |=    2;			//    2=TDO (from JTAG to us) 
	if (tms)		out |= 0x4;			// 0x8=TMS (JTAG transition)

	if ( (dumper_bufptr+4) > sizeof(dumper_buffer)) {
//		printf("TrafficDumpBit flush\n");
		if (dumper_fd >= 0) {
			int wlen = write(dumper_fd, dumper_buffer, dumper_bufptr);
			if (dumper_bufptr != wlen)
				printf("Error flushing jtag buffer wrote %d instead of %d bytes\n", wlen, dumper_bufptr);
		}
		dumper_bufptr = 0;
	}

	dumper_buffer[ dumper_bufptr++ ] = out;
	dumper_total++;
	if ((dumper_total&0x3f) == 0)
		dumper_buffer[ dumper_bufptr++ ] = '\n';
#endif
}

void TrafficDumpInit(void)
{
#ifdef DUMP_ALL_JTAG_TRAFFIC
	if (dumper_fd < 0) {
		char path_buffer[128];
		sprintf(path_buffer, "/jtaglogs/jtag-%ld.log", time(0) );
		dumper_fd = open(path_buffer, O_WRONLY | O_CREAT, 0777);
		dumper_bufptr = 0;
		dumper_total = 0;

		atexit(TrafficDumpExit);
	}
#endif
}


//
// Set up a memory regions to access GPIO
//
void pinSetupIO()
{

   /* open /dev/mem */
   if ((mem_fd = open("/dev/mem", O_RDWR|O_SYNC) ) < 0) {
      printf("can't open /dev/mem \n");
      exit (-1);
   }

   /* mmap GPIO */

   // Allocate MAP block
   if ((gpio_mem = malloc(BLOCK_SIZE + (PAGE_SIZE-1))) == NULL) {
      printf("allocation error \n");
      exit (-1);
   }

   // Make sure pointer is on 4K boundary
   if ((unsigned long)gpio_mem % PAGE_SIZE)
     gpio_mem += PAGE_SIZE - ((unsigned long)gpio_mem % PAGE_SIZE);

   // Now map it
   gpio_map = (unsigned char *)mmap(
      (caddr_t)gpio_mem,
      BLOCK_SIZE,
      PROT_READ|PROT_WRITE,
      MAP_SHARED|MAP_FIXED,
      mem_fd,
      GPIO_BASE
   );

   if ((long)gpio_map < 0) {
      printf("mmap error %d\n", (int)gpio_map);
      exit (-1);
   }

   // Always use volatile pointer!
   gpio = (volatile unsigned *)gpio_map;

#ifdef DUMP_ALL_JTAG_TRAFFIC
	TrafficDumpInit();
#endif


} // pinSetupIO

inline void pinSetDirectionInput(int i)
{
    INP_GPIO(i);
}

inline void pinSetDirectionOutput(int i)
{
    INP_GPIO(i); // must use INP_GPIO before we can use OUT_GPIO
    OUT_GPIO(i);
}

inline void pinOutput(int i, int v)
{
	if(v)
		GPIO_SET = 1<<i;
	else
		GPIO_CLR = 1<<i;
}

inline int pinInput(int i)
{
	return ( GPIO_LEV & (1<<i) ) ? 1 : 0;
}

///////////////////////////////////////////////////////////////////////////

void jtagInit(void)
{
	// Set up gpi pointer for direct register access
	pinSetupIO();

	// set pin directions
	pinOutput(GPIO_TMS,1);
	pinOutput(GPIO_TCK,0);
	pinSetDirectionOutput(GPIO_TMS);
	pinSetDirectionOutput(GPIO_TCK);
	pinSetDirectionOutput(GPIO_TDI);
	pinSetDirectionInput (GPIO_TDO);

	int i;
	for (i=0;i<20;i++)
		asm("nop;nop;nop;nop;nop;nop");	// 6/750 ms = 8ns
}

///////////////////////////////////////////////////////////////////////////

int jtagLowlevelClock(int tdi, int tms)
{
	int i;

	pinOutput(GPIO_TDI,tdi);
	pinOutput(GPIO_TMS,tms);
	int tdo = pinInput(GPIO_TDO);

	asm("nop;nop;nop;nop;nop;nop");	// 6/750 ms = 8ns
	asm("nop;nop;nop;nop;nop;nop");	// 6/750 ms = 8ns

	pinOutput(GPIO_TCK,1);

//	asm("nop;nop;nop;nop;nop;nop");	// 6/750 ms = 8ns
//	asm("nop;nop;nop;nop;nop;nop");	// 6/750 ms = 8ns

	for (i=0;i<20;i++)
		asm("nop;nop;nop;nop;nop;nop");	// 6/750 ms = 8ns

	if (tms)
		for (i=0;i<50;i++)
			asm("nop;nop;nop;nop;nop;nop");	// 6/750 ms = 8ns

	pinOutput(GPIO_TCK,0);

	for (i=0;i<20;i++)
		asm("nop;nop;nop;nop;nop;nop");	// 6/750 ms = 8ns

	if (tms)
		for (i=0;i<50;i++)
			asm("nop;nop;nop;nop;nop;nop");	// 6/750 ms = 8ns

//	asm("nop;nop;nop;nop;nop;nop");	// 6/750 ms = 8ns
//	asm("nop;nop;nop;nop;nop;nop");	// 6/750 ms = 8ns

//	printf("%d/%d -> %d\n", tdi,tms, tdo);

#ifdef DUMP_ALL_JTAG_TRAFFIC
	TrafficDumpBit(tms, tdi, tdo);
#endif
	return tdo;
}

void jtagLowlevelClockRO(int tdi, int tms)
{
	jtagLowlevelClock(tdi,tms);
}

///////////////////////////////////////////////////////////////////////////

void jtagRunTestTCK( unsigned int i )
{
	jtagIdle();
	while( i-- ) {
		jtagOutput(1,0);	// changed to 1 in case in shift IR
	}

	for (i=0;i<20;i++)
		asm("nop;nop;nop;nop;nop;nop");	// 6/750 ms = 8ns
}

///////////////////////////////////////////////////////////////////////////

void jtagSendAndReceiveBits(int tms_at_end, int num_bits, unsigned char* send, unsigned char* recv)
{
	int offset = 0;
	unsigned char data = 0, rdata = 0;
	while (num_bits--) {
		if ( (offset&7)==0 ) {
			data = send[offset>>3];
		}
		unsigned char mask = 1<<(offset&7);

		int tdi = (data&mask) ? 1 : 0;
		int tdo = jtagLowlevelClock(tdi,num_bits==0 && tms_at_end);

		if (tdo) rdata |= mask;

		if ( (offset&7)==7 && recv ) {
			recv[offset>>3] = rdata;
			rdata = 0;
		}
		offset++;
	}

	if ( (offset&7) && recv ) {
		recv[offset>>3] = rdata;
	}
}

