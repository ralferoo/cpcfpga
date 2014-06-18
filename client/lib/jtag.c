#include <time.h>
#include <errno.h>

#include "sidecar.h"

#define MAX_CHAIN_LEN 50

int g_noisy = 0;

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

//inline 
char* get_jtag_state_name(void)
{
	return jtag_state<JTAG_STATE_MAX ? jtag_state_names[jtag_state] : "???";
}

///////////////////////////////////////////////////////////////////////////

unsigned long long tot_nanos = 0;

void nsleep(long nanos)
{
	tot_nanos += nanos;
#ifdef _MSC_VER
	// why are we even sleeping client side!
#else
#if 1
	usleep(nanos);

	struct timespec tv;
	tv.tv_sec = 0;
	tv.tv_nsec = nanos;

	while (EINTR==nanosleep(&tv, &tv));
#else
	nanos /= 5; // 6 seems to be the absolute lowest...
	while (nanos--) {
		asm("nop");		// 750MHz -> more than 1 nano per nop
	}
#endif
#endif
}

///////////////////////////////////////////////////////////////////////////

void jtagChangeState(int tms)
{
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
}

void jtagChangeStates(int count,int tms)
{
	while (count)
		jtagChangeState(count--?tms:0);
}

int jtagOutputSilent(int tdi, int tms)
{
	int tdo = jtagLowlevelClock(tdi, tms);
	jtagChangeState(tms);
	return tdo;
}

void jtagOutputSilentRO(int tdi, int tms)
{
	jtagLowlevelClockRO(tdi, tms);
	jtagChangeState(tms);
}

int jtagOutput(int tdi, int tms)
{
	char* pstate="";
	if (g_noisy)
		pstate = get_jtag_state_name();

	int tdo = jtagOutputSilent(tdi,tms);

	if (g_noisy) {
		char* nstate = get_jtag_state_name();

		printf("TDI: %d TMS: %d - TDO: %d (%s->%s)\n", tdi, tms, tdo, pstate, nstate);
	}

	return tdo;
}

void jtagOutputRO(int tdi, int tms)
{
	char* pstate="";
	if (g_noisy)
		pstate = get_jtag_state_name();

	jtagOutputSilentRO(tdi,tms);

	if (g_noisy) {
		char* nstate = get_jtag_state_name();

		printf("TDI: %d TMS: %d (%s->%s)\n", tdi, tms, pstate, nstate);
	}
}

void jtagResetSilent(void)
{
//	pinOutput(GPIO_TMS,1);
	int i;
	for(i=0;i<7;i++) {
		jtagLowlevelClockRO(1,1);
		//jtagPulseClock();
	}

	jtag_state = JTAG_STATE_RESET;
}

void jtagReset(void)
{
	jtagResetSilent();

	if (g_noisy)
		printf("RESET\n");
}

void jtagIdle(void)
{
	switch (jtag_state) {
	default:
		jtagReset();

	case JTAG_STATE_RESET:
        case JTAG_STATE_UPDATE:
        case JTAG_STATE_IDLE:
		jtagOutputRO(0,0);
		break;

        case JTAG_STATE_SELECT_DR:
        case JTAG_STATE_SELECT_IR:
		jtagOutputRO(0,0);
        case JTAG_STATE_CAPTURE:
        case JTAG_STATE_SHIFT:
        case JTAG_STATE_PAUSE:
		jtagOutputRO(0,1);

        case JTAG_STATE_EXIT1:
        case JTAG_STATE_EXIT2:
		jtagOutputRO(0,1);
		jtagOutputRO(0,0);
                break;
	}
		
	if (jtag_state != JTAG_STATE_IDLE) {
		printf("Invalid state transitioning to IDLE: %s\n", get_jtag_state_name() );
		jtagExit();
		exit(1);
	}
}

void jtagSelectDR(void)
{
	switch (jtag_state) {
	default:
		jtagReset();

	case JTAG_STATE_RESET:
		jtagOutputRO(0,0);

        case JTAG_STATE_UPDATE:
        case JTAG_STATE_IDLE:
		jtagOutputRO(0,1);
		break;

        case JTAG_STATE_SELECT_DR:
		break;

        case JTAG_STATE_SELECT_IR:
		jtagOutputRO(0,0);

        case JTAG_STATE_CAPTURE:
        case JTAG_STATE_SHIFT:
        case JTAG_STATE_PAUSE:
		jtagOutputRO(0,1);

        case JTAG_STATE_EXIT1:
        case JTAG_STATE_EXIT2:
		jtagOutputRO(0,1);
		jtagOutputRO(0,1);
                break;
	}
		
	if (jtag_state != JTAG_STATE_SELECT_DR) {
		printf("Invalid state transitioning to SELECT_DR: %s\n", get_jtag_state_name() );
		jtagExit();
		exit(1);
	}
}

void jtagSelectIR(void)
{
	switch (jtag_state) {
	default:
		jtagSelectDR();
		jtagOutputRO(0,1);
        case JTAG_STATE_SELECT_IR:
		break;
	}
		
	if (jtag_state != JTAG_STATE_SELECT_IR) {
		printf("Invalid state transitioning to SELECT_IR: %s\n", get_jtag_state_name() );
		jtagExit();
		exit(1);
	}
}

void jtagShiftDR(void)
{
	jtagSelectDR();
	jtagOutputRO(0,0);		// capture
	jtagOutputRO(0,0);		// shift
		
	if (jtag_state != JTAG_STATE_SHIFT) {
		printf("Invalid state transitioning to SHIFT: %s\n", get_jtag_state_name() );
		jtagExit();
		exit(1);
	}
}

void jtagShiftIR(void)
{
	jtagSelectIR();
	jtagOutputRO(0,0);		// capture
	jtagOutputRO(0,0);		// shift
		
	if (jtag_state != JTAG_STATE_SHIFT) {
		printf("Invalid state transitioning to SHIFT: %s\n", get_jtag_state_name() );
		jtagExit();
		exit(1);
	}
}

uint32_t jtagShiftData( uint32_t value, int len, int header, int trailer)
{
	if (g_noisy)
		printf("ShiftData(value=0x%x, len=%d, header=%d, trailer=%d)\n", value, len, header, trailer);

	if (jtag_state != JTAG_STATE_SHIFT) {
		printf("Invalid state should be in SHIFT: %s\n", get_jtag_state_name() );
		jtagExit();
		exit(1);
	}

#ifdef USB_SPEEDUP
	unsigned char bytes[64];
	if( header) {
		memset(bytes, 0xff, (header+7)>>3 );
		jtagSendAndReceiveBits(0, header, bytes, NULL);
	}
	
	unsigned char obytes[4];
	obytes[0] =  value        & 0xff;
	obytes[1] = (value >>  8) & 0xff;
	obytes[2] = (value >> 16) & 0xff;
	obytes[3] = (value >> 24) & 0xff;

	unsigned char ibytes[4];
	jtagSendAndReceiveBits(trailer==0, len, obytes, ibytes);

	value = ibytes[0] | (ibytes[1]<<8) | (ibytes[2]<<16) | (ibytes[3]<<24);
	
	if (trailer) {
		memset(bytes, 0xff, (trailer+7)>>3 );
		jtagSendAndReceiveBits(1, trailer, bytes, NULL);
	}
//	jtagChangeState(1);
#else
	int i;
	int bit;

	if (g_noisy && header)
		printf("Doing header of %d bits\n", header);

	for (i=0; i<header;i++)
		jtagOutput(1,0);		// bypass to all in header

	if (g_noisy)
		printf("Doing data of %d-1 bits\n", len);

	for (i=0; i<len-1; i++) {
		bit = jtagOutput(value&1,0);
		value >>= 1;
		value |= bit << (len-1);
	}					// send all but last bit
	
	if (trailer) {
		if (g_noisy)
			printf("Doing terminal bit plus trailer of %d bits\n", trailer);

		bit = jtagOutput(value&1,0);
		value >>= 1;
		value |= bit << (len-1);

		for (i=1; i<trailer; i++)
			jtagOutput(1,0);	// send all but last of trailer

		jtagOutput(1,1);		// last bit of trailer
	} else {
		if (g_noisy)
			printf("Doing terminal bit\n");

		bit = jtagOutput(value&1,1);
		value >>= 1;
		value |= bit << (len-1);
	}
#endif

	jtagOutput(1,1);			// move from exit to update
	if (jtag_state != JTAG_STATE_UPDATE) {
		printf("Invalid state transitioning to UPDATE: %s\n", get_jtag_state_name() );
		jtagExit();
		exit(1);
	}

	return value;
}

uint32_t jtagSendIR( uint32_t value, struct Device *device)
{
	jtagShiftIR();
	return jtagShiftData(value,device->len,device->hir,device->tir);
}

uint32_t jtagSendDR( uint32_t value, int len, struct Device *device)
{
	jtagShiftDR();
	return jtagShiftData(value,len,device->hdr,device->tdr);
}

void jtagUpdateOrIdle(void)
{
	switch (jtag_state) {
	default:
		jtagReset();

	case JTAG_STATE_RESET:
		jtagOutputRO(0,0);

        case JTAG_STATE_UPDATE:
        case JTAG_STATE_IDLE:
		break;

        case JTAG_STATE_SELECT_DR:
		jtagOutputRO(0,1);

        case JTAG_STATE_SELECT_IR:
		jtagOutputRO(0,1);
		jtagOutputRO(0,0);
		break;

        case JTAG_STATE_CAPTURE:
        case JTAG_STATE_SHIFT:
        case JTAG_STATE_PAUSE:
		jtagOutputRO(0,1);

        case JTAG_STATE_EXIT1:
        case JTAG_STATE_EXIT2:
		jtagOutputRO(0,1);
                break;
	}
		
	if (jtag_state != JTAG_STATE_UPDATE && jtag_state != JTAG_STATE_IDLE) {
		printf("Invalid state transitioning to IDLE or UPDATE: %s\n", get_jtag_state_name() );
		jtagExit();
		exit(1);
	}
}

/*
void jtagScanIR(void)
{
	jtagReset();
	jtagShiftIR();

	printf("\nScanIR:\n\n");

	int i,j;
	for(i=0;i<5;i++) {
		for(j=0;j<8;j++) {
			jtagOutput(1,0);	// data
		}
		printf("\n");
	}
}

void jtagScanDR(void)
{
	jtagReset();
	jtagShiftDR();

	printf("\nScanDR:\n\n");

	int i,j;
	for(i=0;i<12;i++) {
		for(j=0;j<8;j++) {
			jtagOutput(1,0);	// data
		}
		printf("\n");
	}
}
*/

///////////////////////////////////////////////////////////////////////////

void devFreeDevices(void)
{
	while (g_firstDevice) {
		struct Device *device = g_firstDevice;
		g_firstDevice = device->next;
		free(device);
	}
}

struct Device* devFindDevice(uint32_t id)
{
	struct Device *device = g_firstDevice;
	while (device) {
//		printf("%x vs %x\n", id, device->logical_id);
		if (device->logical_id == id) {
//			printf("matched %x vs %x\n", id, device->logical_id);
			return device;
		}
		device = device->next;
	}

	return 0;
}

void devScanDevices(void)
{
	devFreeDevices();

	int retry=2;
	int irlen, drlen;
	int i,j;
	for (;;) {

	jtagReset();
	jtagShiftIR();

	for (i=0;i<MAX_CHAIN_LEN;i++) 
		jtagOutputRO(1,0);	// flush ones into IR
//	printf("Outputted %d 1s\n", i);
	
	for (irlen=0;irlen<MAX_CHAIN_LEN;irlen++) 
		if (!jtagOutput(0,0))	// push zeros through until 0 pops out
			break;
//	printf("Outputted %d 0s\n", irlen);
	
	for (i=0;i<MAX_CHAIN_LEN;i++)
		if (jtagOutput(1,0))	// push ones through until 1 pops out
			break;
//	printf("Outputted %d 1s\n", i);

	if (i != irlen) {
		printf("Length of 0 chain was %d, length of 1 chain was %d, probably a short...\n", i, irlen);
		if (retry--) 
			continue;
		return;
	}

	break;
	}

	// as we've left all IRs in bypass mode, we might as well scan 
	// DR length when everything in bypass...

	jtagShiftDR();

	for (drlen=0;drlen<MAX_CHAIN_LEN;drlen++) 
		if (jtagOutput(1,0))	// push ones through until 1 pops out
			break;

#ifdef OUTPUT_LENGTHS
	printf("Total IR length is %d\n", irlen);
	printf("Bypass DR length is %d (number of devices)\n", drlen);
	printf("\n");
#endif

#ifdef SCAN_POSSIBLE_IR_START_POINTS
	jtagReset();
	jtagShiftIR();

	j=0;
	for (i=0; i<irlen; i++) {
		if (jtagOutput(0,0)) {
			j=1;
		} else if (j) {
			j=0;
			printf("Possible IR start at %d\n", i-1);
		} else {
			j=0;
		}
	}
#endif

	int hir=0, tir=irlen, hdr=0, tdr=drlen;

	jtagReset();
	jtagShiftDR();

//	printf("\nScanChain:\n\n");

	for( i=0; i<MAX_CHAIN_LEN; i++ )
	{
		int ir=-1;
		int bit, len;
		char *manuf, *part;

		bit = jtagOutput(1,0);
		if (bit == 0) {
			part = "unrecognised device with no IDCODE";
		} else {
			int bsrlen=0, bsrsample=0, bsrsafe=0;
			uint32_t id = 0x80000000UL; //1U<<31;
			for(j=0;j<31;j++) {
				id >>= 1;
				//id  |= jtagOutput(1,0)<<31;
				if (jtagOutput(1,0))
					id |= 0x80000000UL;
				//printf("id now %lx\n", id);
			}
			manuf="";
			part="unrecognised device";
			len = 0;
			if ((id&0xfff)==0x093) {
				manuf="Xilinx ";
				if ( (id&0xffff000) == 0x5045000 ) {
					part="XCF02S";
					len = 8;
					bsrlen = 25;
					bsrsample = 1;
					bsrsafe = 0;
				} else if ( (id&0xffff000) == 0x0141c000 ) {
					part="XC3S400";
					len = 6;
					bsrlen = 815;
					bsrsample = 1;
					bsrsafe = 1;
				}
			} else if (id == 0xffffffff) {
				//printf("%08X end of chain\n", id );
				break;
			}

			struct Device *device = malloc(sizeof(struct Device));
			device->next = g_firstDevice;
			device->manuf = manuf;
			device->name = part;
			device->id = id;
			device->logical_id = id & 0xfffffff;
			device->hir = hir;
			device->hdr = hdr;
			device->tir = tir - len;
			device->tdr = tdr - 1;
			device->len = len;
			device->bsrlen = bsrlen;
			device->bsrsafe = bsrsafe;
			device->bsrsample = bsrsample;
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

	jtagReset();

	if (tdr != 0 || tir != 0 ) {
		printf("Unexpected end of chain, tir=%d tdr=%d\n", tir, tdr);
	}
}

///////////////////////////////////////////////////////////////////////////

void jtagBoundaryScanDump(struct Device *device)
{
	if (device->bsrsample <= 0 || device->bsrlen <= 0) {
		printf("Boundary scan not supported on %s\n", device->name);
		return;
	}

	printf("Boundary scan of %s (%d bits):\n\n", device->name, device->bsrlen);
	printf("     01234 56789 01234 56789 01234 56789 01234 56789 01234 56789 01234 56789\n");
	printf("     ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----");
	jtagReset();
	jtagSendIR(device->bsrsample, device);
	jtagShiftDR();

	int i;
	for (i=0; i<device->hdr; i++)
		jtagOutputRO(0,0);              // ignore all data before the data we want

	int before_tms = device->bsrlen + device->tdr;
	for (i=0; i<device->bsrlen; i++) {
		int bit = jtagOutput(device->bsrsafe, --before_tms == 0);
		if ( (i%60) == 0 )
			printf("\n%3d:", i);
		if ( (i%5) == 0)
			printf(" ");
		printf("%d", bit);
	}
	for (i=0; i<device->tdr; i++)
		jtagOutputRO(0, --before_tms == 0);     // complete cycle
	printf("\n");

	jtagSendIR( (1<<device->len)-1, device);	// bypass
}

///////////////////////////////////////////////////////////////////////////

void devDump(void)
{
	printf("Devices:\n");
	printf(" %-7s %-10s%-40s  %3s %3s %3s %3s %3s\n", "IDCODE", "Manuf ", "Device name", "len", "hir", "tir", "hdr", "tdr");

	struct Device *device = g_firstDevice;
	while (device) {
		printf("%08X %-10s%-40s %3d %3d %3d %3d %3d\n",
			device->id, device->manuf, device->name, device->len,
			device->hir, device->tir,
			device->hdr, device->tdr);
		device = device->next;
	}
}

struct Device *devGetFirstDevice(void)
{
	return g_firstDevice;
}

///////////////////////////////////////////////////////////////////////////
