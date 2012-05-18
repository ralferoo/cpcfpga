
#include <avr/pgmspace.h>

void WriteString( const char* str );
void WriteStringConst( const char* PROGMEM str );
void WriteInt( uint16_t i );
void WriteIntHex2( uint8_t i );
void WriteIntHex4( uint16_t i );
void WriteCRLF( void );
inline void FlushBuffer( void ) { USB_USBTask(); }

extern uint16_t (*ServerRequest)( uint8_t** ppBuffer, uint16_t DataLength );

void OutputString( char* str );
extern char output_buffer[ 128 ];

uint16_t EOLRequest( uint8_t** ppBuffer, uint16_t DataLength );
uint16_t EchoToEOLRequest( uint8_t** ppBuffer, uint16_t DataLength );
uint16_t DefaultRequest( uint8_t** ppBuffer, uint16_t DataLength );
uint16_t HEXRequest( uint8_t** ppBuffer, uint16_t DataLength );
