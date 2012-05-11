#include "jtag.h"
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

void JTAG_ChainInfo(void)
{
	JTAG_Reset();
	JTAG_SelectDR();
	JTAG_SendClock(0);
	JTAG_SendClock(0);			// move to shift-DR

	uint8_t  buffer[ 100 ];

	unsigned char continue_scan = 0xf;
	while (continue_scan >0 ) {
		continue_scan --;
		int bit = JTAG_Clock(1);
		if (!bit) {
			sprintf( (char*) buffer, "-------- unknown device\r\n" );
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

			sprintf( (char*) buffer, "%02X%02X%02X%02X\r\n",d,c,b,a );

			if (a==0xff && b==0xff && c==0xff && d==0xff)
				continue_scan = 0;
		}
		Endpoint_Write_Stream_LE(&buffer, strlen((char*)buffer), NULL);

		/* Finalize the stream transfer to send the last packet */
		Endpoint_ClearIN();

		/* Wait until the endpoint is ready for another packet */
		Endpoint_WaitUntilReady();
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

