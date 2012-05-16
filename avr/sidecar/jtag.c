#include "jtag.h"
#include "server.h"
#include <string.h>
#include <LUFA/Drivers/USB/USB.h>

enum JTAG_STATE jtag_state = JTAG_STATE_UNKNOWN;

///////////////////////////////////////////////////////////////////////////////

void JTAG_Init(void)
{
//	JTAG_DDR =0;
	JTAG_DDR  |= JTAG_TDI | JTAG_TCK | JTAG_TMS;
	JTAG_DDR  &= ~JTAG_TDO;

	JTAG_PORT |=  (JTAG_TMS);
	JTAG_PORT &= ~(JTAG_TCK | JTAG_TDI);
}

void JTAG_Reset(void)
{
	JTAG_SendClockTMS(0);
	JTAG_SendClockTMS(0);
	JTAG_SendClockTMS(0);
	JTAG_SendClockTMS(0);
	JTAG_SendClockTMS(0);

	jtag_state = JTAG_STATE_RESET;
}

void JTAG_Idle(void)
{
	switch( jtag_state ) {
	default:
		JTAG_Reset();
	case JTAG_STATE_RESET:
	case JTAG_STATE_UPDATE_DR:
	case JTAG_STATE_UPDATE_IR:
	case JTAG_STATE_IDLE:
		JTAG_SendClock(0);
		break;

	case JTAG_STATE_SELECT_DR:
	case JTAG_STATE_SELECT_IR:
		JTAG_SendClock(0);
	case JTAG_STATE_CAPTURE_DR:
	case JTAG_STATE_CAPTURE_IR:
	case JTAG_STATE_SHIFT_DR:
	case JTAG_STATE_SHIFT_IR:
	case JTAG_STATE_PAUSE_DR:
	case JTAG_STATE_PAUSE_IR:
		JTAG_SendClockTMS(0);

	case JTAG_STATE_EXIT1_DR:
	case JTAG_STATE_EXIT1_IR:
	case JTAG_STATE_EXIT2_DR:
	case JTAG_STATE_EXIT2_IR:
		JTAG_SendClockTMS(0);
		JTAG_SendClock(0);
		break;
	}

	jtag_state = JTAG_STATE_IDLE;
}

void JTAG_SelectDR(void)
{
	switch( jtag_state ) {
	default:
		JTAG_Reset();
	case JTAG_STATE_RESET:
		JTAG_SendClock(0);
	case JTAG_STATE_IDLE:
		JTAG_SendClockTMS(0);
	case JTAG_STATE_SELECT_DR:
		break;
		
	case JTAG_STATE_SELECT_IR:
		JTAG_SendClockTMS(0);
		JTAG_SendClock(0);
		JTAG_SendClockTMS(0);
		break;
		
	case JTAG_STATE_CAPTURE_DR:
	case JTAG_STATE_CAPTURE_IR:
	case JTAG_STATE_SHIFT_DR:
	case JTAG_STATE_SHIFT_IR:
		JTAG_SendClockTMS(0);

	case JTAG_STATE_PAUSE_DR:
	case JTAG_STATE_PAUSE_IR:
		JTAG_SendClockTMS(0);
	case JTAG_STATE_EXIT1_DR:
	case JTAG_STATE_EXIT1_IR:
	case JTAG_STATE_EXIT2_DR:
	case JTAG_STATE_EXIT2_IR:
		JTAG_SendClockTMS(0);
	case JTAG_STATE_UPDATE_DR:
	case JTAG_STATE_UPDATE_IR:
		JTAG_SendClockTMS(0);
		break;
	}
	jtag_state = JTAG_STATE_SELECT_DR;
}

void JTAG_SelectIR(void)
{
	switch( jtag_state ) {
	default:
		JTAG_SelectDR();
	case JTAG_STATE_SELECT_DR:
		JTAG_SendClockTMS(0);
		jtag_state = JTAG_STATE_SELECT_IR;
	case JTAG_STATE_SELECT_IR:
		break;
	}
}

void JTAG_ShiftIR(void)
{
	switch( jtag_state ) {
	default:
		JTAG_SelectIR();
	case JTAG_STATE_SELECT_IR:
		JTAG_SendClock(0);
	case JTAG_STATE_CAPTURE_IR:
		JTAG_SendClock(0);
	case JTAG_STATE_SHIFT_IR:
		break;
	}
	jtag_state = JTAG_STATE_SHIFT_IR;
}

void JTAG_ShiftDR(void)
{
	switch( jtag_state ) {
	default:
		JTAG_SelectDR();
	case JTAG_STATE_SELECT_DR:
		JTAG_SendClock(0);
	case JTAG_STATE_CAPTURE_DR:
		JTAG_SendClock(0);
	case JTAG_STATE_SHIFT_DR:
		break;
	}
	jtag_state = JTAG_STATE_SHIFT_DR;
}

extern char output_buffer[ 128 ];

void JTAG_ChainInfo(void)
{
	sprintf(output_buffer, "#JTAG_CHAIN\r\n");
	WriteString(output_buffer);
	JTAG_Reset();
	sprintf(output_buffer, "#reset\r\n");
	WriteString(output_buffer);
	JTAG_SelectDR();
	sprintf(output_buffer, "#dr\r\n");
	WriteString(output_buffer);
	JTAG_SendClock(0);
	JTAG_SendClock(0);			// move to shift-DR

	unsigned char continue_scan = 0xf;
	while (continue_scan >0 ) {
		continue_scan --;
		int bit = JTAG_Clock(1);
		if (!bit) {
			sprintf( (char*) output_buffer, "# ???? unknown\r\n" );
		} else {
			unsigned char a = 0x80,b=0,c=0,d=0;
			for( char i=1;i<8; i++)
				a = (a>>1) | (JTAG_Clock(1)<<7);
			for( char i=0;i<8; i++)
				b = (b>>1) | (JTAG_Clock(1)<<7);
			for( char i=0;i<8; i++)
				c = (c>>1) | (JTAG_Clock(1)<<7);
			for( char i=0;i<8; i++)
				d = (d>>1) | (JTAG_Clock(1)<<7);

			char* manuf = "unknown";
			char* part = "";
			if( (b&0xf)==0 && a==0x93) {
				manuf = "Xilinx ";
				if ( (d&0xf)==5 && c==4 && b==0x50 )
					part = "XCF02S";
				else if ( (d&0xf)==1 && c==0x41 && b==0xc0 )
					part = "XC3S400";
			}

			if (a==0xff && b==0xff && c==0xff && d==0xff) {
				manuf = "end of chain";
				continue_scan = 0;
			}

			sprintf( output_buffer, "# %02X%02X%02X%02X %s%s\r\n",d,c,b,a, manuf, part );
		}
		WriteString(output_buffer);
	}
}

int JTAG_ChainLen(void)
{
	int i;

	JTAG_Reset();
	JTAG_SelectIR();
	JTAG_SendClock(0);
	JTAG_SendClock(0);			// move to shift-IR
	for (i=0; i<1024; i++)
		JTAG_SendClock(1);		// select BYPASS register on all devices
	JTAG_SendClockTMS(1);			// move to exit1 IR
	jtag_state = JTAG_STATE_EXIT1_IR;

	JTAG_SelectDR();
	JTAG_SendClock(0);
	JTAG_SendClock(0);			// move to shift-DR

	for (i=0; i<1024; i++)
		JTAG_SendClock(0);		// shift through lots of zero bits

	for (i=0; i<1024; i++)
		if( JTAG_Clock(1)) break;	// shift through ones until we find out

	JTAG_Reset();

	return i;
}

int JTAG_IRLen(void)
{
	int i;

	JTAG_Reset();
	JTAG_SelectIR();
	JTAG_SendClock(0);
	JTAG_SendClock(0);			// move to shift-IR
	for (i=0; i<1024; i++)
		JTAG_SendClock(1);		// select BYPASS register on all devices
	for (i=0; i<1024; i++)
		if( !JTAG_Clock(0)) break;	// shift through ones until we find out

	JTAG_Reset();

	return i;
}

uint32_t reverse( uint32_t in_value, int reg_len)
{
	uint32_t in_value_rev = 0;
	for (int i=0; i<reg_len; i++ ) {
		in_value_rev <<= 1;
		in_value_rev |= (in_value&1);
		in_value >>= 1;
	}

	return in_value_rev;
}

uint32_t JTAG_SendIR( uint32_t reg_value, int reg_len, int hir_len, int tir_len )
{
	int i;
	uint32_t in_value = 0;

	JTAG_ShiftIR();
	for (i=0; i<hir_len; i++)
		JTAG_SendClock(1);		// send bypass register to everything in chain before

	for (i=0; i<reg_len-1; i++ ) {
		in_value |= JTAG_Clock( reg_value&1 );
		in_value <<= 1;
		reg_value >>= 1;		// send all but last bit of instruction
	}

	if( tir_len ) {
		in_value |= JTAG_Clock( reg_value&1 );	// send last bit

		for( i=0; i<tir_len-1; i++ )
			JTAG_SendClock(1);	// send all but last bit of trailer

		JTAG_SendClockTMS(1);		// send last bit of trailer with TMS to move out of shift_IR
	} else {
		in_value |= JTAG_ClockTMS( reg_value&1 );	// send last bit with TMS
	}

	//jtag_state = JTAG_STATE_EXIT1_DR;
	JTAG_SendClockTMS( 1 );			// move to update_IR
	jtag_state = JTAG_STATE_UPDATE_IR;

	return reverse( in_value, reg_len );
}

uint32_t JTAG_SendDR( uint32_t reg_value, int reg_len, int hdr_len, int tdr_len )
{
	int i;
	uint32_t in_value = 0;

	JTAG_ShiftDR();
	for (i=0; i<hdr_len; i++)
		JTAG_SendClock(1);		// ignore all data before the data we want

	for (i=0; i<reg_len-1; i++ ) {
		in_value |= JTAG_Clock( reg_value&1 );
		in_value <<= 1;
		reg_value >>= 1;		// send all but last bit of instruction
	}

	if( tdr_len ) {
		in_value |= JTAG_Clock( reg_value&1 );	// send last bit

		for( i=0; i<tdr_len-1; i++ )
			JTAG_SendClock(1);	// shift out all the data at the end

		JTAG_SendClockTMS(1);		// send last bit of trailer with TMS to move out of shift_DR
	} else {
		in_value |= JTAG_ClockTMS( reg_value&1 );	// send last bit with TMS
	}

	//jtag_state = JTAG_STATE_EXIT1_DR;
	JTAG_SendClockTMS( 1 );			// move to update_DR
	jtag_state = JTAG_STATE_UPDATE_DR;

	return reverse( in_value, reg_len );
}

void JTAG_RunTestTCK( uint32_t i )
{
	JTAG_Idle();
	while( i-- )
		JTAG_SendClock( 0 );			// keep sending clocks in the idle state
}


