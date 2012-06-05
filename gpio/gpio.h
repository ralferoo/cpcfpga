#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define PROM_XCF02S	0xf5045093
#define FPGA_XC3S400	0x0141C093

#define HEX_BLOCK_SIZE  16

struct Device {
	struct Device *next;

	unsigned long id;
	int hir, tir, hdr, tdr, len;
	int bsrlen, bsrsample, bsrsafe;

	char *manuf, *name;
};

int jtagOutput(int tdi, int tms);
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
void jtagBoundaryScanDump(struct Device *device);

///////////////////////////////////////////////////////////////////////////

void devFreeDevices(void);
struct Device* devFindDevice(unsigned long id);
void devScanDevices(void);
void devDump(void);
struct Device *devGetFirstDevice(void);

///////////////////////////////////////////////////////////////////////////

void hexByte( uint8_t byte );
void hexEndLine(void);
void hexStart( uint8_t type, uint16_t faddr, uint8_t len );
void hexAddrHigh( uint16_t hiaddr );
void hexEndOfFile();

///////////////////////////////////////////////////////////////////////////

int HEX_Early( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data);
int HEX_Null( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data);
void hexStartFile( int (*fn)( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data) );
void hexStartLine( void );
int hexProcessData( uint8_t** ppBuffer, int DataLength );
void hexReadStream( int fd );

///////////////////////////////////////////////////////////////////////////

void promValidate(struct Device* prom);
void promDumpBlock( int faddr, struct Device *device);
void promDump(struct Device* prom);
void promErase(struct Device* prom);
void promProgramStart(struct Device *prom);
int promProgramData(uint8_t type, uint8_t len, uint16_t addr, uint8_t *data);
void promReload(struct Device* prom);

///////////////////////////////////////////////////////////////////////////

void jtagInit(void);

///////////////////////////////////////////////////////////////////////////
