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


/** Main program entry point. This routine contains the overall program flow, including initial
 *  setup of all components and the main program loop.
 */
int main(void)
{
	SetupHardware();

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

/** Event handler for the USB_ControlRequest event. This is used to catch and process control requests sent to
 *  the device from the USB host before passing along unhandled control requests to the library for processing
 *  internally.
 */
void EVENT_USB_Device_ControlRequest(void)
{
	/* Process CDC specific control requests */
	switch (USB_ControlRequest.bRequest)
	{
		case CDC_REQ_GetLineEncoding:
			if (USB_ControlRequest.bmRequestType == (REQDIR_DEVICETOHOST | REQTYPE_CLASS | REQREC_INTERFACE))
			{
				Endpoint_ClearSETUP();

				/* Write the line coding data to the control endpoint */
				Endpoint_Write_Control_Stream_LE(&LineEncoding, sizeof(CDC_LineEncoding_t));
				Endpoint_ClearOUT();
			}

			break;
		case CDC_REQ_SetLineEncoding:
			if (USB_ControlRequest.bmRequestType == (REQDIR_HOSTTODEVICE | REQTYPE_CLASS | REQREC_INTERFACE))
			{
				Endpoint_ClearSETUP();

				/* Read the line coding data in from the host into the global struct */
				Endpoint_Read_Control_Stream_LE(&LineEncoding, sizeof(CDC_LineEncoding_t));
				Endpoint_ClearIN();
			}

			break;
		case CDC_REQ_SetControlLineState:
			if (USB_ControlRequest.bmRequestType == (REQDIR_HOSTTODEVICE | REQTYPE_CLASS | REQREC_INTERFACE))
			{
				Endpoint_ClearSETUP();
				Endpoint_ClearStatusStage();

				/* NOTE: Here you can read in the line state mask from the host, to get the current state of the output handshake
				         lines. The mask is read in from the wValue parameter in USB_ControlRequest, and can be masked against the
						 CONTROL_LINE_OUT_* masks to determine the RTS and DTR line states using the following code:
				*/
			}

			break;
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

void xxx(void)
{
	char*       ReportString    = NULL;
	uint8_t     JoyStatus_LCL   = Joystick_GetStatus();
	static bool ActionSent      = false;

	/* Determine if a joystick action has occurred */
	if (JoyStatus_LCL & JOY_UP)
	  ReportString = "Joystick Up\r\n";
	else if (JoyStatus_LCL & JOY_DOWN)
	  ReportString = "Joystick Down\r\n";
	else if (JoyStatus_LCL & JOY_LEFT)
	  ReportString = "Joystick Left\r\n";
	else if (JoyStatus_LCL & JOY_RIGHT)
	  ReportString = "Joystick Right\r\n";
	else if (JoyStatus_LCL & JOY_PRESS)
	  ReportString = "Joystick Pressed\r\n";
	else
	  ActionSent = false;

	/* Flag management - Only allow one string to be sent per action */
	if ((ReportString != NULL) && (ActionSent == false) && LineEncoding.BaudRateBPS)
	{
		ActionSent = true;

		/* Select the Serial Tx Endpoint */
		Endpoint_SelectEndpoint(CDC_TX_EPNUM);

		/* Write the String to the Endpoint */
		Endpoint_Write_Stream_LE(ReportString, strlen(ReportString), NULL);

		/* Remember if the packet to send completely fills the endpoint */
		bool IsFull = (Endpoint_BytesInEndpoint() == CDC_TXRX_EPSIZE);

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

	/* Select the Serial Rx Endpoint */
	Endpoint_SelectEndpoint(CDC_RX_EPNUM);

	/* Throw away any received data from the host */
	if (Endpoint_IsOUTReceived())
	  Endpoint_ClearOUT();
}

