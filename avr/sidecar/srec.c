#include "sidecar.h"
#include "srec.h"
#include "server.h"



static uint8_t SREC_xsum;

void SREC_Start( uint8_t type, uint16_t faddr, uint8_t len )
{
	sprintf(output_buffer,":%02X%04X%02X", len, faddr, type);
	WriteString(output_buffer);
	SREC_xsum = 0 - len - (faddr>>8) - (faddr&0xff) - type;
}

void SREC_Byte( uint8_t byte )
{
	sprintf(output_buffer, "%02X", byte);
	WriteString(output_buffer);
	SREC_xsum -= byte;
}

void SREC_EndLine(void)
{
	sprintf(output_buffer, "%02X\r\n", SREC_xsum);
	WriteString(output_buffer);
}

void SREC_AddrHigh( uint16_t hiaddr )
{
	SREC_Start( 4, 0, 2 );
	SREC_Byte( hiaddr>>8 );
	SREC_Byte( hiaddr & 0xff );
	SREC_EndLine();
}

void SREC_EndOfFile()
{
	SREC_Start( 1, 0, 0 );
	SREC_EndLine();
}

///////////////////////////////////////////////

enum SREC_State {
	SREC_ReadingHi,
	SREC_ReadingLo,
	SREC_Trailer,
	SREC_Error
};

static uint8_t srec_read, srec_xsum, srec_error;
static enum SREC_State srec_state;
static uint8_t srec_buffer[64];
static void (*srec_fn)( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data) = &SREC_Early;

void SREC_DoError(char* str)
{
	if (!srec_error) {
		WriteString(str);
		(*srec_fn)(0xff,0,0,NULL);
	}
	srec_error = 1;
}

uint16_t ContinueSRECRequest( uint8_t** ppBuffer, uint16_t DataLength )
{
	uint8_t* pBuffer = *ppBuffer;

	while( DataLength-- ) {
		uint8_t c = *pBuffer++;

		bool gothex = 0;
		uint8_t h = 0;

		switch( c ) {
		case '\r': case '\n':
			if( srec_state == SREC_ReadingLo)
				SREC_DoError("# SREC line has odd number of hex digit\r\n");

			if( srec_xsum )
				SREC_DoError("# SREC invalid checksum\r\n");

			if( srec_read < 5 )
				SREC_DoError("# SREC line too short\r\n");

			if( (srec_read-5) != srec_buffer[0] ) {
				sprintf(output_buffer,"# SREC line length %d doesn't match record (%d+5)\r\n", srec_read, srec_buffer[0]);
				SREC_DoError(output_buffer);
			}

			if (!srec_error)
				(*srec_fn)( srec_buffer[3], srec_buffer[0], (srec_buffer[1] << 8) | srec_buffer[2], &srec_buffer[4] );
			ServerRequest = DefaultRequest;

			*ppBuffer = pBuffer;
			return DataLength;

		case ' ': case '\t':
			if( srec_state == SREC_ReadingLo)
				SREC_DoError("# SREC line has odd number of hex digit\r\n");
			srec_state = SREC_Trailer;
			break;

		case '0': case '1': case '2': case '3': case '4':
		case '5': case '6': case '7': case '8': case '9':
			h=c-'0';
			gothex=1;
			break;
		case 'A': case 'B': case 'C': case 'D': case 'E': case 'F':
			h=c+10-'A';
			gothex=1;
			break;
		case 'a': case 'b': case 'c': case 'd': case 'e': case 'f':
			h=c+10-'a';
			gothex=1;
			break;

		default:
			SREC_DoError("# SREC contains unexpected character\r\n");
		}

		if( gothex ) {
			switch( srec_state ) {
			case SREC_ReadingHi:
				if (srec_read >= sizeof(srec_buffer) ) {
					SREC_DoError("# SREC line is too long\r\n");
					srec_state = SREC_Error;
					break;
				}
				srec_buffer[srec_read] = h << 4;
				srec_state = SREC_ReadingLo;
				break;
			case SREC_ReadingLo:
				srec_buffer[srec_read++] |= h;
				srec_state = SREC_ReadingHi;
				break;
			default:
				SREC_DoError("# SREC contains unexpected character\r\n");
				srec_state = SREC_Error;
			}
		}
	}
	return 0;
}

void StartSRECRequest( void )
{
	srec_read=0;
	srec_xsum=0;
	srec_state=SREC_ReadingHi;

	ServerRequest = ContinueSRECRequest;
}

void StartSREC( void (*fn)( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data) )
{
	srec_error = 0;
	srec_fn = fn;
}


void SREC_Early( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data)
{
	if (data)
		SREC_DoError("# SREC before command\r\n");
}


void SREC_Null( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data)
{
	if (data) {
		sprintf(output_buffer, "# SREC type %02X len %02x addr %04X\r\n", type, len, addr );
		WriteString(output_buffer);
	}
}

