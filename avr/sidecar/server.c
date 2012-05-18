#include "sidecar.h"
#include "server.h"
#include "jtag.h"
#include "prom.h"
#include "hex.h"

uint16_t (*ServerRequest)( uint8_t** ppBuffer, uint16_t DataLength )
	= &DefaultRequest;

char output_buffer[ 128 ];

/////////////////////////////////////////////////////////////////////////////

void WriteString( const char* str )
{
	Endpoint_Write_Stream_LE( (uint8_t*) str, strlen(str), NULL);
}

void WriteStringConst( const char* PROGMEM str )
{
	char c;
	while( (c=pgm_read_byte( str++ )) )
		Endpoint_Write_Stream_LE( (uint8_t*) &c, 1, NULL);
}

void WriteInt( uint16_t i )
{
	sprintf_P(output_buffer,PSTR("%d"), i);
	Endpoint_Write_Stream_LE( (uint8_t*) output_buffer, strlen(output_buffer), NULL);
}

void WriteIntHex2( uint8_t i )
{
	sprintf_P(output_buffer,PSTR("%02X"), i);
	Endpoint_Write_Stream_LE( (uint8_t*) output_buffer, 2, NULL);
}

void WriteIntHex4( uint16_t i )
{
	sprintf_P(output_buffer,PSTR("%04X"), i);
	Endpoint_Write_Stream_LE( (uint8_t*) output_buffer, 4, NULL);
}

void WriteCRLF( void )
{
	Endpoint_Write_PStream_LE( PSTR("\r\n"), 2, NULL);
}

/*
void FlushBuffer( void )
{
	USB_USBTask();
	if (USB_DeviceState != DEVICE_STATE_Unattached) {
		uint8_t PrevEndpoint = Endpoint_GetCurrentEndpoint();
		
		Endpoint_SelectEndpoint(ENDPOINT_CONTROLEP);
		
		if (Endpoint_IsSETUPReceived()) {
			Endpoint_SelectEndpoint(PrevEndpoint);
			Endpoint_ClearIN();
			Endpoint_SelectEndpoint(ENDPOINT_CONTROLEP);
			USB_Device_ProcessControlRequest();
		}
		
		Endpoint_SelectEndpoint(PrevEndpoint);
	}
}
*/

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
	sprintf_P((char*)buffer+len, PSTR("[%d]\r\n"), len);
	
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

			case 't': case 'T':
				WriteStringConst( PSTR("# test string\n") );
				ServerRequest = EOLRequest;
				*ppBuffer = pBuffer;
				return DataLength;

			case '-':
				for( int i=0; i<79; i++)
					Endpoint_Write_PStream_LE(PSTR("-"), 1, NULL);
				WriteString("\r\n");
			
			case '#':
				ServerRequest = EOLRequest;
				*ppBuffer = pBuffer;
				return DataLength;

			case ':':
				StartHEXRequest();
				*ppBuffer = pBuffer;
				return DataLength;
//				WriteString("# HEX\r\n");
//				ServerRequest = EOLRequest;
//				*ppBuffer = pBuffer;
//				return DataLength;

			case 'j':
			case 'J': {
					WriteStringConst( PSTR("# JTAG scan:\r\n# chain length="));
					int chain_len = JTAG_ChainLen();
					WriteInt( chain_len );
					WriteStringConst( PSTR(", IR length="));
					int ir_len = JTAG_IRLen();
					WriteInt( ir_len );
					WriteStringConst( PSTR("\r\n"));
				}
				JTAG_ChainInfo();
				WriteStringConst(PSTR("\r\n"));

				ServerRequest = EOLRequest;
				*ppBuffer = pBuffer;
				return DataLength;

			case 'e':
			case 'E':
				WriteStringConst( PSTR("# PROM erase start\r\n"));
				PROM_Erase( 0, 6, 0, 1 );
				WriteStringConst( PSTR("# PROM erase finished\r\n"));
				ServerRequest = EOLRequest;
				*ppBuffer = pBuffer;
				return DataLength;

			case 'p':
			case 'P':
				WriteStringConst(PSTR("# PROM write\r\n"));
				PROM_Program( 0, 6, 0, 1 );
				ServerRequest = EOLRequest;
				StartHEX( HEX_Program );
				*ppBuffer = pBuffer;
				return DataLength;

			case 'r':
			case 'R':
				WriteStringConst( PSTR("# PROM dump\r\n"));
				PROM_Dump( 0, 6, 0, 1 );
				ServerRequest = EOLRequest;
				*ppBuffer = pBuffer;
				return DataLength;

			case 'w':
			case 'W':
				for(;;) {
					for(int i=0; i<16; i++) {
						WriteIntHex2( PORTD );
						WriteStringConst(PSTR(" "));
						Endpoint_ClearIN();
						Endpoint_WaitUntilReady();
						JTAG_RunTestTCK(10000);
					}
					WriteCRLF();
					USB_USBTask();
				}

			default:
				WriteStringConst( PSTR("# Unknown command: "));
				ServerRequest = EchoToEOLRequest;
				return DataLength + 1;
		}
	}

	return 0;
}


