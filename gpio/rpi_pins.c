#include <time.h>
#include <errno.h>

#include "gpio.h"

#define GPIO_TMS 21
#define GPIO_TCK 17
#define GPIO_TDI 4
#define GPIO_TDO 18 //22

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
	pinSetDirectionOutput(GPIO_TMS);
	pinSetDirectionOutput(GPIO_TCK);
	pinSetDirectionOutput(GPIO_TDI);
	pinSetDirectionInput (GPIO_TDO);
	pinOutput(GPIO_TMS,1);
	pinOutput(GPIO_TCK,0);
}

///////////////////////////////////////////////////////////////////////////

int jtagLowlevelClock(int tdi, int tms)
{
	pinOutput(GPIO_TDI,tdi);
	pinOutput(GPIO_TMS,tms);
	int tdo = pinInput(GPIO_TDO);

	asm("nop;nop;nop");		// 3/750 ms = 4ns
	pinOutput(GPIO_TCK,1);
	asm("nop;nop;nop;nop;nop;nop");	// 6/750 ms = 8ns
	pinOutput(GPIO_TCK,0);
	asm("nop;nop;nop");		// 3/750 ms = 4ns

	return tdo;
}

///////////////////////////////////////////////////////////////////////////

void jtagRunTestTCK( unsigned int i )
{
	jtagIdle();
	while( i-- ) {
		jtagOutput(0,0);
	}
}
