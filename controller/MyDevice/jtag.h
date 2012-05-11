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

#define JTAG_PORT PORTB
#define JTAG_DDR  DDRB

enum JTAG_STATE {
	JTAG_STATE_UNKNOWN = 0,
	JTAG_STATE_RESET,
};

extern enum JTAG_STATE jtag_state;

inline int JTAG_ClockWithTMS(int tdi,int tms)
{
	// get the TDO value from the previous cycle
	int previous = JTAG_PORT;

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
inline int JTAG_Clock(int tdi) { return JTAG_ClockWithTMS(tdi,0); }
inline int JTAG_ClockTMS(int tdi) { return JTAG_ClockWithTMS(tdi,1); }

///////////////////////////////////////////////////////////////////////////////

void JTAG_Init(void);
void JTAG_Reset(void);

///////////////////////////////////////////////////////////////////////////////

#endif // _RALF_JTAG_H
