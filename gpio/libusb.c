// #define DUMP_ALL_JTAG_TRAFFIC

#include <time.h>
#include <errno.h>

#include "gpio.h"

#include <stdio.h>
#include <usb.h>

//#define DO_LOG

//#define BIGLOG

#ifdef DUMP_ALL_JTAG_TRAFFIC
int dumper_fd = -1;
unsigned char dumper_buffer[10000];
int dumper_bufptr = 0;
#endif

void TrafficDumpExit(void)
{
#ifdef DUMP_ALL_JTAG_TRAFFIC
	if (dumper_fd >= 0) {
		if (dumper_bufptr) {
			int wlen = write(dumper_fd, dumper_buffer, dumper_bufptr);
			if (dumper_bufptr != wlen)
				printf("Error flushing final jtag buffer wrote %d instead of %d bytes\n", wlen, dumper_bufptr);
		}
		close(dumper_fd);
		dumper_fd = -1;
		dumper_bufptr = 0;
	}
#endif
}

void TrafficDumpBits(int tms_at_end, int num_bits, unsigned char* send, unsigned char* recv)
{
#ifdef DUMP_ALL_JTAG_TRAFFIC
	unsigned char mask = 1;
	while (num_bits > 0) {
		unsigned char out = ((*send) & mask) ? 1 : 0;		//    1=TDI (from us to JTAG)
		if (recv) {
			if ((*recv) & mask)) out |= 2;			//    2=TDO (from JTAG to us) 
		} else out |= 0x40;					// 0x40=TDO unknown
		if (tms_at_end && num_bits==1) out |= 0x80		// 0x80=TMS (JTAG transition)

		if (dumper_bufptr == sizeof(dumper_buffer)) {
			if (dumper_fd >= 0) {
				int wlen = write(dumper_fd, dumper_buffer, dumper_bufptr);
				if (dumper_bufptr != wlen)
					printf("Error flushing jtag buffer wrote %d instead of %d bytes\n", wlen, dumper_bufptr);
			}
			dumper_bufptr = 0;
		}

		dumper_buffer[ dumper_bufptr++ ] = out;

		if (mask == 0x80) {
			mask=1;
			send++;
			recv++;
		} else {
			mask <<= 1;
		}
		num_bits--;
	}
#endif
}

void TrafficDumpInit(void)
{
#ifdef DUMP_ALL_JTAG_TRAFFIC
	if (dumper_fd < 0) {
		char path_buffer[128];
		sprintf(path_buffer, "/tmp/jtag-%ld.log", time(0) );
		dumper_fd = open(path, O_WRONLY | O_CREAT, 0777);
		dumper_bufptr = 0;

		atexit(TrafficDumpExit);
	}
#endif
}

usb_dev_handle *libusb_handle;

usb_dev_handle *find_cpc2013(void);

/*****************************************************************************
 *
 * usb_control_msg(libusb_handle, 0xc0, cmd, value, index, data_addr, data_len, timeout);
 *
 * Possible states = Shift, Update, Pause, Reset, Idle
 *
 * '?' GetVersion ()
 * 'J' RawJTAG (tms_at_end, length_in_bits)
 * 'O' GetOutput ()
 * 'I' ShiftIR (endstate, length_in_bits)
 * 'D' ShiftDR (endstate, length_in_bits)
 * 'Z' Idle (clocks)
 * 'R' Reset ()
 *
 * JTAG start state, end state
 * length_in_bits
 *
 *****************************************************************************/

usb_dev_handle *find_cpc2013(void)
{
        struct usb_bus *bus;
        struct usb_device *dev;
        usb_dev_handle *device_handle = 0;

	for (bus=usb_busses; bus; bus=bus->next) {
		for (dev=bus->devices; dev; dev=dev->next) {
//			printf("found %04x:%04x\n", dev->descriptor.idVendor, dev->descriptor.idProduct);
			if (dev->descriptor.idVendor == 0x1d50 && dev->descriptor.idProduct == 0x6063) {
				printf("Found possible CPC2013 device %04x:%04x, manuf #%02x product #%02x serial #%02x\n",
					dev->descriptor.idVendor, dev->descriptor.idProduct,
					dev->descriptor.iManufacturer, dev->descriptor.iProduct,
					dev->descriptor.iSerialNumber );

				device_handle = usb_open(dev);

				char nbuffer[65];
				int len,i;
				char *strname="";

				for(i=0;i<3; i++) {
					int desc;
					switch (i) {
						default:
							desc=dev->descriptor.iManufacturer;
							strname="manufacturer";
							break;
						case 1:
							desc=dev->descriptor.iProduct;
							strname="product";
							break;
						case 2:
							desc=dev->descriptor.iSerialNumber;
							strname="serial no";
							break;
					}
					len = usb_get_string_simple(device_handle, desc, nbuffer, sizeof(nbuffer) );
					if (len>=0) {
						printf("#%02x %-12s %s (len %d)\n", desc, strname, nbuffer, len );
					}

					if ( desc == dev->descriptor.iManufacturer )
					{
						if (strcmp(nbuffer,"cpcfpga.com")) {
							usb_close(device_handle);
							device_handle = NULL;
							break;
						}
					}
				}

//				len = usb_control_msg(libusb_handle, 0xc0, '?', 0, 0, &byte, 8, 500);

				return device_handle;
			}
		}
	}
}

///////////////////////////////////////////////////////////////////////////

void jtagInit(void)
{
	usb_init();
	usb_set_debug(0);
	usb_find_busses();
	usb_find_devices();

	usb_set_debug(3);		// logging

	libusb_handle = find_cpc2013();
	if (libusb_handle == NULL) {
		printf("No cpc2013 device found, aborting...\n");
		exit(10);
	}

//	usb_close(handle);
}

///////////////////////////////////////////////////////////////////////////

// #define DO_LOG

#ifdef USB_SPEEDUP
void jtagSendAndReceiveBitsRaw(int tms_at_end, int num_bits, unsigned char* send, unsigned char* recv_real)
{
	unsigned char recv_tmp[64];
#ifdef BIGLOG
	printf("num_bits=%d tms=%d, send=%p, recv=%p\n", num_bits, tms_at_end, send, recv);
#endif

	while (num_bits>64*8) {
		int bytes = usb_control_msg(libusb_handle, 0x40, 'J', 0 /*wValue=send_tms=0*/, 64*8, send, 64, 500);
		if (bytes != 64) {
			printf("Wrote %d bytes, expecting %d\n", bytes, 64);
			exit(5);
		}
#ifdef BIGLOG
		int q;
		printf("Sent:");
		for (q=0;q<64;q++)
			printf(" %02x",send[q] & 255);
		printf("\n");
#endif
		unsigned char* recv = recv_real ? recv_real : recv_tmp;

		if (recv) {
			bytes = usb_control_msg(libusb_handle, 0xc0, 'O', 0, 64*8, recv, 64, 500);
			if (bytes != 64) {
				printf("Read %d bytes, expecting %d\n", bytes, 64);
				exit(5);
			}
#ifdef BIGLOG
			printf("Recd:");
			for (q=0;q<64;q++)
				printf(" %02x",recv[q] & 255);
			printf("\n");
#endif
		}

#ifdef DUMP_ALL_JTAG_TRAFFIC
		TrafficDumpBits(0, 64*8, send, recv);
#endif

		send += 64;
		if (recv_real)
			recv_real += 64;
		num_bits -= 64*8;
	}
	int obytes = (num_bits+7) >> 3;
//	printf("Writing %d bytes\n", obytes);
	int bytes = usb_control_msg(libusb_handle, 0x40, 'J', tms_at_end?1:0 /*wValue=send_tms*/, num_bits, send, obytes, 500);
//	printf("Wrote %d bytes, expecting %d\n", bytes, obytes);
#ifdef BIGLOG
	int q;
	printf("Sent:");
	for (q=0;q<obytes;q++)
		printf(" %02x",send[q] & 255);
	printf("\n");
#endif
	if (bytes != obytes) {
		printf("Wrote %d bytes, expecting %d\n", bytes, obytes);
		exit(5);
	}

#ifdef DO_LOG
	printf("[%3d]", num_bits);
	int i;
	for (i=0; i<bytes; i++)
		printf(" %02X", send[i]);
	if(tms_at_end)
		printf(" TMS");
#endif
	unsigned char* recv = recv_real ? recv_real : recv_tmp;

	if (recv) {
		bytes = usb_control_msg(libusb_handle, 0xc0, 'O', 0, num_bits, recv, obytes, 500);
//		printf("Read %d bytes, expecting %d\n", bytes, obytes);
		if (bytes != obytes) {
			printf("Read %d bytes, expecting %d\n", bytes, obytes);
			exit(5);
		}
#ifdef BIGLOG
		printf("Recd:");
		for (q=0;q<obytes;q++)
			printf(" %02x",recv[q] & 255);
		printf("\n");
#endif
#ifdef DO_LOG
		printf(" -");
		int i;
		for (i=0; i<bytes; i++)
			printf(" %02X", recv[i]);
#endif
	}

#ifdef DUMP_ALL_JTAG_TRAFFIC
	TrafficDumpBits(tms_at_end, num_bits, send, recv);
#endif

#ifdef DO_LOG
	printf("\n");
#endif
}


#endif //USB_SPEEDUP

///////////////////////////////////////////////////////////////////////////

#ifdef USB_SPEEDUP

unsigned char collect[64];
int collect_count=0;

void jtagSendAndReceiveBits(int tms_at_end, int num_bits, unsigned char* send, unsigned char* recv)
{
	if (collect_count) {
//		printf("\tpurging %d collected bits\n", collect_count);
		jtagSendAndReceiveBitsRaw(0, collect_count, collect, NULL);
		collect_count=0;
	}

	return jtagSendAndReceiveBitsRaw(tms_at_end, num_bits, send, recv);
}

int jtagLowlevelClock(int tdi, int tms)
{
	if (collect_count) {
//		printf("\tpurging %d collected bits\n", collect_count);
		jtagSendAndReceiveBitsRaw(0, collect_count, collect, NULL);
		collect_count=0;
	}

//	printf("jtagLowlevelClock(tdi=%d,tms=%d)\n", tdi, tms);

	char byte = tdi ? 1 : 0;
	jtagSendAndReceiveBitsRaw(tms, 1, &byte, &byte);
	return byte&1;
}

void jtagLowlevelClockRO(int tdi, int tms)
{
//	printf("jtagLowlevelClockRO(tdi=%d,tms=%d)\n", tdi, tms);

	int collect_idx=collect_count>>3;
	if (collect_count&7) {
		if (tdi)
			collect[collect_idx] |= 1<<(collect_count&7);
	} else {
		collect[collect_idx] = tdi ? 1 : 0;
	}
	collect_count++;
	if (collect_count == 64*8 || tms)
	{
//		printf("\tpurging %d collected bits\n", collect_count);
		jtagSendAndReceiveBitsRaw(tms, collect_count, collect, NULL);
		collect_count=0;
	}
}
#else
int jtagLowlevelClock(int tdi, int tms)
{
	printf("ERROR - OBSOLETE jtagLowlevelClock call\n");
	exit(0);

	char byte=(tdi?1:0) | (tms?0x80:0);
	char tdo;
	int bytes = usb_control_msg(libusb_handle, 0xc0, 'j', byte, 0, &tdo, 1, 500);
	if (bytes != 1) {
		printf("Read %d bytes, tdo=%d\n", bytes, tdo);
		exit(5);
	}
	return tdo?1:0;
}

void jtagLowlevelClockRO(int tdi, int tms)
{
	jtagLowlevelClock(tdi,tms);
}
#endif // USB_SPEEDUP

///////////////////////////////////////////////////////////////////////////

void jtagRunTestTCK( unsigned int len )
{
	jtagIdle();

//	printf("TCK %d", len);

	len = len/2+1;

	while (len>0) {

//		jtagLowlevelClockRO(0,0);
//		len--;

/**/

		int num = len>500 ? 500 : len;
//		printf(".");
		int bytes = usb_control_msg(libusb_handle, 0x40, 'Z', (num/10)+1, 0, "", 0, 500);
		if (bytes != 0) {
			printf("TCK: Wrote %d bytes, expecting %d\n", bytes, 0);
//			usleep(1000000);
//			exit(5);
		}
		len -= num;

/**/

	}
//	printf("\n");
}
