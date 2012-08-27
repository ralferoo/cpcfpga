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
 *  Main source file for the sidecar demo. This file contains the main tasks of the demo and
 *  is responsible for the initial application hardware configuration.
 */

#include "sidecar.h"
#include "jtag.h"
#include "server.h"

/** Contains the current baud rate and other settings of the virtual serial port. While this demo does not use
 *  the physical USART and thus does not use these settings, they must still be retained and returned to the host
 *  upon request or the host will assume the device is non-functional.
 *
 *  These values are set by the host via a class-specific request, however they are not required to be used accurately.
 *  It is possible to completely ignore these value or use other settings as the host is completely unaware of the physical
 *  serial link characteristics and instead sends and receives data in endpoint streams.
 */
static CDC_LineEncoding_t LineEncoding = { .BaudRateBPS = 0,
                                           .CharFormat  = CDC_LINEENCODING_OneStopBit,
                                           .ParityType  = CDC_PARITY_None,
                                           .DataBits    = 8                            };


int timer=0;
volatile bool timer_changed=0;

/*
ISR(TIMER1_COMPA_vect)
{
	timer++;
	timer_changed=1;

//	LEDs_ToggleLEDs( LEDS_LED1 );
} 
*/


void Sleep(void)
{
/*
	timer_changed = 0;
	while (!timer_changed) {
//		CDC_Task();
		USB_USBTask();
	}
*/
}


/** Main program entry point. This routine contains the overall program flow, including initial
 *  setup of all components and the main program loop.
 */
int main(void)
{
//	SerialNumberDescriptor_Init();
	SetupHardware();


   TCCR1B |= (1 << WGM12); // Configure timer 1 for CTC mode
//   TIMSK1 |= (1 << OCIE1A); // Enable CTC interrupt
//   OCR1A   = 15624; // Set CTC compare value to 1Hz at 1MHz AVR clock, with a prescaler of 64
   OCR1A   = 15624 >> 1; // Set CTC compare value to 1Hz at 8MHz AVR clock, with a prescaler of 1024

//   TCCR1B |= ((1 << CS10) | (1 << CS11)); // Start timer at Fcpu/64 
   TCCR1B |= ((1 << CS10) | (1 << CS12)); // Start timer at Fcpu/1024 
/*
*/



	LEDs_SetAllLEDs(LEDMASK_USB_NOTREADY);
	sei();

	for (;;)
	{
		CDC_Task();
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

	DDRD = 0;
	PORTD = ~0;
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
 *  of the USB device after enumeration - the device endpoints are configured and the CDC management task started.
 */
void EVENT_USB_Device_ConfigurationChanged(void)
{
	bool ConfigSuccess = true;

	/* Setup CDC Data Endpoints */
	ConfigSuccess &= Endpoint_ConfigureEndpoint(CDC_NOTIFICATION_EPNUM, EP_TYPE_INTERRUPT, ENDPOINT_DIR_IN,
	                                            CDC_NOTIFICATION_EPSIZE, ENDPOINT_BANK_SINGLE);
	ConfigSuccess &= Endpoint_ConfigureEndpoint(CDC_TX_EPNUM, EP_TYPE_BULK, ENDPOINT_DIR_IN,
	                                            CDC_TXRX_EPSIZE, ENDPOINT_BANK_SINGLE);
	ConfigSuccess &= Endpoint_ConfigureEndpoint(CDC_RX_EPNUM, EP_TYPE_BULK, ENDPOINT_DIR_OUT,
	                                            CDC_TXRX_EPSIZE, ENDPOINT_BANK_SINGLE);

	/* Reset line encoding baud rate so that the host knows to send new values */
	LineEncoding.BaudRateBPS = 0;

	/* Indicate endpoint configuration success or failure */
	LEDs_SetAllLEDs(ConfigSuccess ? LEDMASK_USB_READY : LEDMASK_USB_ERROR);
}

unsigned char jtag_buffer[65];

void RawJTAG(unsigned char tms_at_end, int num_bits)
{
	if (tms_at_end) {
		if (--num_bits < 0)
			return;
	}

	unsigned char *p = jtag_buffer;
	unsigned char idata = *p;
	unsigned char odata = 0;
	unsigned char mask = 0x01;

	JTAG_PORT &= ~JTAG_TMS;			// no TMS for most of the bits

	while (num_bits) {
		if (idata & mask)
			JTAG_PORT |= JTAG_TDI;
		else
			JTAG_PORT &= ~JTAG_TDI;		// set output bit

		if (JTAG_PIN & JTAG_TDO)
			odata |= mask;			// read input bit

		JTAG_PORT |=  JTAG_TCK;			// high clock

		mask = mask << 1;
		if( mask==0) {
			*p++ = odata;
			odata = 0;
			idata = *p;
			mask = 0x01;
		}
		JTAG_PORT &= ~JTAG_TCK;			// low clock

		num_bits--;
	}

	if (tms_at_end) {
		JTAG_PORT |= JTAG_TMS;			// TMS for last bit
		if (idata & mask)
			JTAG_PORT |= JTAG_TDI;
		else
			JTAG_PORT &= ~JTAG_TDI;		// set output bit

		if (JTAG_PIN & JTAG_TDO)
			odata |= mask;			// read input bit

		JTAG_PORT |=  JTAG_TCK;			// high clock
	}

	*p = odata;
	JTAG_PORT &= ~JTAG_TCK;				// low clock
}


/** Event handler for the USB_ControlRequest event. This is used to catch and process control requests sent to
 *  the device from the USB host before passing along unhandled control requests to the library for processing
 *  internally.
 */
void EVENT_USB_Device_ControlRequest(void)
{
	/* Process CDC specific control requests */
	if (USB_ControlRequest.bmRequestType == (REQDIR_DEVICETOHOST | REQTYPE_CLASS | REQREC_INTERFACE))
	{
		switch (USB_ControlRequest.bRequest)
		{
			case CDC_REQ_GetLineEncoding:
				Endpoint_ClearSETUP();

				/* Write the line coding data to the control endpoint */
				Endpoint_Write_Control_Stream_LE(&LineEncoding, sizeof(CDC_LineEncoding_t));
				Endpoint_ClearOUT();

				break;
		}
	}

	// useful to read this: https://groups.google.com/forum/#!msg/lufa-support/MQh2NR9BMgY/83hUkflfqQYJ

	else if (USB_ControlRequest.bmRequestType == (REQDIR_HOSTTODEVICE | REQTYPE_CLASS | REQREC_INTERFACE))
	{
		switch (USB_ControlRequest.bRequest)
		{
			case CDC_REQ_SetLineEncoding:
				Endpoint_ClearSETUP();

				/* Read the line coding data in from the host into the global struct */
				Endpoint_Read_Control_Stream_LE(&LineEncoding, sizeof(CDC_LineEncoding_t));
				Endpoint_ClearIN();
				break;
			case CDC_REQ_SetControlLineState:
				Endpoint_ClearSETUP();
				Endpoint_ClearStatusStage();

				/* NOTE: Here you can read in the line state mask from the host, to get the current state of the output handshake
				         lines. The mask is read in from the wValue parameter in USB_ControlRequest, and can be masked against the
						 CONTROL_LINE_OUT_* masks to determine the RTS and DTR line states using the following code:
				*/

				break;
		}
	}
	else if (USB_ControlRequest.bmRequestType == (REQDIR_DEVICETOHOST | REQTYPE_VENDOR | REQREC_DEVICE))
	{
		if (USB_ControlRequest.bRequest == 'O' ) {
			Endpoint_ClearSETUP();
			Endpoint_Write_Control_Stream_LE(jtag_buffer, USB_ControlRequest.wLength);
			Endpoint_ClearOUT();
			return;
		}

//		static int count=0;

		if (USB_ControlRequest.bRequest == 'j' ) {
			Endpoint_ClearSETUP();
			int i = USB_ControlRequest.wValue;
//			char tdo = (char) JTAG_ClockWithTMS( i&1, i&0x80, 1);

			if(i&0x80)
				JTAG_PORT |= JTAG_TMS;
			else
				JTAG_PORT &= ~JTAG_TMS;

			if(i&1)
				JTAG_PORT |= JTAG_TDI;
			else
				JTAG_PORT &= ~JTAG_TDI;

			char tdo = (JTAG_PIN & JTAG_TDO)?1:0;
			JTAG_PORT |= JTAG_TCK;

			Endpoint_Write_Control_Stream_LE(&tdo, 1);
			Endpoint_ClearOUT();

			JTAG_PORT &= ~JTAG_TCK;
			return;
		}

/*
		count++;
		if (USB_ControlRequest.wLength)
		{
			Endpoint_Write_Control_Stream_LE(&count, USB_ControlRequest.wLength);
			Endpoint_ClearOUT();
		}
		else {
			Endpoint_ClearStatusStage();
		}
*/
/*
		Endpoint_SelectEndpoint(CDC_TX_EPNUM);
		uint8_t buffer[48];
		sprintf_P((char*)buffer, PSTR("[D>H %02x %02x %04x %04x %04x count=%d]\r\n"),
			USB_ControlRequest.bmRequestType, USB_ControlRequest.bRequest,
			USB_ControlRequest.wValue, USB_ControlRequest.wIndex, USB_ControlRequest.wLength, count);
		Endpoint_Write_Stream_LE(buffer, strlen((char*)buffer), NULL);
		Endpoint_ClearIN();
*/
	}
	else if (USB_ControlRequest.bmRequestType == (REQDIR_HOSTTODEVICE | REQTYPE_VENDOR | REQREC_DEVICE))
	{
		if (USB_ControlRequest.bRequest == 'J' ) {
			Endpoint_ClearSETUP();
			Endpoint_Read_Control_Stream_LE(jtag_buffer, USB_ControlRequest.wLength);
			RawJTAG((unsigned char)USB_ControlRequest.wValue, USB_ControlRequest.wIndex);
			Endpoint_ClearIN();
			return;
		}

/*
		Endpoint_SelectEndpoint(CDC_TX_EPNUM);
		uint8_t buffer[32];
		sprintf_P((char*)buffer, PSTR("[H>D %02x %02x %04x %04x %04x]\r\n"),
			USB_ControlRequest.bmRequestType, USB_ControlRequest.bRequest,
			USB_ControlRequest.wValue, USB_ControlRequest.wIndex, USB_ControlRequest.wLength);
		Endpoint_Write_Stream_LE(buffer, strlen((char*)buffer), NULL);
		Endpoint_ClearIN();
*/
	}
}

/** Function to manage CDC data transmission and reception to and from the host. */
void CDC_Task(void)
{
	/* Device must be connected and configured for the task to run */
	if (USB_DeviceState != DEVICE_STATE_Configured)
	  return;

	if ( LineEncoding.BaudRateBPS)
	{
		Endpoint_SelectEndpoint(CDC_RX_EPNUM);
		if (Endpoint_IsOUTReceived()) {
			/* Create a temp buffer big enough to hold the incoming endpoint packet */
			uint8_t  Buffer[ Endpoint_BytesInEndpoint()];

			/* Remember how large the incoming packet is */
			uint16_t DataLength = Endpoint_BytesInEndpoint();

			/* Read in the incoming packet into the buffer */
			Endpoint_Read_Stream_LE(&Buffer, DataLength, NULL);

			/* Finalize the stream transfer to send the last packet */
			Endpoint_ClearOUT();

			/* Select the Serial Tx Endpoint */
			Endpoint_SelectEndpoint(CDC_TX_EPNUM);

			uint8_t* pBuffer = Buffer;
			while( DataLength ) {
				DataLength = (*ServerRequest)( &pBuffer, DataLength );
			}

			/* Remember if the packet to send completely fills the endpoint */
			uint16_t Length = Endpoint_BytesInEndpoint();

			if( Length != 0 )
			{
				bool IsFull = (Length  == CDC_TXRX_EPSIZE);

				/* Finalize the stream transfer to send the last packet */
				Endpoint_ClearIN();

				/* If the last packet filled the endpoint, send an empty packet to release the buffer on
				 * the receiver (otherwise all data will be cached until a non-full packet is received) */
				if (IsFull)
				{
					/* Wait until the endpoint is ready for another packet */
					Endpoint_WaitUntilReady();

					/* Send an empty packet to ensure that the host does not buffer data sent to it */
					Endpoint_ClearIN();
				}
			}
		}
	}
}
