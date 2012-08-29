
// PROM programming made easy by being the last on the chain
// so, it's instructions and data are first out and in, and we can send pad bits at the end

#include "sidecar.h"
#include "server.h"
#include "jtag.h"
#include "prom.h"
#include "hex.h"

extern int prom_hir_len, prom_tir_len, prom_hdr_len, prom_tdr_len;

static bool have_scanned_prom = 0;

bool PROM_Present( void )
{
	if( !have_scanned_prom) {
		JTAG_ChainInfo();
		have_scanned_prom = 1;
	}
	if( prom_hir_len < 0 ) {
		WriteStringConst( PSTR("# No PROM found\r\n") );
		return 0;
	}
	return 1;
}

void PROM_Erase( void )
{
	int hir_len = prom_hir_len, hdr_len = prom_hdr_len, tir_len = prom_tir_len, tdr_len = prom_tdr_len;

	// idcode
	JTAG_SendIR( 0xfe, 8, hir_len, tir_len );
	uint32_t idcode = JTAG_SendDR( 0, 32, hdr_len, tdr_len );

	char* PROGMEM status = PSTR("wrong chip");
	bool ok = 0;
	if( idcode == 0xf5045093 ) {
		status = PSTR("XCF02S");
		ok = 1;
	}

	sprintf_P( output_buffer, PSTR("# idcode=%04X%04X - %S\r\n"), (uint16_t) (idcode>>16), (uint16_t) idcode, status );
	WriteString(output_buffer);

	if( !ok) return;

	// ISC_DISABLE conld instruction
	JTAG_SendIR( 0xf0, 8, hir_len, tir_len );
	JTAG_RunTestTCK(110000);
	uint16_t protect = (uint16_t) JTAG_SendIR( 0xff, 8, hir_len, tir_len );

	status = PSTR("writable");
	if( (protect&7) != 1 ) {
		status = PSTR("unwritable");
		ok = 0;
	}

	sprintf_P( output_buffer, PSTR("# protect=%02X - %S\r\n"), protect, status );
	WriteString(output_buffer);
	
	if( !ok) return;

	// bypass instruction
	JTAG_SendIR( 0xff, 8, hir_len, tir_len );
	// ISC_ENABLE ispen instruction
	JTAG_SendIR( 0xe8, 8, hir_len, tir_len );
	JTAG_SendDR( 0x34, 6, hdr_len, tdr_len );

	// ISC_ADDRESS_SHIFT faddr instruction
	JTAG_SendIR( 0xeb, 8, hir_len, tir_len );
	JTAG_SendDR( 1, 16, hdr_len, tdr_len );
	JTAG_RunTestTCK(2);

	// ISC_ERASE ferase instruction
	JTAG_SendIR( 0xec, 8, hir_len, tir_len );

	WriteStringConst( PSTR("# Waiting for erase to complete") );
	for( int i=0; i<20; i++ ) {
		WriteString( "." );
		Endpoint_ClearIN();
		Endpoint_WaitUntilReady();
		JTAG_RunTestTCK(15000000/20);
	}

	WriteString( "\r\n" );
}

static bool prom_in_block;
static uint16_t prom_addr_hi, prom_addr_lo, prom_addr_lo_start;

void PROM_Program( void )
{
	int hir_len = prom_hir_len, hdr_len = prom_hdr_len, tir_len = prom_tir_len, tdr_len = prom_tdr_len;

	// idcode
	JTAG_SendIR( 0xfe, 8, hir_len, tir_len );
	uint32_t idcode = JTAG_SendDR( 0, 32, hdr_len, tdr_len );

	char* PROGMEM status = PSTR("wrong chip");
	bool ok = 0;
	if( idcode == 0xf5045093 ) {
		status = PSTR("XCF02S");
		ok = 1;
	}

	sprintf_P( output_buffer, PSTR("# idcode=%04X%04X - %S\r\n"), (uint16_t) (idcode>>16), (uint16_t) idcode, status );
	WriteString(output_buffer);

	if( !ok) return;

	// ISC_DISABLE conld instruction
	JTAG_SendIR( 0xf0, 8, hir_len, tir_len );
	JTAG_RunTestTCK(110000);
	uint16_t protect = (uint16_t) JTAG_SendIR( 0xff, 8, hir_len, tir_len );

	status = PSTR("writable");
	if( (protect&7) != 1 ) {
		status = PSTR("unwritable");
		ok = 0;
	}

	sprintf_P( output_buffer, PSTR("# protect=%02X - %S\r\n"), protect, status );
	WriteString(output_buffer);
	
	if( !ok) return;

	// bypass instruction
	JTAG_SendIR( 0xff, 8, hir_len, tir_len );
	// ISC_ENABLE ispen instruction
	JTAG_SendIR( 0xe8, 8, hir_len, tir_len );
	JTAG_SendDR( 0x34, 6, hdr_len, tdr_len );

//	// ISC_ADDRESS_SHIFT faddr instruction
//	JTAG_SendIR( 0xeb, 8, hir_len, tir_len );
//	JTAG_SendDR( faddr, 16, hdr_len, tdr_len );
//	JTAG_RunTestTCK(2);
//
//	// ISC_ERASE ferase instruction
//	JTAG_SendIR( 0xec, 8, hir_len, tir_len );
//	JTAG_RunTestTCK(15000000);

	// ISC_DISABLE conld instruction
	JTAG_SendIR( 0xf0, 8, hir_len, tir_len );
	JTAG_RunTestTCK(110000);
	// ISC_ENABLE ispen instruction
	JTAG_SendIR( 0xe8, 8, hir_len, tir_len );
	JTAG_SendDR( 0x34, 6, hdr_len, tdr_len );

	prom_in_block=0;
	prom_addr_hi=0;

	prom_hir_len = hir_len;
	prom_tir_len = tir_len;
	prom_hdr_len = hdr_len;
	prom_tdr_len = tdr_len;
}

uint8_t zerobyte = 0;

void HEX_Program( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data)
{
	if (data) {
		// valid data block
		switch( type ) {
			case 1: // end of file
				if (prom_in_block) {
					uint16_t padding = 512 - (prom_addr_lo&511);
					WriteStringConst(PSTR("\r\n# padding with "));
					WriteInt(padding);
					WriteStringConst(PSTR(" bytes"));
					while( padding-- )
						HEX_Program(0,1,prom_addr_lo,&zerobyte);
				}
				WriteStringConst(PSTR("\r\n# end of HEX data"));

				// ISC_ADDRESS_SHIFT faddr instruction
				JTAG_SendIR( 0xeb, 8, prom_hir_len, prom_tir_len );
				JTAG_SendDR( 1, 16, prom_hdr_len, prom_tdr_len );
				JTAG_Idle();
				JTAG_RunTestTCK(1);
						
				// ISC_SERASE instruction
				JTAG_SendIR( 0x0a, 8, prom_hir_len, prom_tir_len );
				JTAG_Idle();
				JTAG_RunTestTCK(37000);
						
				// ISC_DISABLE conld instruction
				JTAG_SendIR( 0xf0, 8, prom_hir_len, prom_tir_len );
				JTAG_RunTestTCK(110000);
				WriteStringConst(PSTR("\r\n# finished writing prom data\r\n\r\n"));
				break;

			case 4: // address high
				if (prom_in_block)
					HEX_DoErrorConst(PSTR("# HEX high address word changed mid sector\r\n"));
				prom_addr_hi = (data[0]<<8) | data[1];
				sprintf_P(output_buffer, PSTR("\r\n# high word %04X"), prom_addr_hi );
				WriteString(output_buffer);
				break;
				
			default:
				sprintf_P(output_buffer, PSTR("# Invalid HEX type %02X\r\n"), type);
				HEX_DoError(output_buffer);
				break;

			case 0: // data
				if (!prom_in_block) {
					if( addr&511 ) {
						HEX_DoErrorConst(PSTR("# HEX starts mid sector\r\n"));
						break;
					}
					prom_addr_lo=addr;
					prom_addr_lo_start=addr;
next_sector:
					// ISC_DATA_SHIFT fdata0 instruction
					JTAG_SendIR( 0xed, 8, prom_hir_len, prom_tir_len );
					JTAG_ShiftDR();
					for (int i=0; i<prom_hdr_len; i++)
						JTAG_SendClock(0);		// ignore all data before the data we want
					prom_in_block = 1;
				} else if (addr != prom_addr_lo) {
					HEX_DoErrorConst(PSTR("# HEX changes sector mid sector\r\n"));
					break;
				}
				while( len-- ) {
					uint8_t b = *data++;
					for(int i=0; i<7; i++) {
						JTAG_SendClock(b&1);
						b >>= 1;
					}					// send 7 bytes
					if( (++prom_addr_lo & 511) ) {
						JTAG_SendClock(b&1);
					} else {
						if (prom_tdr_len) {
							JTAG_SendClock(b&1);
							for(int i=1; i<prom_tdr_len; i++)
								JTAG_SendClock(0);
							JTAG_SendClockTMS(0);		// send TMS bit at end of padding
						} else
							JTAG_SendClockTMS(b&1);		// no padding, add TMS bit on last bit
						// we have now moved to exit 1_IR

						JTAG_SendClockTMS( 1 );			// move to update_IR
						jtag_state = JTAG_STATE_UPDATE_DR;
						JTAG_RunTestTCK(2);

						uint16_t prom_faddr = (prom_addr_hi<<12) | (prom_addr_lo_start>>4);
						if( prom_addr_lo & 1024)
							WriteStringConst(PSTR("."));
//						sprintf_P( output_buffer, PSTR("# programming sector with faddr=%04X (h=%04x,l=%04x)\r\n"), prom_faddr, prom_addr_hi, prom_addr_lo );
//						WriteString(output_buffer);
//						if( ((prom_addr_lo+1) & 0x3fff) == 0 )
//							WriteStringConst(PSTR("\r\n"));
						Endpoint_ClearIN();
						Endpoint_WaitUntilReady();

						// ISC_ADDRESS_SHIFT faddr instruction
						JTAG_SendIR( 0xeb, 8, prom_hir_len, prom_tir_len );
						JTAG_SendDR( prom_faddr, 16, prom_hdr_len, prom_tdr_len );
						JTAG_RunTestTCK(2);
						
						// ISC_PROGRAM fpgm instruction
						JTAG_SendIR( 0xea, 8, prom_hir_len, prom_tir_len );
						JTAG_Idle();
						JTAG_RunTestTCK(14000);

						prom_in_block = 0;
						if (len)
							goto next_sector;
					}
				}

				break;
		}
	}
}

void PROM_DumpBlock( int faddr, int hir_len, int tir_len, int hdr_len, int tdr_len )
{
	// ISC_ADDRESS_SHIFT faddr instruction
	JTAG_SendIR( 0xeb, 8, hir_len, tir_len );
	JTAG_SendDR( faddr, 16, hdr_len, tdr_len );
	JTAG_RunTestTCK(2);

	// ISC_READ fvfy0 instruction
	JTAG_SendIR( 0xef, 8, hir_len, tir_len );
	JTAG_RunTestTCK(1);
	JTAG_RunTestTCK(50);

	// read the data
	JTAG_ShiftDR();
	for (int i=0; i<hdr_len; i++)
		JTAG_SendClock(0);		// ignore all data before the data we want

	uint16_t addr = faddr << 4;
	for (int i=0; i<8192; i+=32*8 ) {
		HEX_Start( 0, addr, 32 );
		for( int j=0; j<32; j++ ) {
			uint8_t byte = 0;
			for(int bit = 0; bit<8; bit++) {
				byte >>= 1;
				if (JTAG_Clock(0) )
					byte |= 0x80;
			}
			HEX_Byte( byte );
			addr++;
		}
		HEX_EndLine();
	}

	JTAG_SendClockTMS( 1 );			// move to exit 1_IR
	JTAG_SendClockTMS( 1 );			// move to update_IR
	jtag_state = JTAG_STATE_UPDATE_DR;
}

void PROM_Dump( void )
{
	int hir_len = prom_hir_len, hdr_len = prom_hdr_len, tir_len = prom_tir_len, tdr_len = prom_tdr_len;

	JTAG_Reset();
	// idcode
	JTAG_SendIR( 0xfe, 8, hir_len, tir_len );
	uint32_t idcode = JTAG_SendDR( 0, 32, hdr_len, tdr_len );

	char* PROGMEM status = PSTR("wrong chip");
	bool ok = 0;
	if( idcode == 0xf5045093 ) {
		status = PSTR("XCF02S");
		ok = 1;
	}

	sprintf_P( output_buffer, PSTR("# idcode=%04X%04X - %S\r\n"), (uint16_t) (idcode>>16), (uint16_t) idcode, status );
	WriteString(output_buffer);

	if( !ok) return;

	// ISC_DISABLE conld instruction
	JTAG_SendIR( 0xf0, 8, hir_len, tir_len );
	JTAG_RunTestTCK(110000);
	uint16_t protect = (uint16_t) JTAG_SendIR( 0xff, 8, hir_len, tir_len );

	status = PSTR("readable");
	if( (protect&7) != 1 ) {
		status = PSTR("unreadable");
		ok = 0;
	}

	sprintf_P( output_buffer, PSTR("# protect=%02X - %S\r\n"), protect, status );
	WriteString(output_buffer);
	
	if( !ok) return;

	// bypass instruction
	JTAG_SendIR( 0xff, 8, hir_len, tir_len );
	// ISC_ENABLE ispen instruction
	JTAG_SendIR( 0xe8, 8, hir_len, tir_len );
	JTAG_SendDR( 0x34, 6, hdr_len, tdr_len );
	// ISC_DISABLE conld instruction
	JTAG_SendIR( 0xf0, 8, hir_len, tir_len );
	JTAG_RunTestTCK(110000);
	// ISC_ENABLE ispen instruction
	JTAG_SendIR( 0xe8, 8, hir_len, tir_len );
	JTAG_SendDR( 0x34, 6, hdr_len, tdr_len );

	uint16_t faddr_base = ~0U;
	for( uint16_t faddr=0x0000; faddr<0x4000; faddr+=0x40 ) {
		WriteStringConst(PSTR("#\r\n"));
		sprintf_P( output_buffer, PSTR("# faddr=%04X\r\n"), faddr );
		WriteString(output_buffer);
		if ( (faddr & 0xf000) != faddr_base ) {
			faddr_base = faddr & 0xf000;
			HEX_AddrHigh( faddr >> 12 );
		}
		PROM_DumpBlock( faddr, hir_len, tir_len, hdr_len, tdr_len );
	}
	HEX_EndOfFile();
}

void PROM_Reload( void )
{
	int hir_len = prom_hir_len, hdr_len = prom_hdr_len, tir_len = prom_tir_len, tdr_len = prom_tdr_len;

	// idcode
	JTAG_SendIR( 0xfe, 8, hir_len, tir_len );
	uint32_t idcode = JTAG_SendDR( 0, 32, hdr_len, tdr_len );

	char* PROGMEM status = PSTR("wrong chip");
	bool ok = 0;
	if( idcode == 0xf5045093 ) {
		status = PSTR("XCF02S");
		ok = 1;
	}

	sprintf_P( output_buffer, PSTR("# idcode=%04X%04X - %S\r\n"), (uint16_t) (idcode>>16), (uint16_t) idcode, status );
	WriteString(output_buffer);

	if( !ok) return;

	// ISC_DISABLE conld instruction
	JTAG_SendIR( 0xf0, 8, hir_len, tir_len );
	JTAG_RunTestTCK(110000);

	// CONFIG instruction - restart FPGA
	JTAG_SendIR( 0xee, 8, hir_len, tir_len );
	JTAG_RunTestTCK(10);
	JTAG_Reset();
	JTAG_RunTestTCK(10);

	// bypass instruction
	JTAG_SendIR( 0xff, 8, hir_len, tir_len );
}
