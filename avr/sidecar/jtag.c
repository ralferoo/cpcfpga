#include <LUFA/Drivers/USB/USB.h>
#include "jtag.h"
#include <string.h>

#include "Descriptors.h"

enum JTAG_STATE jtag_state = JTAG_STATE_UNKNOWN;

///////////////////////////////////////////////////////////////////////////////

int JTAG_ClockWithTMS(int tdi,int tms,int read)
{
	// get the TDO value from the previous cycle
	int previous;
	if (read) {
		previous = (JTAG_PIN & JTAG_TDO)?1:0;
	} else {
		previous = (JTAG_PIN & JTAG_TDO)?1:0;
	}

	// update the output data
	if(tms)
		JTAG_PORT |= JTAG_TMS;
	else
		JTAG_PORT &= ~JTAG_TMS;

	if(tdi)
		JTAG_PORT |= JTAG_TDI;
	else
		JTAG_PORT &= ~JTAG_TDI;

/*
	char str[30];
	//sprintf_P(str, tms?PSTR("[%d:%d TMS %d]\r\n"):PSTR("[%d:%d-%d]"), tdi?1:0, previous, miso );
	sprintf_P(str, tms?PSTR("[%d:%d TMS]\r\n"):PSTR("[%d:%d]"), tdi?1:0, previous );
	WriteString(str);
	Endpoint_ClearIN();
	Endpoint_WaitUntilReady();
	USB_USBTask();
*/

	// output data is set up, pulse the clock and back again
	__asm__("nop;nop;nop;nop;nop;nop;nop;nop;");
	JTAG_PORT |= JTAG_TCK;
	__asm__("nop;nop;nop;nop;nop;nop;nop;nop;");
	JTAG_PORT &= ~JTAG_TCK;
//	__asm__("nop;nop;nop;nop;nop;nop;nop;nop;");

	char c[2];
	if (tdi) {
		c[0] = tms ? '+':'-';
	} else {
		c[0] = tms ? '|':' ';
	}
	c[1]=previous?'1':'0';
	Endpoint_Write_Stream_LE( (uint8_t*) &c, 2, NULL);

	return previous;
}




void JTAG_Init(void)
{
//	JTAG_DDR =0;
	JTAG_DDR  |= JTAG_TDI | JTAG_TCK | JTAG_TMS;
	JTAG_DDR  &= ~(JTAG_TDO); // | JTAG_MISO);

	JTAG_PORT |=  (JTAG_TMS);
	JTAG_PORT |=  (JTAG_TCK | JTAG_TDI);
//	JTAG_PORT &= ~(JTAG_TCK | JTAG_TDI);
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

int prom_hir_len = -1, prom_tir_len, prom_hdr_len, prom_tdr_len;
int fpga_hir_len = -1, fpga_tir_len, fpga_hdr_len, fpga_tdr_len;

void JTAG_ChainInfo(void)
{
	int hir = 0, hdr = 0;
	int tir = JTAG_IRLen();
	int tdr = JTAG_ChainLen();
	sprintf_P(output_buffer,PSTR("# JTAG chain scan, %d devices, IR len=%d\r\n"), tdr, tir );
	WriteString( output_buffer );


	if( tdr == 0 || tir == 0 || tdr>1020 || tir>1020) {
		WriteStringConst( PSTR("Implausible chain length, not going to procede with scan...\r\n") );
		return;
	}

	JTAG_Reset();
	JTAG_SelectDR();
	JTAG_SendClock(0);
	JTAG_SendClock(0);			// move to shift-DR

	unsigned char continue_scan = 0xf;
	while (continue_scan >0 ) {
		continue_scan --;
		int bit = JTAG_Clock(1);
		tdr--;
		if (!bit) {
			WriteStringConst( PSTR("# ???? unknown\r\n" ));
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

			int ir = -1;

			WriteStringConst( PSTR("# " ));
			WriteIntHex2(d);
			WriteIntHex2(c);
			WriteIntHex2(b);
			WriteIntHex2(a);

			if( (b&0xf)==0 && a==0x93) {
				WriteStringConst( PSTR(" Xilinx" ));
				if ( (d&0xf)==5 && c==4 && b==0x50 ) {
					ir = 8;
					prom_hir_len = hir;
					prom_tir_len = tir - ir;
					prom_hdr_len = hdr;
					prom_tdr_len = tdr;
					sprintf_P(output_buffer, PSTR(" XCF02S, hir=%d, tir=%d, hdr=%d, tdr=%d\r\n"), 
						prom_hir_len, prom_tir_len, prom_hdr_len, prom_tdr_len );
					WriteString( output_buffer );
				} else if ( (d&0xf)==1 && c==0x41 && b==0xc0 ) {
					ir = 6;
					prom_hir_len = hir;
					prom_tir_len = tir - ir;
					prom_hdr_len = hdr;
					prom_tdr_len = tdr;
					sprintf_P(output_buffer, PSTR(" XC3S400, hir=%d, tir=%d, hdr=%d, tdr=%d\r\n"), 
						prom_hir_len, prom_tir_len, prom_hdr_len, prom_tdr_len );
					WriteString( output_buffer );
				} else {
					WriteStringConst( PSTR("\r\n" ));
				}
			} else if (a==0xff && b==0xff && c==0xff && d==0xff) {
				WriteStringConst( PSTR(" end of chain\r\n" ));
				continue_scan = 0;
				tdr++;
			} else {
				WriteStringConst( PSTR(" Unknown\r\n" ));
			}

			if (ir >= 0 && hir >= 0) {
				hir += ir;
				tir -= ir;
				if( tir < 0 )
					WriteStringConst( PSTR( "# TIR error!\r\n" ));
			} else {
				hir = tir = -1;
			}
		}
		hdr++;
	}
	if( tdr )
		WriteStringConst( PSTR("# Didn't reach end of chain with tdr=0!\r\n"));

	WriteStringConst( PSTR("\r\n"));
}

int JTAG_ChainLen(void)
{
	int i;

/*
//	WriteStringConst(PSTR("\nreset\n"));
	JTAG_Reset();
	JTAG_SelectDR();
//	WriteStringConst(PSTR("\nshiftout\n"));
	for(i=0; i<100; i++)
		JTAG_SendClock(0);
*/

/*
//	WriteStringConst(PSTR("\nreset\n"));
	JTAG_Reset();
	JTAG_SelectIR();
//	WriteStringConst(PSTR("\nshiftout\n"));
	for(i=0; i<100; i++)
		JTAG_SendClock(0);
	WriteStringConst(PSTR("\nones\n"));
	for(i=0; i<50; i++)
		JTAG_SendClock(1);
	WriteStringConst(PSTR("\nzeros\n"));
	for(i=0; i<50; i++)
		JTAG_SendClock(0);
	WriteStringConst(PSTR("\nones\n"));
	for(i=0; i<50; i++)
		JTAG_SendClock(1);
	WriteStringConst(PSTR("\ntwos\n"));
	for(i=0; i<50; i++) {
		JTAG_SendClock(0);
		JTAG_SendClock(1);
	}
	WriteStringConst(PSTR("\nthrees\n"));
	for(i=0; i<50; i++) {
		JTAG_SendClock(0);
		JTAG_SendClock(0);
		JTAG_SendClock(1);
	}
	WriteStringConst(PSTR("\ndone\n"));
*/
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

/*
	WriteStringConst(PSTR("\npattern \"10\" x 50\n"));
	for (i=0; i<50; i++) {
		JTAG_SendClock(1);
		JTAG_SendClock(0);		// shift through pattern
	}

	WriteStringConst(PSTR("\npattern \"110\" x 50\n"));
	for (i=0; i<50; i++) {
		JTAG_SendClock(1);
		JTAG_SendClock(1);
		JTAG_SendClock(0);		// shift through pattern
	}

//	WriteStringConst(PSTR("\npattern \"1100\" x 50\n"));
//	for (i=0; i<50; i++) {
//		JTAG_SendClock(1);
//		JTAG_SendClock(1);
//		JTAG_SendClock(0);
//		JTAG_SendClock(0);		// shift through pattern
//	}

//	for (i=0; i<50; i++) {
//		JTAG_SendClock(1);
//		JTAG_SendClock(1);
//		JTAG_SendClock(0);		// shift through pattern
//	}

	WriteStringConst(PSTR("\npattern \"100\" x 50\n"));
	for (i=0; i<50; i++) {
		JTAG_SendClock(1);
		JTAG_SendClock(0);
		JTAG_SendClock(0);		// shift through pattern
	}
*/

	for (i=0; i<1024; i++)
		JTAG_SendClock(0);		// shift through lots of zero bits

	for (i=0; i<1024; i++) {
		if( JTAG_Clock(1))  {
//			WriteStringConst( PSTR("Found high bit\r\n"));
			break;	// shift through ones until we find out
		}
	}

	JTAG_Reset();

	if (i==0) {
		WriteStringConst( PSTR("TDO probably stuck at 0 - DRlen is zero\r\n" ));
	} else if (i==1024) {
		WriteStringConst( PSTR("TDO probably stuck at 1 - DRlen is very high\r\n" ));
	}
		

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

	if (i==0) {
		WriteStringConst( PSTR("TDO probably stuck at 1 - IRlen is zero\r\n" ));
	} else if (i==1024) {
		WriteStringConst( PSTR("TDO probably stuck at 0 - IRlen is very high\r\n" ));
	}
		

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


void PulseClockLine(int wValue)
{
	JTAG_PORT &= ~JTAG_TMS;				// don't leave the idle state
	while (wValue-- > 0) {
		JTAG_PORT |=  JTAG_TCK;			// high clock
		__asm__("nop;nop;nop;nop;nop;nop;nop;nop;");
		JTAG_PORT &= ~JTAG_TCK;			// low clock
		__asm__("nop;nop;nop;nop;nop;nop;nop;nop;");
		wValue--;
	}
}

unsigned char jtag_buffer[65];

/*
void delay()
{
		__asm__("nop;nop;nop;nop;nop;nop;nop;nop;");
		__asm__("nop;nop;nop;nop;nop;nop;nop;nop;");
		__asm__("nop;nop;nop;nop;nop;nop;nop;nop;");
		__asm__("nop;nop;nop;nop;nop;nop;nop;nop;");
}
*/

void RawJTAG(unsigned char tms_at_end, int num_bits)
{
	if (tms_at_end) {
		if (--num_bits < 0)
			return;
	}

	unsigned char *p = jtag_buffer;
	unsigned char idata = *p;
	unsigned char odata = 0;
	unsigned char mask = 0x01;

	JTAG_PORT &= ~JTAG_TMS;			// no TMS for most of the bits

	while (num_bits) {
		if (idata & mask)
			JTAG_PORT |= JTAG_TDI;
		else
			JTAG_PORT &= ~JTAG_TDI;		// set output bit

		if (JTAG_PIN & JTAG_TDO)
			odata |= mask;			// read input bit

		JTAG_PORT |=  JTAG_TCK;			// high clock
		//__asm__("nop;nop;nop;nop;nop;nop;nop;nop;");
		__asm__("nop;nop;nop;nop;");
		//delay();

		mask = mask << 1;
		if( mask==0) {
			*p++ = odata;
			odata = 0;
			idata = *p;
			mask = 0x01;
		}
		JTAG_PORT &= ~JTAG_TCK;			// low clock
		//delay();

		num_bits--;
	}

	if (tms_at_end) {
//		__asm__("nop;nop;nop;");
		JTAG_PORT |= JTAG_TMS;			// TMS for last bit
		if (idata & mask)
			JTAG_PORT |= JTAG_TDI;
		else
			JTAG_PORT &= ~JTAG_TDI;		// set output bit

		if (JTAG_PIN & JTAG_TDO)
			odata |= mask;			// read input bit

		JTAG_PORT |=  JTAG_TCK;			// high clock
		//delay();
	}
//	__asm__("nop;nop;");

	*p = odata;
	JTAG_PORT &= ~JTAG_TCK;				// low clock
}


void JTAG_Device_ProcessControlRequest(void)
{
	// useful to read this: https://groups.google.com/forum/#!msg/lufa-support/MQh2NR9BMgY/83hUkflfqQYJ

	if (USB_ControlRequest.bmRequestType == (REQDIR_DEVICETOHOST | REQTYPE_VENDOR | REQREC_DEVICE))
	{
		if (USB_ControlRequest.bRequest == 'O' ) {
			Endpoint_ClearSETUP();
			Endpoint_Write_Control_Stream_LE(jtag_buffer, USB_ControlRequest.wLength);
			Endpoint_ClearOUT();

//			Endpoint_SelectEndpoint(CDC_TX_EPNUM);
//			Endpoint_Write_Control_Stream_LE(&USB_ControlRequest.bRequest, 1);
//			Endpoint_ClearIN();
			return;
		}

/*
		if (USB_ControlRequest.bRequest == 'j' ) {
			Endpoint_ClearSETUP();
			int i = USB_ControlRequest.wValue;

			if(i&0x80)
				JTAG_PORT |= JTAG_TMS;
			else
				JTAG_PORT &= ~JTAG_TMS;

			if(i&1)
				JTAG_PORT |= JTAG_TDI;
			else
				JTAG_PORT &= ~JTAG_TDI;

			char tdo = (JTAG_PIN & JTAG_TDO)?1:0;
			JTAG_PORT |= JTAG_TCK;

			Endpoint_Write_Control_Stream_LE(&tdo, 1);
			Endpoint_ClearOUT();

			JTAG_PORT &= ~JTAG_TCK;
			return;
		}
*/
	}
	else if (USB_ControlRequest.bmRequestType == (REQDIR_HOSTTODEVICE | REQTYPE_VENDOR | REQREC_DEVICE))
	{
		if (USB_ControlRequest.bRequest == 'J' ) {
			Endpoint_ClearSETUP();
			Endpoint_Read_Control_Stream_LE(jtag_buffer, (USB_ControlRequest.wIndex+7)>>3);
			RawJTAG((unsigned char)USB_ControlRequest.wValue, USB_ControlRequest.wIndex);
			Endpoint_ClearIN();

//			Endpoint_SelectEndpoint(CDC_TX_EPNUM);
//			Endpoint_Write_Control_Stream_LE(&USB_ControlRequest.bRequest, 1);
//			Endpoint_ClearIN();
			return;
		}
		else if (USB_ControlRequest.bRequest == 'Z' ) {
			Endpoint_ClearSETUP();
			PulseClockLine(USB_ControlRequest.wValue);
			Endpoint_ClearStatusStage();

//			Endpoint_SelectEndpoint(CDC_TX_EPNUM);
//			Endpoint_Write_Control_Stream_LE(&USB_ControlRequest.bRequest, 1);
//			Endpoint_ClearIN();
			return;
		}
	}
}

