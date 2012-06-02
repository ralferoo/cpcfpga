//
//  How to access GPIO registers from C-code on the Raspberry-Pi
//  Example program
//  15-January-2012
//  Dom and Gert
//

#define GPIO_TMS 21
#define GPIO_TCK 17
#define GPIO_TDI 4
#define GPIO_TDO 22

#include <unistd.h>

//inline void fnSleep(void)
//{
//	usleep(1000);		// 1000 usec = 1 ms -> 1MHz
//}

// Access from ARM Running Linux

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

void setup_io();

int xxxmain(int argc, char **argv)
{ int g,rep;

  // Set up gpi pointer for direct register access
  setup_io();

  // Switch GPIO 7..11 to output mode

 /************************************************************************\
  * You are about to change the GPIO settings of your computer.          *
  * Mess this up and it will stop working!                               *
  * It might be a good idea to 'sync' before running this program        *
  * so at least you still have your code changes written to the SD-card! *
 \************************************************************************/

  // Set GPIO pins 7-11 to output
  for (g=7; g<=11; g++)
  {
    INP_GPIO(g); // must use INP_GPIO before we can use OUT_GPIO
    OUT_GPIO(g);
  }

  for (rep=0; rep<10; rep++)
  {
     for (g=7; g<=11; g++)
     {
       GPIO_SET = 1<<g;
       sleep(1);
     }
     for (g=7; g<=11; g++)
     {
       GPIO_CLR = 1<<g;
       sleep(1);
     }
  }

  return 0;

} // main


//
// Set up a memory regions to access GPIO
//
void setup_io()
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


} // setup_io

inline void fnPinDirectionInput(int i)
{
    INP_GPIO(i);
}

inline void fnPinDirectionOutput(int i)
{
    INP_GPIO(i); // must use INP_GPIO before we can use OUT_GPIO
    OUT_GPIO(i);
}

inline void fnOutPin(int i, int v)
{
	if(v)
		GPIO_SET = 1<<i;
	else
		GPIO_CLR = 1<<i;
}

inline int fnInPin(int i)
{
	return ( GPIO_LEV & (1<<i) ) ? 1 : 0;
}

inline void fnPulseClock(void)
{
//	usleep(100);		// 100 usec = .1 ms -> 10MHz

	usleep(20);
	fnOutPin(GPIO_TCK,1);
	usleep(50);
	fnOutPin(GPIO_TCK,0);
	usleep(30);
}

int fnOutputSilent(int tdi, int tms)
{
	fnOutPin(GPIO_TDI,tdi);
	fnOutPin(GPIO_TMS,tms);
	int tdo = fnInPin(GPIO_TDO);
	fnPulseClock();
	return tdo;
}

int fnOutput(int tdi, int tms)
{
	int tdo = fnOutputSilent(tdi,tms);
	printf("TDI: %d TMS: %d - TDO: %d\n", tdi, tms, tdo);
	return tdo;
}

void fnResetSilent(void)
{
	fnOutPin(GPIO_TMS,1);
	int i;
	for(i=0;i<6;i++)
		fnPulseClock();
}

void fnReset(void)
{
	printf("RESET\n");
	fnResetSilent();
}

void fnScanIR(void)
{
	fnReset();
	fnOutput(0,0);	// idle
	fnOutput(0,1);	// select DR
	fnOutput(0,1);	// select IR
	fnOutput(0,0);	// capture IR
	fnOutput(0,0);	// shift IR

	printf("\nScanIR:\n\n");

	int i,j;
	for(i=0;i<5;i++) {
		for(j=0;j<8;j++) {
			fnOutput(1,0);	// data
		}
		printf("\n");
	}
}

void fnScanDR(void)
{
	fnReset();
	fnOutput(0,0);	// idle
	fnOutput(0,1);	// select DR
	fnOutput(0,0);	// capture DR
	fnOutput(0,0);	// shift DR

	printf("\nScanDR:\n\n");

	int i,j;
	for(i=0;i<12;i++) {
		for(j=0;j<8;j++) {
			fnOutput(1,0);	// data
		}
		printf("\n");
	}
}

void fnScanPossibleIRLens(void)
{
	fnResetSilent();
	fnOutputSilent(0,0);	// idle
	fnOutputSilent(0,1);	// select DR
	fnOutputSilent(0,1);	// select IR
	fnOutputSilent(0,0);	// capture IR
	fnOutputSilent(0,0);	// shift IR

	int irlen, drlen;
	int i,j;
	for (i=0;i<1024;i++) 
		fnOutputSilent(1,0);	// flush zeros into IR
	
	for (irlen=0;irlen<1024;irlen++) 
		if (!fnOutputSilent(0,0))	// push zeros through until 0 pops out
			break;
	
	for (i=0;i<1024;i++)
		if (fnOutputSilent(1,0))	// push ones through until 1 pops out
			break;

	if (i != irlen) {
		printf("Length of 0 chain was %d, length of 1 chain was %d, probably a short...\n", i, irlen);
		return;
	}

	printf("Total IR length is %d\n", irlen);

	fnOutputSilent(0,1);	// exit1 IR
	fnOutputSilent(0,1);	// update IR
	fnOutputSilent(0,1);	// select DR
	fnOutputSilent(0,0);	// capture DR
	fnOutputSilent(0,0);	// shift DR

	for (drlen=0;drlen<1024;drlen++) 
		if (fnOutputSilent(1,0))	// push ones through until 1 pops out
			break;

	printf("Bypass DR length is %d (number of devices)\n", drlen);
	
	printf("\n");

	fnResetSilent();
	fnOutputSilent(0,0);	// idle
	fnOutputSilent(0,1);	// select DR
	fnOutputSilent(0,1);	// select IR
	fnOutputSilent(0,0);	// capture IR
	fnOutputSilent(0,0);	// shift IR

	j=0;
	for (i=0; i<irlen; i++) {
		if (fnOutputSilent(0,0)) {
			j=1;
		} else if (j) {
			j=0;
			printf("Possible IR start at %d\n", i-1);
		} else {
			j=0;
		}
	}
}

void fnScanChain(void)
{
	fnResetSilent();
	fnOutputSilent(0,0);	// idle
	fnOutputSilent(0,1);	// select DR
	fnOutputSilent(0,0);	// capture DR
	fnOutputSilent(0,0);	// shift DR

	printf("\nScanChain:\n\n");

	int i,j,bit;
	for( i=0; i<100; i++ )
	{
		bit = fnOutputSilent(1,0);
		if (bit == 0) {
			printf("%8d unrecognised device with no IDCODE\n",0);
		} else {
			unsigned long id = 1<<31;
			for(j=0;j<31;j++) {
				id >>= 1;
				id  |= fnOutputSilent(1,0)<<31;
			}
			char* manuf="";
			char* part="unrecognised device";
			if ((id&0xfff)==0x093) {
				manuf="Xilinx ";
				if ( (id&0xffff000) == 0x5045000 )
					part="XCF02S";
				else if ( (id&0xffff000) == 0x141c000 )
					part="XC3S400";
			} else if (id == 0xffffffff) {
				printf("%08X end of chain\n", id );
				return;
			}
			printf("%08X %s%s\n", id, manuf, part);
		}
	}

}

int main(int argc, char **argv)
{
	// Set up gpi pointer for direct register access
	setup_io();

	// set pin directions
	fnPinDirectionOutput(GPIO_TMS);
	fnPinDirectionOutput(GPIO_TCK);
	fnPinDirectionOutput(GPIO_TDI);
	fnPinDirectionInput (GPIO_TDO);

	// tests
//	fnScanDR();
//	fnScanIR();
	fnScanPossibleIRLens();
	fnScanChain();

	fnResetSilent();
}


