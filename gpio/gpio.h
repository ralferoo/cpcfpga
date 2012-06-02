#include <stdint.h>

#define PROM_XCF02S 0xf5045093

struct Device {
	struct Device *next;

	unsigned long id;
	int hir, tir, hdr, tdr, len;

	char *name;
};

int jtagOutputSilent(int tdi, int tms);
int jtagOutput(int tdi, int tms);
void jtagResetSilent(void);
void jtagReset(void);
void jtagIdle(void);
void jtagSelectDR(void);
void jtagSelectIR(void);
void jtagShiftDR(void);
void jtagShiftIR(void);
uint32_t jtagSendIR( uint32_t value, struct Device *device);
uint32_t jtagSendDR( uint32_t value, int len, struct Device *device);
void jtagUpdateOrIdle(void);
void jtagRunTestTCK( unsigned int i );
void jtagScanIR(void);
void jtagScanDR(void);

///////////////////////////////////////////////////////////////////////////

void devFreeDevices(void);
struct Device* devFindDevice(unsigned long id);
void devScanDevices(void);

///////////////////////////////////////////////////////////////////////////

void hexByte( uint8_t byte );
void hexEndLine(void);
void hexStart( uint8_t type, uint16_t faddr, uint8_t len );
void hexAddrHigh( uint16_t hiaddr );
void hexEndOfFile();

///////////////////////////////////////////////////////////////////////////

void promValidate(struct Device* prom);
void promDumpBlock( int faddr, struct Device *device);
void promDump(struct Device* prom);

///////////////////////////////////////////////////////////////////////////

void jtagInit(void);

///////////////////////////////////////////////////////////////////////////
