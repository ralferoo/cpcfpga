#include <LUFA/Drivers/USB/USB.h>
#include "disk.h"

//char sector_buffer[512];
static char sector_buffer[512];
char *bufp = sector_buffer;

bool sdc_v2;

void DISK_Init(void)
{
	int i;
	for (i=0; i<sizeof(sector_buffer); i++)
		sector_buffer[i]=i;

	SD_DDR &= ~(SD_SPARE | SD_CS | SD_MISO | SD_CLK | SD_MOSI);
}

void spi_pause(void)
{
	int i;
	for (i=0;i<80;i++)
		__asm__("nop");
}

uint8_t sd_send_recv(uint8_t byte)
{
//	sprintf_P(bufp,PSTR("[%02x] "),byte);
//	bufp+=5;
	int i;
	for (i=8; i; i--) {
		if (byte&0x80)
			SD_PORT |=  SD_MOSI;
		else
			SD_PORT &= ~SD_MOSI;
		byte<<=1;

		SD_PORT &= ~SD_CLK;
		spi_pause();

		if (SD_PIN & SD_MISO)
			byte |= 1;

//		sprintf_P(bufp,PSTR("%x "),byte&1);
//		bufp+=1;

//		sprintf_P(bufp,PSTR("%02x "),SD_PIN);
//		bufp+=2;

		SD_PORT |= SD_CLK;
		spi_pause();
	}
//	bufp++;
	return byte;
}

uint8_t sd_send_cmd(uint8_t cmd,uint32_t data,uint8_t xsum)
{
//	sprintf_P(sector_buffer,PSTR("cmd %02x data %08lx xsum %02x "), cmd, data, xsum);
//	bufp = sector_buffer+strlen(sector_buffer);

	uint8_t a,b,c,d,e,f,g;
	a = sd_send_recv(0xff);
	b = sd_send_recv(cmd | 0x40);
	c = sd_send_recv(data>>24);
	d = sd_send_recv(data>>16);
	e = sd_send_recv(data>>8);
	f = sd_send_recv(data);
	g = sd_send_recv(xsum);

	uint8_t result;
	int i;
	for (i=0;i<20;i++) {
//		bufp[-1]=':';
		result = sd_send_recv(0xff);
		if ((result&0x80) == 0)
			break;
	}

//	sprintf_P(bufp,PSTR("cmd %02x data %08lx xsum %02x ret %02x (i=%d)\n"), cmd, data, xsum, result, i);
//	bufp = bufp+strlen(bufp);
	return result;
}

int sd_initialise(void)
{
	SD_DDR  &= ~(SD_CS | SD_CLK );
	SD_PORT &= ~(SD_CS | SD_CLK);			// tri-state
	__asm__("nop"); __asm__("nop"); __asm__("nop");

	if ((SD_PIN & SD_CS)==0) {
		sprintf_P(sector_buffer,PSTR("CS already claimed - %02x...\n"), SD_PIN);
		return 0;
	}

	int i,j;

	// do 80 clocks with CS high to reset the chip
	for (i=0;i<160;i++) {
		SD_PIN = SD_CLK;	// toggle clock
		for (j=0;j<25;j++) {
			if ((SD_PIN & SD_CS)==0) {
				sprintf_P(sector_buffer,PSTR("CS already claimed %d...\n"), i);
				return 0;
			}
		}
	}

	SD_PORT |=  SD_CLK;
	SD_DDR  |=  SD_CLK;		// clock 1 again
	spi_pause();

	if ((SD_PIN & SD_CS)==0) {
		sprintf_P(sector_buffer,PSTR("CS already claimed FINAL...\n"));
		return 0;
	}

	sprintf_P(sector_buffer,PSTR("Asserting CS...\n"));

	SD_PORT &= ~SD_CS;
	SD_DDR  |= (SD_CS | SD_MOSI);		// select chip, allow data out
	spi_pause();

	sdc_v2 = false;
	int card = 0;
	uint8_t cmd_0_res = sd_send_cmd(0,0,0x95);
	if (cmd_0_res != 1)
		return 0;

	int bail = 10;
//	for (;;) {
	{
//	retry:
		uint8_t cmd_8_res = sd_send_cmd(8,0x1aa,0x87);
		if ((cmd_8_res&5)==1) {
			sd_send_recv(0xff);
			sd_send_recv(0xff);
			uint8_t c = sd_send_recv(0xff);
			uint8_t d = sd_send_recv(0xff);
			if (c==1 && d==0xaa)
				sdc_v2 = true;
		}
	retry41:
		sd_send_cmd(55,0,1);
		uint8_t cmd_41_res = sd_send_cmd(41,sdc_v2?(1<<30):0,0);
		card = cmd_41_res;
		/*
		if (cmd_41_res & 4) {
			uint8_t cmd_1_res=sd_send_cmd(1,0,1);
			if (cmd_1_res & 4) {
//				if (bail--)
//					goto retry41;
				break;
			}
			if ((cmd_1_res & 1)==0) {
				card = 2;
				break;
			}
		} else if ((cmd_41_res & 1)==0) {
			card = 1;
			break;
		}
		*/
	}

	if (sdc_v2) {
		sprintf_P(bufp,PSTR("SDCv2 "));
		bufp = bufp+strlen(bufp);
	}

	sprintf_P(bufp,PSTR("card type %d "), card);
	bufp = bufp+strlen(bufp);

//	sprintf_P(sector_buffer,PSTR("Init done...\n"));
	return 0;
}

void sd_finish(void)
{
	SD_DDR  &= ~(SD_CS | SD_CLK );
	SD_PORT &= ~(SD_CS | SD_CLK);			// tri-state
}

int read_sector(int track, int head, int sector, int len)
{
	sprintf_P(sector_buffer,PSTR("TRK %2d HD %d SEC %02x\n"), track, head, sector);
	sector_buffer[0]=0;
	bufp = sector_buffer + strlen(sector_buffer);


	if (sd_initialise()) {
	}

	sd_finish();

	return strlen(sector_buffer);
}

void DISK_Device_ProcessControlRequest(void)
{
	// useful to read this: https://groups.google.com/forum/#!msg/lufa-support/MQh2NR9BMgY/83hUkflfqQYJ

	if (USB_ControlRequest.bmRequestType == (REQDIR_DEVICETOHOST | REQTYPE_VENDOR | REQREC_DEVICE))
	{
		if (USB_ControlRequest.bRequest == 'R' ) {
			int param = USB_ControlRequest.wIndex;
			int head = (param&0x8000) ? 1:0;
			int track = (param>>8) & 0x7f;
			int sector = param & 0xff;

			int len=read_sector(track, head, sector, USB_ControlRequest.wLength);

			Endpoint_ClearSETUP();
			Endpoint_Write_Control_Stream_LE(sector_buffer, len); //USB_ControlRequest.wLength);
			Endpoint_ClearOUT();
		}
	}
	else if (USB_ControlRequest.bmRequestType == (REQDIR_HOSTTODEVICE | REQTYPE_VENDOR | REQREC_DEVICE))
	{
	}
}

