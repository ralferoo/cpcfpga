#include "sidecar.h"
#include "srec.h"
#include "server.h"



static uint8_t IHEX_xsum;

void IHEX_Start( uint8_t type, uint16_t faddr, uint8_t len )
{
	sprintf(output_buffer,":%02X%04X%02X", len, faddr, type);
	WriteString(output_buffer);
	IHEX_xsum = 0 - len - (faddr>>8) - (faddr&0xff) - type;
}

void IHEX_Byte( uint8_t byte )
{
	sprintf(output_buffer, "%02X", byte);
	WriteString(output_buffer);
	IHEX_xsum -= byte;
}

void IHEX_EndLine(void)
{
	sprintf(output_buffer, "%02X\r\n", IHEX_xsum);
	WriteString(output_buffer);
}

void IHEX_AddrHigh( uint16_t hiaddr )
{
	IHEX_Start( 4, 0, 2 );
	IHEX_Byte( hiaddr>>8 );
	IHEX_Byte( hiaddr & 0xff );
	IHEX_EndLine();
}

void IHEX_EndOfFile()
{
	IHEX_Start( 1, 0, 0 );
	IHEX_EndLine();
}

///////////////////////////////////////////////

enum IHEX_State {
	IHEX_ReadingHi,
	IHEX_ReadingLo,
	IHEX_Trailer,
	IHEX_Error
};

static uint8_t ihex_read, ihex_xsum, ihex_error;
static enum IHEX_State ihex_state;
static uint8_t ihex_buffer[64];
static void (*ihex_fn)( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data) = &IHEX_Early;

void IHEX_DoError(char* str)
{
	if (!ihex_error) {
		WriteString(str);
		(*ihex_fn)(0xff,0,0,NULL);
	}
	ihex_error = 1;
}

uint16_t ContinueIHEXRequest( uint8_t** ppBuffer, uint16_t DataLength )
{
	uint8_t* pBuffer = *ppBuffer;

	while( DataLength-- ) {
		uint8_t c = *pBuffer++;

		bool gothex = 0;
		uint8_t h = 0;

		switch( c ) {
		case '\r': case '\n':
			if( ihex_state == IHEX_ReadingLo)
				IHEX_DoError("# IHEX line has odd number of hex digit\r\n");

			if( ihex_xsum )
				IHEX_DoError("# IHEX invalid checksum\r\n");

			if( ihex_read < 5 )
				IHEX_DoError("# IHEX line too short\r\n");

			if( (ihex_read-5) != ihex_buffer[0] ) {
				sprintf(output_buffer,"# IHEX line length %d doesn't match record (%d+5)\r\n", ihex_read, ihex_buffer[0]);
				IHEX_DoError(output_buffer);
			}

			if (!ihex_error)
				(*ihex_fn)( ihex_buffer[3], ihex_buffer[0], (ihex_buffer[1] << 8) | ihex_buffer[2], &ihex_buffer[4] );
			ServerRequest = DefaultRequest;

			*ppBuffer = pBuffer;
			return DataLength;

		case ' ': case '\t':
			if( ihex_state == IHEX_ReadingLo)
				IHEX_DoError("# IHEX line has odd number of hex digit\r\n");
			ihex_state = IHEX_Trailer;
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
			IHEX_DoError("# IHEX contains unexpected character\r\n");
		}

		if( gothex ) {
			switch( ihex_state ) {
			case IHEX_ReadingHi:
				if (ihex_read >= sizeof(ihex_buffer) ) {
					IHEX_DoError("# IHEX line is too long\r\n");
					ihex_state = IHEX_Error;
					break;
				}
				ihex_buffer[ihex_read] = h << 4;
				ihex_state = IHEX_ReadingLo;
				break;
			case IHEX_ReadingLo:
				ihex_buffer[ihex_read++] |= h;
				ihex_state = IHEX_ReadingHi;
				break;
			default:
				IHEX_DoError("# IHEX contains unexpected character\r\n");
				ihex_state = IHEX_Error;
			}
		}
	}
	return 0;
}

void StartIHEXRequest( void )
{
	ihex_read=0;
	ihex_xsum=0;
	ihex_state=IHEX_ReadingHi;

	ServerRequest = ContinueIHEXRequest;
}

void StartIHEX( void (*fn)( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data) )
{
	ihex_error = 0;
	ihex_fn = fn;
}


void IHEX_Early( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data)
{
	if (data)
		IHEX_DoError("# IHEX before command\r\n");
}


void IHEX_Null( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data)
{
	if (data) {
		sprintf(output_buffer, "# IHEX type %02X len %02x addr %04X\r\n", type, len, addr );
		WriteString(output_buffer);
	}
}

