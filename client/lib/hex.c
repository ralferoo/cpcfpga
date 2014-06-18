#include <stdarg.h>
#include "sidecar.h"

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
static int (*hex_fn)( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data) = &HEX_Early;

void hexDoError(const char* str, ...)
{
	va_list args;
	va_start(args, str);
	
	if (!hex_error) {
		vprintf(str, args);
		(*hex_fn)(0xff,0,0,NULL);
	}
	hex_error = 1;

	va_end(args);
}

int hexProcessData( uint8_t** ppBuffer, int DataLength )
{
	uint8_t* pBuffer = *ppBuffer;

	while( DataLength-- ) {
		uint8_t c = *pBuffer++;

		int gothex = 0;
		uint8_t h = 0;

		switch( c ) {
		case '\r': case '\n':
			if( hex_state == HEX_ReadingLo)
				hexDoError("\nHEX line has odd number of hex digit\n");

			if( hex_xsum )
				hexDoError("\nHEX invalid checksum\n");

			if( hex_read < 5 )
				hexDoError("\nHEX line too short\n");

			if( (hex_read-5) != hex_buffer[0] ) {
				hexDoError("\nHEX line length %d doesn't match record (%d+5)\n", hex_read, hex_buffer[0]);
			}

			if (!hex_error) {
				hex_error = (*hex_fn)( hex_buffer[3], hex_buffer[0], (hex_buffer[1] << 8) | hex_buffer[2], &hex_buffer[4] );
			}

			*ppBuffer = pBuffer;
			return DataLength;

		case ' ': case '\t':
			if( hex_state == HEX_ReadingLo)
				hexDoError("\nHEX line has odd number of hex digit\n");
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
			hexDoError("\nHEX contains unexpected character: '%c'\n", c);
		}

		if( gothex ) {
			switch( hex_state ) {
			case HEX_ReadingHi:
				if (hex_read >= sizeof(hex_buffer) ) {
					hexDoError("\nHEX line is too long\n");
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
				hexDoError("\nHEX contains unexpected character: '%c'\n", c);
				hex_state = HEX_Error;
			}
		}
	}
	return -1;
}

void hexStartLine( void )
{
	hex_read=0;
	hex_xsum=0;
	hex_state=HEX_ReadingHi;
}

void hexStartFile( int (*fn)( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data) )
{
	hex_error = 0;
	hex_fn = fn;
}


int HEX_Early( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data)
{
	if (data)
	{
		hexDoError("\nHEX before command\n");
		return 1;
	}
	return 0;
}


int HEX_Null( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data)
{
	if (data) {
		printf("HEX type %02X len %02x addr %04X\n", type, len, addr );
	}
	return 0;
}


void hexReadStream( int fd )
{
	uint8_t buffer[ 256 ];

	int bytes;
#ifdef _MSC_VER
	while ((bytes = fread(buffer, 1, sizeof(buffer), stdin)) > 0) {
#else
	while ((bytes = read(fd, buffer, sizeof(buffer))) > 0) {
#endif
		uint8_t* ptr = buffer;
next_line:
		while( bytes > 0 ) {
			char c = *ptr++;
			bytes--;
			if( c == ':') {
				hexStartLine();
				while( bytes > 0 ) {
					bytes = hexProcessData(&ptr, bytes);
					if (bytes<0) {
#ifdef _MSC_VER
						bytes = fread(buffer, 1, sizeof(buffer), stdin);
#else
						bytes = read(fd, buffer, sizeof(buffer));
#endif
						ptr = buffer;
						continue;
					} else
						goto next_line;
				}
			}
		}
	}
}

