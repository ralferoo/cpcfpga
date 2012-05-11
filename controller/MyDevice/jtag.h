#ifndef _RALF_JTAG_H
#define _RALF_JTAG_H

///////////////////////////////////////////////////////////////////////////////

#include <avr/io.h>          // include I/O definitions (port names, pin names, etc)

#define JTAG_BIT_TDI 7
#define JTAG_BIT_TDO 6
#define JTAG_BIT_TCK 5
#define JTAG_BIT_TMS 4

#define JTAG_TDI (1<<JTAG_BIT_TDI)
#define JTAG_TDO (1<<JTAG_BIT_TDO)
#define JTAG_TCK (1<<JTAG_BIT_TCK)
#define JTAG_TMS (1<<JTAG_BIT_TMS)

#define JTAG_PIN  PINB
#define JTAG_PORT PORTB
#define JTAG_DDR  DDRB

enum JTAG_STATE {
	JTAG_STATE_UNKNOWN = 0,
	JTAG_STATE_RESET,
	JTAG_STATE_IDLE,

	JTAG_STATE_SELECT_DR,
	JTAG_STATE_CAPTURE_DR,
	JTAG_STATE_SHIFT_DR,
	JTAG_STATE_EXIT1_DR,
	JTAG_STATE_PAUSE_DR,
	JTAG_STATE_EXIT2_DR,
	JTAG_STATE_UPDATE_DR,

	JTAG_STATE_SELECT_IR,
	JTAG_STATE_CAPTURE_IR,
	JTAG_STATE_SHIFT_IR,
	JTAG_STATE_EXIT1_IR,
	JTAG_STATE_PAUSE_IR,
	JTAG_STATE_EXIT2_IR,
	JTAG_STATE_UPDATE_IR,
};

extern enum JTAG_STATE jtag_state;

inline int JTAG_ClockWithTMS(int tdi,int tms,int read)
{
	// get the TDO value from the previous cycle
	int previous;
	if (read) {
//		__asm__("nop");
		previous = JTAG_PIN;
	}
	else
		previous = 0;

	// update the output data
	if(tms)
		JTAG_PORT |= JTAG_TMS;
	else
		JTAG_PORT &= ~JTAG_TMS;

	if(tdi)
		JTAG_PORT |= JTAG_TDI;
	else
		JTAG_PORT &= ~JTAG_TDI;

	// output data is set up, pulse the clock and back again
	JTAG_PORT |= JTAG_TCK;
	JTAG_PORT &= ~JTAG_TCK;

	return (previous & JTAG_TDO) == JTAG_TDO;
}
inline int JTAG_Clock(int tdi) { return JTAG_ClockWithTMS(tdi,0,1); }
inline int JTAG_ClockTMS(int tdi) { return JTAG_ClockWithTMS(tdi,1,1); }

inline void JTAG_SendClock(int tdi) { JTAG_ClockWithTMS(tdi,0,0); }
inline void JTAG_SendClockTMS(int tdi) { JTAG_ClockWithTMS(tdi,1,0); }

///////////////////////////////////////////////////////////////////////////////

void JTAG_Init(void);
void JTAG_Reset(void);
void JTAG_SelectDR(void);
void JTAG_SelectIR(void);
int JTAG_ChainLen(void);

///////////////////////////////////////////////////////////////////////////////

#endif // _RALF_JTAG_H
