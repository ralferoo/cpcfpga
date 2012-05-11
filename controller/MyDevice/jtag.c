#include "jtag.h"

enum JTAG_STATE jtag_state = JTAG_STATE_UNKNOWN;

///////////////////////////////////////////////////////////////////////////////

void JTAG_Init(void)
{
	JTAG_DDR  |= JTAG_TDI | JTAG_TCK | JTAG_TMS;

	JTAG_PORT |=  (JTAG_TMS);
	JTAG_PORT &= ~(JTAG_TCK | JTAG_TDI);
}

void JTAG_Reset(void)
{
	JTAG_ClockTMS(0);
	JTAG_ClockTMS(0);
	JTAG_ClockTMS(0);
	JTAG_ClockTMS(0);
	JTAG_ClockTMS(0);

	jtag_state = JTAG_STATE_RESET;
}

