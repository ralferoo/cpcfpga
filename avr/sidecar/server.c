#include "sidecar.h"
#include "server.h"
#include "jtag.h"

uint16_t DefaultRequest( uint8_t** ppBuffer, uint16_t DataLength );

uint16_t (*ServerRequest)( uint8_t** ppBuffer, uint16_t DataLength )
	= &DefaultRequest;

char output_buffer[ 128 ];

/////////////////////////////////////////////////////////////////////////////

void WriteStringFlush( char* str )
{
	Endpoint_Write_Stream_LE( (uint8_t*) str, strlen(str), NULL);
//	Endpoint_ClearIN();
//	Endpoint_WaitUntilReady();
//	Endpoint_ClearIN();
}

void WriteStringNoFlush( char* str )
{
	Endpoint_Write_Stream_LE( (uint8_t*) str, strlen(str), NULL);
//	Endpoint_ClearIN();
//	Endpoint_WaitUntilReady();
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
			ServerRequest = DefaultRequest;

			WriteStringFlush("\r\n");
//			Endpoint_Write_8( '\r' );
//			Endpoint_Write_8( '\n' );

			*ppBuffer = pBuffer;
			return DataLength;
		} else {
			Endpoint_Write_Stream_LE( (uint8_t*) &c, 1, NULL);
//			Endpoint_ClearIN();
//			Endpoint_WaitUntilReady();
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
	
////	Endpoint_WaitUntilReady();
	Endpoint_Write_Stream_LE(buffer, strlen((char*)buffer), NULL);
////	Endpoint_ClearIN();

	// send empty packet to signal to host that read is finished
//	Endpoint_WaitUntilReady();
//	Endpoint_ClearIN();

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
				WriteStringFlush("\r\n");
			
			case '#':
				ServerRequest = EOLRequest;
				*ppBuffer = pBuffer;
				return DataLength;

			case ':':
				WriteStringFlush("# SREC\r\n");
				ServerRequest = EOLRequest;
				*ppBuffer = pBuffer;
				return DataLength;

			case 'j':
			case 'J': {
					int chain_len = JTAG_ChainLen();
					int ir_len = JTAG_IRLen();
					sprintf(output_buffer, "\r\n# JTAG scan:\r\n# chain length=%d, IR length=%d\r\n", chain_len, ir_len );
					WriteStringNoFlush(output_buffer);
					//Endpoint_Write_Stream_LE(output_buffer, strlen(output_buffer), NULL);
//					sprintf(output_buffer, "# IR length=%d\r\n# scan follows:\r\n", ir_len );
//					WriteStringFlush(output_buffer);
					//Endpoint_Write_Stream_LE(output_buffer, strlen(output_buffer), NULL);
				}
				JTAG_ChainInfo();
				WriteStringFlush("\r\n");
//				Endpoint_ClearIN();
//				Endpoint_WaitUntilReady();
//				Endpoint_ClearIN();

				ServerRequest = EOLRequest;
				*ppBuffer = pBuffer;
				return DataLength;

			default:
				WriteStringFlush("# Unknown command: ");
				ServerRequest = EchoToEOLRequest;
				return DataLength + 1;
		}
	}

	return 0;
}


