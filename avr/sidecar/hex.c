#include "sidecar.h"
#include "hex.h"
#include "server.h"



static uint8_t HEX_xsum;

void HEX_Start( uint8_t type, uint16_t faddr, uint8_t len )
{
	sprintf(output_buffer,":%02X%04X%02X", len, faddr, type);
	WriteString(output_buffer);
	HEX_xsum = 0 - len - (faddr>>8) - (faddr&0xff) - type;
}

void HEX_Byte( uint8_t byte )
{
	sprintf(output_buffer, "%02X", byte);
	WriteString(output_buffer);
	HEX_xsum -= byte;
}

void HEX_EndLine(void)
{
	sprintf(output_buffer, "%02X\r\n", HEX_xsum);
	WriteString(output_buffer);
}

void HEX_AddrHigh( uint16_t hiaddr )
{
	HEX_Start( 4, 0, 2 );
	HEX_Byte( hiaddr>>8 );
	HEX_Byte( hiaddr & 0xff );
	HEX_EndLine();
}

void HEX_EndOfFile()
{
	HEX_Start( 1, 0, 0 );
	HEX_EndLine();
}

///////////////////////////////////////////////

enum HEX_State {
	HEX_ReadingHi,
	HEX_ReadingLo,
	HEX_Trailer,
	HEX_Error
};

static uint8_t hex_read, hex_xsum, hex_error;
static enum HEX_State hex_state;
static uint8_t hex_buffer[64];
static void (*hex_fn)( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data) = &HEX_Early;

void HEX_DoError(char* str)
{
	if (!hex_error) {
		WriteString(str);
		(*hex_fn)(0xff,0,0,NULL);
	}
	hex_error = 1;
}

uint16_t ContinueHEXRequest( uint8_t** ppBuffer, uint16_t DataLength )
{
	uint8_t* pBuffer = *ppBuffer;

	while( DataLength-- ) {
		uint8_t c = *pBuffer++;

		bool gothex = 0;
		uint8_t h = 0;

		switch( c ) {
		case '\r': case '\n':
			if( hex_state == HEX_ReadingLo)
				HEX_DoError("# HEX line has odd number of hex digit\r\n");

			if( hex_xsum )
				HEX_DoError("# HEX invalid checksum\r\n");

			if( hex_read < 5 )
				HEX_DoError("# HEX line too short\r\n");

			if( (hex_read-5) != hex_buffer[0] ) {
				sprintf(output_buffer,"# HEX line length %d doesn't match record (%d+5)\r\n", hex_read, hex_buffer[0]);
				HEX_DoError(output_buffer);
			}

			if (!hex_error)
				(*hex_fn)( hex_buffer[3], hex_buffer[0], (hex_buffer[1] << 8) | hex_buffer[2], &hex_buffer[4] );
			ServerRequest = DefaultRequest;

			*ppBuffer = pBuffer;
			return DataLength;

		case ' ': case '\t':
			if( hex_state == HEX_ReadingLo)
				HEX_DoError("# HEX line has odd number of hex digit\r\n");
			hex_state = HEX_Trailer;
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
			HEX_DoError("# HEX contains unexpected character\r\n");
		}

		if( gothex ) {
			switch( hex_state ) {
			case HEX_ReadingHi:
				if (hex_read >= sizeof(hex_buffer) ) {
					HEX_DoError("# HEX line is too long\r\n");
					hex_state = HEX_Error;
					break;
				}
				hex_buffer[hex_read] = h << 4;
				hex_state = HEX_ReadingLo;
				break;
			case HEX_ReadingLo:
				hex_buffer[hex_read++] |= h;
				hex_state = HEX_ReadingHi;
				break;
			default:
				HEX_DoError("# HEX contains unexpected character\r\n");
				hex_state = HEX_Error;
			}
		}
	}
	return 0;
}

void StartHEXRequest( void )
{
	hex_read=0;
	hex_xsum=0;
	hex_state=HEX_ReadingHi;

	ServerRequest = ContinueHEXRequest;
}

void StartHEX( void (*fn)( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data) )
{
	hex_error = 0;
	hex_fn = fn;
}


void HEX_Early( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data)
{
	if (data)
		HEX_DoError("# HEX before command\r\n");
}


void HEX_Null( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data)
{
	if (data) {
		sprintf(output_buffer, "# HEX type %02X len %02x addr %04X\r\n", type, len, addr );
		WriteString(output_buffer);
	}
}

