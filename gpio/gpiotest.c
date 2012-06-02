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

int g_noisy = 1;

struct Device {
	struct Device *next;

	unsigned long id;
	int hir, tir, hdr, tdr, len;

	char *name;
};

struct Device *g_firstDevice = 0;

enum JTAG_STATE {
        JTAG_STATE_UNKNOWN = 0,
        JTAG_STATE_RESET,
        JTAG_STATE_IDLE,

        JTAG_STATE_SELECT_DR,
        JTAG_STATE_SELECT_IR,

        JTAG_STATE_CAPTURE,
        JTAG_STATE_SHIFT,
        JTAG_STATE_EXIT1,
        JTAG_STATE_PAUSE,
        JTAG_STATE_EXIT2,
        JTAG_STATE_UPDATE,

        JTAG_STATE_MAX
};

enum JTAG_STATE jtag_state = JTAG_STATE_UNKNOWN;

char *jtag_state_names[JTAG_STATE_MAX] = {
        "UNKNOWN",
        "RESET",
        "IDLE",

        "SELECT_DR",
        "SELECT_IR",

        "CAPTURE",
        "SHIFT",
        "EXIT1",
        "PAUSE",
        "EXIT2",
        "UPDATE",
};

inline char* get_jtag_state_name(void)
{
	return jtag_state<JTAG_STATE_MAX ? jtag_state_names[jtag_state] : "???";
}

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

	switch(jtag_state) {
	case JTAG_STATE_RESET:
		jtag_state = tms ? JTAG_STATE_RESET : JTAG_STATE_IDLE;
		break;

	case JTAG_STATE_IDLE:
		jtag_state = tms ? JTAG_STATE_SELECT_DR : JTAG_STATE_IDLE;
		break;

	case JTAG_STATE_SELECT_DR:
		jtag_state = tms ? JTAG_STATE_SELECT_IR : JTAG_STATE_CAPTURE;
		break;

	case JTAG_STATE_SELECT_IR:
		jtag_state = tms ? JTAG_STATE_RESET : JTAG_STATE_CAPTURE;
		break;

	case JTAG_STATE_CAPTURE:
	case JTAG_STATE_SHIFT:
		jtag_state = tms ? JTAG_STATE_EXIT1 : JTAG_STATE_SHIFT;
		break;

	case JTAG_STATE_EXIT1:
		jtag_state = tms ? JTAG_STATE_UPDATE : JTAG_STATE_PAUSE;
		break;

	case JTAG_STATE_PAUSE:
		jtag_state = tms ? JTAG_STATE_EXIT2 : JTAG_STATE_PAUSE;
		break;

	case JTAG_STATE_EXIT2:
		jtag_state = tms ? JTAG_STATE_UPDATE : JTAG_STATE_SHIFT;
		break;

	case JTAG_STATE_UPDATE:
		jtag_state = tms ? JTAG_STATE_SELECT_DR : JTAG_STATE_IDLE;
		break;

	default:
		jtag_state = JTAG_STATE_UNKNOWN;
	}

	return tdo;
}

int fnOutput(int tdi, int tms)
{
	char* pstate;
	if (g_noisy)
		pstate = get_jtag_state_name();

	int tdo = fnOutputSilent(tdi,tms);

	if (g_noisy) {
		char* nstate = get_jtag_state_name();

		printf("TDI: %d TMS: %d - TDO: %d (%s->%s)\n", tdi, tms, tdo, pstate, nstate);
	}

	return tdo;
}

void fnResetSilent(void)
{
	fnOutPin(GPIO_TMS,1);
	int i;
	for(i=0;i<5;i++)
		fnPulseClock();

	jtag_state = JTAG_STATE_RESET;
}

void fnReset(void)
{
	fnResetSilent();

	if (g_noisy)
		printf("RESET\n");
}

void fnIdle(void)
{
	switch (jtag_state) {
	default:
		fnReset();

	case JTAG_STATE_RESET:
        case JTAG_STATE_UPDATE:
        case JTAG_STATE_IDLE:
		fnOutput(0,0);
		break;

        case JTAG_STATE_SELECT_DR:
        case JTAG_STATE_SELECT_IR:
		fnOutput(0,0);
        case JTAG_STATE_CAPTURE:
        case JTAG_STATE_SHIFT:
        case JTAG_STATE_PAUSE:
		fnOutput(0,1);

        case JTAG_STATE_EXIT1:
        case JTAG_STATE_EXIT2:
		fnOutput(0,1);
		fnOutput(0,0);
                break;
	}
		
	if (jtag_state != JTAG_STATE_IDLE) {
		printf("Invalid state transitioning to IDLE: %s\n", get_jtag_state_name() );
		exit(1);
	}
}

void fnSelectDR(void)
{
	switch (jtag_state) {
	default:
		fnReset();

	case JTAG_STATE_RESET:
        case JTAG_STATE_UPDATE:
        case JTAG_STATE_IDLE:
		fnOutput(0,1);
		break;

        case JTAG_STATE_SELECT_DR:
		break;

        case JTAG_STATE_SELECT_IR:
		fnOutput(0,1);
		fnOutput(0,0);
		fnOutput(0,1);
		break;

        case JTAG_STATE_CAPTURE:
        case JTAG_STATE_SHIFT:
        case JTAG_STATE_PAUSE:
		fnOutput(0,1);

        case JTAG_STATE_EXIT1:
        case JTAG_STATE_EXIT2:
		fnOutput(0,1);
		fnOutput(0,1);
                break;
	}
		
	if (jtag_state != JTAG_STATE_SELECT_DR) {
		printf("Invalid state transitioning to SELECT_DR: %s\n", get_jtag_state_name() );
		exit(1);
	}
}

void fnSelectIR(void)
{
	switch (jtag_state) {
	default:
		fnSelectDR();
		fnOutput(0,1);
        case JTAG_STATE_SELECT_IR:
		break;
	}
		
	if (jtag_state != JTAG_STATE_SELECT_IR) {
		printf("Invalid state transitioning to SELECT_IR: %s\n", get_jtag_state_name() );
		exit(1);
	}
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

void fnFreeDevices(void)
{
	while (g_firstDevice) {
		struct Device *device = g_firstDevice;
		g_firstDevice = device->next;
		free(device);
	}
}

void fnScanDevices(void)
{
	fnFreeDevices();

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

	// as we've left all IRs in bypass mode, we might as well scan 
	// DR length when everything in bypass...

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

	int hir=0, tir=irlen, hdr=0, tdr=drlen;

	fnResetSilent();
	fnOutputSilent(0,0);	// idle
	fnOutputSilent(0,1);	// select DR
	fnOutputSilent(0,0);	// capture DR
	fnOutputSilent(0,0);	// shift DR

//	printf("\nScanChain:\n\n");

	for( i=0; i<100; i++ )
	{
		int ir=-1;
		int bit, len;
		char* part;

		bit = fnOutputSilent(1,0);
		if (bit == 0) {
			part = "unrecognised device with no IDCODE";
		} else {
			unsigned long id = 1<<31;
			for(j=0;j<31;j++) {
				id >>= 1;
				id  |= fnOutputSilent(1,0)<<31;
			}
			part="unrecognised device";
			if ((id&0xfff)==0x093) {
				part="Xilinx unrecognised device";
				if ( (id&0xffff000) == 0x5045000 ) {
					part="Xilinx XCF02S";
					len = 8;
				} else if ( (id&0xffff000) == 0x141c000 ) {
					part="Xilinx XC3S400";
					len = 6;
				}
			} else if (id == 0xffffffff) {
				//printf("%08X end of chain\n", id );
				break;
			}

			struct Device *device = malloc(sizeof(struct Device));
			device->next = g_firstDevice;
			device->name = part;
			device->id = id;
			device->hir = hir;
			device->hdr = hdr;
			device->tir = tir - len;
			device->tdr = tdr - 1;
			device->len = len;
			g_firstDevice = device;
		}

		if (len > 0) {
			hir += len;
			tir -= len;
			hdr++;
			tdr--;
		} else {
			hir = tir = hdr = tdr = -1;
			break;
		}
	}

	fnResetSilent();

	if (tdr != 0 || tir != 0 ) {
		printf("Unexpected end of chain, tir=%d tdr=%d\n", tir, tdr);
	}

	printf("\nDevices:\n");
	printf(" %-7s %-50s  %3s %3s %3s %3s %3s\n", "IDCODE", "Device name", "len", "hir", "tir", "hdr", "tdr");

	struct Device *device = g_firstDevice;
	while (device) {
		printf("%08X %-50s %3d %3d %3d %3d %3d\n",
			device->id, device->name, device->len,
			device->hir, device->tir,
			device->hdr, device->tdr);
		device = device->next;
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
	fnOutPin(GPIO_TMS,1);
	fnOutPin(GPIO_TCK,0);

	// tests
//	fnScanDR();
//	fnScanIR();
	fnScanDevices();

	fnScanDR();
	fnScanIR();

	exit(0);
}


