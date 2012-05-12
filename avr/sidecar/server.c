#include "sidecar.h"
#include "server.h"
#include "jtag.h"

uint16_t DefaultRequest( uint8_t** ppBuffer, uint16_t DataLength );

uint16_t (*ServerRequest)( uint8_t** ppBuffer, uint16_t DataLength )
	= &DefaultRequest;

char output_buffer[ 128 ];

/////////////////////////////////////////////////////////////////////////////

void WriteString( char* str )
{
	Endpoint_Write_Stream_LE( (uint8_t*) str, strlen(str), NULL);
}

/////////////////////////////////////////////////////////////////////////////

uint16_t EOLRequest( uint8_t** ppBuffer, uint16_t DataLength )
{
	uint8_t* pBuffer = *ppBuffer;

	while( DataLength-- ) {
		uint8_t c = *pBuffer++;

		if( c=='\r' || c=='\n' ) {
			ServerRequest = DefaultRequest;

			*ppBuffer = pBuffer;
			return DataLength;
		}
	}

	return 0;
}

uint16_t EchoToEOLRequest( uint8_t** ppBuffer, uint16_t DataLength )
{
	uint8_t* pBuffer = *ppBuffer;

	while( DataLength-- ) {
		uint8_t c = *pBuffer++;

		if( c=='\r' || c=='\n' ) {
			WriteString("\r\n");

			ServerRequest = DefaultRequest;
			*ppBuffer = pBuffer;
			return DataLength;
		} else {
			Endpoint_Write_Stream_LE( (uint8_t*) &c, 1, NULL);
//			Endpoint_Write_8( c );
		}
	}

	return 0;
}

/////////////////////////////////////////////////////////////////////////////

uint16_t EchoRequest( uint8_t** ppBuffer, uint16_t DataLength )
{
	uint8_t* pBuffer = *ppBuffer;

	uint8_t buffer[32];
	int len;
	for(len=0; len<DataLength && len<20; len++)
		buffer[len]= *pBuffer++;
	sprintf((char*)buffer+len, "[%d]\r\n", len);
	
	Endpoint_Write_Stream_LE(buffer, strlen((char*)buffer), NULL);

	*ppBuffer = pBuffer;
	return DataLength - len;
}

/////////////////////////////////////////////////////////////////////////////

uint16_t DefaultRequest( uint8_t** ppBuffer, uint16_t DataLength )
{
	uint8_t* pBuffer = *ppBuffer;

	while( DataLength-- ) {
		uint8_t c = *pBuffer++;

		switch( c ) {
			case ' ':
			case '\t':
			case '\r':
			case '\n':
				break;

			case '-':
				for( int i=0; i<79; i++)
					Endpoint_Write_Stream_LE("-", 1, NULL);
				WriteString("\r\n");
			
			case '#':
				ServerRequest = EOLRequest;
				*ppBuffer = pBuffer;
				return DataLength;

			case ':':
				WriteString("# SREC\r\n");
				ServerRequest = EOLRequest;
				*ppBuffer = pBuffer;
				return DataLength;

			case 'j':
			case 'J': {
					int chain_len = JTAG_ChainLen();
					int ir_len = JTAG_IRLen();
					sprintf(output_buffer, "\r\n# JTAG scan:\r\n# chain length=%d, IR length=%d:\r\n", chain_len, ir_len );
					WriteString(output_buffer);
				}
				JTAG_ChainInfo();
				WriteString("\r\n");

				ServerRequest = EOLRequest;
				*ppBuffer = pBuffer;
				return DataLength;

			default:
				WriteString("# Unknown command: ");
				ServerRequest = EchoToEOLRequest;
				return DataLength + 1;
		}
	}

	return 0;
}


