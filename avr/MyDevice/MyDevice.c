/*
             LUFA Library
     Copyright (C) Dean Camera, 2012.

  dean [at] fourwalledcubicle [dot] com
           www.lufa-lib.org
*/

/*
  Copyright 2012  Dean Camera (dean [at] fourwalledcubicle [dot] com)

  Permission to use, copy, modify, distribute, and sell this
  software and its documentation for any purpose is hereby granted
  without fee, provided that the above copyright notice appear in
  all copies and that both that the copyright notice and this
  permission notice and warranty disclaimer appear in supporting
  documentation, and that the name of the author not be used in
  advertising or publicity pertaining to distribution of the
  software without specific, written prior permission.

  The author disclaim all warranties with regard to this
  software, including all implied warranties of merchantability
  and fitness.  In no event shall the author be liable for any
  special, indirect or consequential damages or any damages
  whatsoever resulting from loss of use, data or profits, whether
  in an action of contract, negligence or other tortious action,
  arising out of or in connection with the use or performance of
  this software.
*/

/** \file
 *
 *  Main source file for the MyDevice demo. This file contains the main tasks of the demo and
 *  is responsible for the initial application hardware configuration.
 */

#include "MyDevice.h"
#include "jtag.h"

#include <avr/io.h>          // include I/O definitions (port names, pin names, etc)
#include <avr/interrupt.h>   // include interrupt support 

/** Contains the current baud rate and other settings of the first virtual serial port. While this demo does not use
 *  the physical USART and thus does not use these settings, they must still be retained and returned to the host
 *  upon request or the host will assume the device is non-functional.
 *
 *  These values are set by the host via a class-specific request, however they are not required to be used accurately.
 *  It is possible to completely ignore these value or use other settings as the host is completely unaware of the physical
 *  serial link characteristics and instead sends and receives data in endpoint streams.
 */
static CDC_LineEncoding_t LineEncoding1 = { .BaudRateBPS = 0,
                                            .CharFormat  = CDC_LINEENCODING_OneStopBit,
                                            .ParityType  = CDC_PARITY_None,
                                            .DataBits    = 8                            };

/** Contains the current baud rate and other settings of the second virtual serial port. While this demo does not use
 *  the physical USART and thus does not use these settings, they must still be retained and returned to the host
 *  upon request or the host will assume the device is non-functional.
 *
 *  These values are set by the host via a class-specific request, however they are not required to be used accurately.
 *  It is possible to completely ignore these value or use other settings as the host is completely unaware of the physical
 *  serial link characteristics and instead sends and receives data in endpoint streams.
 */
static CDC_LineEncoding_t LineEncoding2 = { .BaudRateBPS = 0,
                                            .CharFormat  = CDC_LINEENCODING_OneStopBit,
                                            .ParityType  = CDC_PARITY_None,
                                            .DataBits    = 8                            };


volatile int timer=0;
volatile bool timer_changed=0;

ISR(TIMER1_COMPA_vect)
{
	timer++;
	timer_changed=1;
} 

///////////////////////////////////////////////////////////////////////////////

/** Main program entry point. This routine configures the hardware required by the application, then
 *  enters a loop to run the application tasks in sequence.
 */
int main(void)
{
	SetupHardware();

	LEDs_SetAllLEDs(LEDMASK_USB_NOTREADY);

   TCCR1B |= (1 << WGM12); // Configure timer 1 for CTC mode
   TIMSK1 |= (1 << OCIE1A); // Enable CTC interrupt
   OCR1A   = 15624; // Set CTC compare value to 1Hz at 1MHz AVR clock, with a prescaler of 64

   TCCR1B |= (1 << CS11); // Start timer at Fcpu/8 
//   TCCR1B |= ((1 << CS10) | (1 << CS11)); // Start timer at Fcpu/64 
//   TCCR1B |= ((1 << CS10) | (1 << CS12)); // Start timer at Fcpu/1024 
//   TCCR1B |= (1 << CS10); // Start timer at Fcpu/1024 

	sei();

	JTAG_Reset();

	for (;;)
	{
		Server_Task();
//		CDC1_Task();
//		CDC1_Task();
		USB_USBTask();
	}
}

/** Configures the board hardware and chip peripherals for the demo's functionality. */
void SetupHardware(void)
{
	/* Disable watchdog if enabled by bootloader/fuses */
	MCUSR &= ~(1 << WDRF);
	wdt_disable();

	/* Disable clock division */
	clock_prescale_set(clock_div_1);

	/* Hardware Initialization */
	Joystick_Init();
	LEDs_Init();
	USB_Init();
	JTAG_Init();

	JTAG_SelectIR();
	JTAG_SelectDR();
}

/** Event handler for the USB_Connect event. This indicates that the device is enumerating via the status LEDs and
 *  starts the library USB task to begin the enumeration and USB management process.
 */
void EVENT_USB_Device_Connect(void)
{
	/* Indicate USB enumerating */
	LEDs_SetAllLEDs(LEDMASK_USB_ENUMERATING);
}

/** Event handler for the USB_Disconnect event. This indicates that the device is no longer connected to a host via
 *  the status LEDs and stops the USB management and CDC management tasks.
 */
void EVENT_USB_Device_Disconnect(void)
{
	/* Indicate USB not ready */
	LEDs_SetAllLEDs(LEDMASK_USB_NOTREADY);
}

/** Event handler for the USB_ConfigurationChanged event. This is fired when the host set the current configuration
 *  of the USB device after enumeration - the device endpoints are configured and the CDC management tasks are started.
 */
void EVENT_USB_Device_ConfigurationChanged(void)
{
	bool ConfigSuccess = true;

	/* Setup first CDC Interface's Endpoints */
//	ConfigSuccess &= Endpoint_ConfigureEndpoint(CDC1_TX_EPNUM, EP_TYPE_BULK, ENDPOINT_DIR_IN,
//	                                            CDC_TXRX_EPSIZE, ENDPOINT_BANK_SINGLE);
//	ConfigSuccess &= Endpoint_ConfigureEndpoint(CDC1_RX_EPNUM, EP_TYPE_BULK, ENDPOINT_DIR_OUT,
//	                                            CDC_TXRX_EPSIZE, ENDPOINT_BANK_SINGLE);
//	ConfigSuccess &= Endpoint_ConfigureEndpoint(CDC1_NOTIFICATION_EPNUM, EP_TYPE_INTERRUPT, ENDPOINT_DIR_IN,
//	                                            CDC_NOTIFICATION_EPSIZE, ENDPOINT_BANK_SINGLE);

	/* Setup second CDC Interface's Endpoints */
	ConfigSuccess &= Endpoint_ConfigureEndpoint(CDC1_TX_EPNUM, EP_TYPE_BULK, ENDPOINT_DIR_IN,
	                                            CDC_TXRX_EPSIZE, ENDPOINT_BANK_SINGLE);
	ConfigSuccess &= Endpoint_ConfigureEndpoint(CDC1_RX_EPNUM, EP_TYPE_BULK, ENDPOINT_DIR_OUT,
	                                            CDC_TXRX_EPSIZE, ENDPOINT_BANK_SINGLE);
	ConfigSuccess &= Endpoint_ConfigureEndpoint(CDC1_NOTIFICATION_EPNUM, EP_TYPE_INTERRUPT, ENDPOINT_DIR_IN,
	                                            CDC_NOTIFICATION_EPSIZE, ENDPOINT_BANK_SINGLE);

	/* Reset line encoding baud rates so that the host knows to send new values */
	LineEncoding1.BaudRateBPS = 0;
	LineEncoding2.BaudRateBPS = 0;

	/* Indicate endpoint configuration success or failure */
	LEDs_SetAllLEDs(ConfigSuccess ? LEDMASK_USB_READY : LEDMASK_USB_ERROR);
}

/** Event handler for the USB_ControlRequest event. This is used to catch and process control requests sent to
 *  the device from the USB host before passing along unhandled control requests to the library for processing
 *  internally.
 */
void EVENT_USB_Device_ControlRequest(void)
{
	/* Determine which interface's Line Coding data is being set from the wIndex parameter */
	void* LineEncodingData = (USB_ControlRequest.wIndex == 0) ? &LineEncoding1 : &LineEncoding2;

	/* Process CDC specific control requests */
	switch (USB_ControlRequest.bRequest)
	{
		case CDC_REQ_GetLineEncoding:
			if (USB_ControlRequest.bmRequestType == (REQDIR_DEVICETOHOST | REQTYPE_CLASS | REQREC_INTERFACE))
			{
				Endpoint_ClearSETUP();

				/* Write the line coding data to the control endpoint */
				Endpoint_Write_Control_Stream_LE(LineEncodingData, sizeof(CDC_LineEncoding_t));
				Endpoint_ClearOUT();
			}

			break;
		case CDC_REQ_SetLineEncoding:
			if (USB_ControlRequest.bmRequestType == (REQDIR_HOSTTODEVICE | REQTYPE_CLASS | REQREC_INTERFACE))
			{
				Endpoint_ClearSETUP();

				/* Read the line coding data in from the host into the global struct */
				Endpoint_Read_Control_Stream_LE(LineEncodingData, sizeof(CDC_LineEncoding_t));
				Endpoint_ClearIN();
			}

			break;
		case CDC_REQ_SetControlLineState:
			if (USB_ControlRequest.bmRequestType == (REQDIR_HOSTTODEVICE | REQTYPE_CLASS | REQREC_INTERFACE))
			{
				Endpoint_ClearSETUP();
				Endpoint_ClearStatusStage();
			}

			break;
	}
}

char testdata[100];

/** Function to manage CDC data transmission and reception to and from the host for the first CDC interface, which sends joystick
 *  movements to the host as ASCII strings.
 */
void xCDC1_Task(void)
{
	char*       ReportString    = NULL;
	uint8_t     JoyStatus_LCL   = Joystick_GetStatus();
	static bool ActionSent      = false;

	/* Device must be connected and configured for the task to run */
	if (USB_DeviceState != DEVICE_STATE_Configured)
	  return;

	/* Determine if a joystick action has occurred */
	if (timer_changed) {
		timer_changed=0;
		sprintf(testdata, "timer=%d\r\n", timer);
	  	ActionSent = false;
		ReportString=testdata;
//	  ReportString = "Joystick Up\r\n";
	}
	else if (JoyStatus_LCL & JOY_DOWN) {
	  ReportString = "Joystick Down\r\n";
	}
	else if (JoyStatus_LCL & JOY_LEFT)
	  ReportString = "Joystick Left\r\n";
	else if (JoyStatus_LCL & JOY_RIGHT)
	  ReportString = "Joystick Right\r\n";
	else if (JoyStatus_LCL & JOY_PRESS) {
	  ReportString = "Joystick Pressed\r\n";
		sprintf(testdata, "joystick timer=%d\r\n", timer);
		ReportString=testdata;
	}
	else
	  ActionSent = false;

	/* Flag management - Only allow one string to be sent per action */
	if ((ReportString != NULL) && (ActionSent == false) && LineEncoding1.BaudRateBPS)
	{
		ActionSent = true;

		/* Select the Serial Tx Endpoint */
		Endpoint_SelectEndpoint(CDC1_TX_EPNUM);

	    	if (Endpoint_IsReadWriteAllowed()) {

			/* Write the String to the Endpoint */
			Endpoint_Write_Stream_LE(ReportString, strlen(ReportString), NULL);

			/* Finalize the stream transfer to send the last packet */
			Endpoint_ClearIN();

			/* Wait until the endpoint is ready for another packet */
			Endpoint_WaitUntilReady();

			/* Send an empty packet to ensure that the host does not buffer data sent to it */
			Endpoint_ClearIN();
		}
	}

	/* Select the Serial Rx Endpoint */
	Endpoint_SelectEndpoint(CDC1_RX_EPNUM);

	/* Throw away any received data from the host */
/*
	if (Endpoint_IsOUTReceived()) {
		timer += 10;
	  Endpoint_ClearOUT();
	}
*/
}

/** Function to manage CDC data transmission and reception to and from the host for the second CDC interface, which echoes back
 *  all data sent to it from the host.
 */
void CDC1_Task(void)
{
	static int timer_check = 0;

	/* Device must be connected and configured for the task to run */
	if (USB_DeviceState != DEVICE_STATE_Configured)
	  return;

	/* Select the Serial Rx Endpoint */
	Endpoint_SelectEndpoint(CDC1_RX_EPNUM);

	/* Check to see if any data has been received */
	if (Endpoint_IsOUTReceived())
	{
		/* Create a temp buffer big enough to hold the incoming endpoint packet */
		uint8_t  Buffer[ 100 ]; //Endpoint_BytesInEndpoint()];

		/* Remember how large the incoming packet is */
		uint16_t DataLength = Endpoint_BytesInEndpoint();

		/* Read in the incoming packet into the buffer */
		Endpoint_Read_Stream_LE(&Buffer, DataLength, NULL);

		/* Finalize the stream transfer to send the last packet */
		Endpoint_ClearOUT();

		/* Select the Serial Tx Endpoint */
		Endpoint_SelectEndpoint(CDC1_TX_EPNUM);

		/* Write the received data to the endpoint */
		Endpoint_Write_Stream_LE(&Buffer, DataLength, NULL);
//		sprintf(Buffer,"recv=%d\n", DataLength );
//		Endpoint_Write_Stream_LE(&Buffer, strlen(Buffer), NULL);

		timer_changed=0;
		while (timer_changed==0);
		
		JTAG_Reset();
		JTAG_SelectDR();
		timer = 0;

		/* Finalize the stream transfer to send the last packet */
		Endpoint_ClearIN();

//		/* Wait until the endpoint is ready for the next packet */
//		Endpoint_WaitUntilReady();

//		/* Send an empty packet to prevent host buffering */
//		Endpoint_ClearIN();
	}
	else
	{
		if (timer != timer_check) {
			timer_check = timer;
			Endpoint_SelectEndpoint(CDC1_TX_EPNUM);

		    	if (Endpoint_IsReadWriteAllowed()) {
				uint8_t  Buffer[ 100 ]; //Endpoint_BytesInEndpoint()];

				if (timer > 100 )
				{
					int chain_len = JTAG_ChainLen();
					sprintf((char*)Buffer, "\r\nReset, chain length=%d\r\n", chain_len );
					Endpoint_Write_Stream_LE(&Buffer, strlen((char*)Buffer), NULL);

					JTAG_ChainInfo();

					JTAG_Reset();
					JTAG_SelectDR();
					JTAG_SendClock(0);
					JTAG_SendClock(0);			// move to shift-DR

					timer=0;
				} else {
					int tdo = JTAG_Clock((timer>5) && (timer&1)); // !(timer & 128) );

					/* Write the String to the Endpoint */
//					Endpoint_Write_Stream_LE(".", 1, NULL);
					sprintf((char*)Buffer, "%d\r\n", tdo);
					if (timer&63)
						Buffer[1]=0;
					Endpoint_Write_Stream_LE(&Buffer, strlen((char*)Buffer), NULL);
				}

				/* Finalize the stream transfer to send the last packet */
				Endpoint_ClearIN();

				/* Wait until the endpoint is ready for another packet */
				Endpoint_WaitUntilReady();

				/* Send an empty packet to ensure that the host does not buffer data sent to it */
				Endpoint_ClearIN();
			}
		}
	}
}


// ah! the reason it doesn't work is that the u2 chips don't have enough endpoints for 2 serial ports. HURR.
// https://groups.google.com/forum/#!topic/lufa-support/4xuaJWk6_sU



/////////////////////////////////////////////////////////////////////////////

uint16_t DefaultRequest( uint8_t** ppBuffer, uint16_t DataLength );

uint16_t (*ServerRequest)( uint8_t** ppBuffer, uint16_t DataLength )
	= &DefaultRequest;

/////////////////////////////////////////////////////////////////////////////

void WriteStringFlush( char* str )
{
	Endpoint_Write_Stream_LE( (uint8_t*) str, strlen(str), NULL);
	Endpoint_ClearIN();
	Endpoint_WaitUntilReady();
	Endpoint_ClearIN();
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
	
	Endpoint_WaitUntilReady();
	Endpoint_Write_Stream_LE(buffer, strlen((char*)buffer), NULL);
	Endpoint_ClearIN();

	// send empty packet to signal to host that read is finished
	Endpoint_WaitUntilReady();
	Endpoint_ClearIN();

	*ppBuffer = pBuffer;
	return DataLength - len;
}

char output_buffer[ 128 ];

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

			case '#':
				ServerRequest = EOLRequest;
				*ppBuffer = pBuffer;
				return DataLength;

			case ':':
				WriteStringFlush("# SREC\r\n");
				ServerRequest = EOLRequest;
				*ppBuffer = pBuffer;
				return DataLength;

			case 'J': {
					int chain_len = JTAG_ChainLen();
					int ir_len = JTAG_IRLen();
					sprintf(output_buffer, "\r\n# JTAG scan:\r\n# chain length=%d, IR length=%d\r\n", chain_len, ir_len );
					WriteStringFlush(output_buffer);
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

void Server_Task(void)
{
	static int timer_check = 0;

	/* Device must be connected and configured for the task to run */
	if (USB_DeviceState != DEVICE_STATE_Configured)
	  return;

	/* Select the Serial Rx Endpoint */
	Endpoint_SelectEndpoint(CDC1_RX_EPNUM);

	/* Check to see if any data has been received */
	if (Endpoint_IsOUTReceived())
	{
		/* Create a temp buffer big enough to hold the incoming endpoint packet */
		uint8_t  Buffer[ Endpoint_BytesInEndpoint()];

		/* Remember how large the incoming packet is */
		uint16_t DataLength = Endpoint_BytesInEndpoint();

		/* Read in the incoming packet into the buffer */
		Endpoint_Read_Stream_LE(&Buffer, DataLength, NULL);

		/* Finalize the stream transfer to send the last packet */
		Endpoint_ClearOUT();

		/* Select the Serial Tx Endpoint */
		Endpoint_SelectEndpoint(CDC1_TX_EPNUM);

		uint8_t* pBuffer = Buffer;
		while( DataLength ) {
			DataLength = (*ServerRequest)( &pBuffer, DataLength );
		}
	}
}


// ah! the reason it doesn't work is that the u2 chips don't have enough endpoints for 2 serial ports. HURR.
// https://groups.google.com/forum/#!topic/lufa-support/4xuaJWk6_sU






