#include "gpio.h"

static uint8_t hexXsum;

void hexByte( uint8_t byte )
{
        printf("%02X", byte);
        hexXsum -= byte;
}

void hexEndLine(void)
{
        printf("%02X\n", hexXsum);
}

void hexStart( uint8_t type, uint16_t faddr, uint8_t len )
{
        printf(":%02X%04X%02X", len, faddr, type);
        hexXsum = 0 - len - (faddr>>8) - (faddr&0xff) - type;
}

void hexAddrHigh( uint16_t hiaddr )
{
        hexStart( 4, 0, 2 );
        hexByte( hiaddr>>8 );
        hexByte( hiaddr & 0xff );
        hexEndLine();
}

void hexEndOfFile()
{
        hexStart( 1, 0, 0 );
        hexEndLine();
}
