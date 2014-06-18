#define OUTPUT_LENGTHS

#include <stdbool.h>
#include <string.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#ifndef _MSC_VER
#	include <unistd.h>
#endif

#define USB_SPEEDUP

#define PROM_XCF02S	0x05045093
#define FPGA_XC3S400	0x0141C093

#define FPGA_USERCODE	0x4350433F
#define FPGA_USERCODE2	0x46524143

#define HEX_BLOCK_SIZE  16

struct Device {
	struct Device *next;

	uint32_t id, logical_id;
	int hir, tir, hdr, tdr, len;
	int bsrlen, bsrsample, bsrsafe;
	int user;

	char *manuf, *name;
};

#define BC_1		0x101
#define BC_2		0x102

#define BC_F_INTERNAL	0x201
#define BC_F_INPUT	0x202
#define BC_F_OUTPUT3	0x203
#define BC_F_CONTROLR	0x204

struct BoundaryScan {
	int cellnum, type;
	char* port;
	int function, safe;
	int control, disable_control, disable_result;
}; 

///////////////////////////////////////////////////////////////////////////

void nsleep(long nanos);

int getAtmegaRAM(unsigned char *ram);
void jtagLog(void);
void jtagInit(void);
void jtagExit(void);
int jtagLowlevelClock(int tdi, int tms);
void jtagLowlevelClockRO(int tdi, int tms);

///////////////////////////////////////////////////////////////////////////

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
void jtagSendAndReceiveBits(int tms_at_end, int num_bits, unsigned char* send, unsigned char* recv);
void jtagFlush();
void jtagChangeState(int tms);
int jtagGetState(bool log);

///////////////////////////////////////////////////////////////////////////

void devFreeDevices(void);
struct Device* devFindDevice(uint32_t id);
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

void promBoot(int jtag);

///////////////////////////////////////////////////////////////////////////

void make_ir_stream(char* sample, struct Device *first, struct Device *second, int mir, 
		 int first_cmd, int second_cmd);
void send_ir_stream(char* ir_stream, int totir);
void sample_dr_stream(char* dr_stream, int totdr);
void send_dr_stream(char* dr_stream, int totdr, char* result_stream);
void dump_dr_stream(const char* name, char* dr_stream, int totdr);
void diff_dr_stream(const char* name, const char* ignore, char* dr_stream, char* dr2_stream, int totdr, struct Device *fpga, struct Device *prom, int dbgid);
void copy_safe_bits(char* safe_dr, int totdr, struct Device *device, struct BoundaryScan *cells);
void make_safe_dr_stream(char* safe_dr, int totdr, struct Device *fpga, struct Device *prom);
void test_candidate_pins(char* safe_dr, int totdr, struct Device *fpga, struct Device *prom);
void real_test_pin( struct Device *device, struct BoundaryScan* cells,
		char* safe_dr, int totdr, char* test_dr, char* test2_dr, char* test3_dr,
		struct Device *fpga, struct Device *prom);
void test_pin( struct Device *device, char* pin, char* safe_dr, int totdr, char* test_dr, char* test2_dr, char* test3_dr,
		struct Device *fpga, struct Device *prom);
void find_pin( struct Device *device, char* pin, struct Device *fpga, struct Device *prom,
		int *read_pin, int *write_pin, int *control_pin, int *control_disable);

///////////////////////////////////////////////////////////////////////////

uint32_t fpgaUserCode(struct Device* fpga);
void fpgaValidate(struct Device* fpga);

void cpcSetCommand(struct Device* fpga, unsigned char command);
uint32_t cpcTransferData(struct Device* fpga, uint32_t value);

///////////////////////////////////////////////////////////////////////////

int atmegaReboot( void );
int atmegaBootloader( void );

///////////////////////////////////////////////////////////////////////////

int usbControlMessage( int requesttype, int request, int value, int index, char *bytes, int size, int timeout);

///////////////////////////////////////////////////////////////////////////
// jtag_bus_ctl_3.vhd interface

void fpga_user_set(struct Device *fpga, int addr, int val);
int fpga_user_get(struct Device *fpga, int addr);
