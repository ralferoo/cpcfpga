
void WriteString( char* str );

extern uint16_t (*ServerRequest)( uint8_t** ppBuffer, uint16_t DataLength );

void OutputString( char* str );
extern char output_buffer[ 128 ];

uint16_t EOLRequest( uint8_t** ppBuffer, uint16_t DataLength );
uint16_t EchoToEOLRequest( uint8_t** ppBuffer, uint16_t DataLength );
uint16_t DefaultRequest( uint8_t** ppBuffer, uint16_t DataLength );
uint16_t IHEXRequest( uint8_t** ppBuffer, uint16_t DataLength );
