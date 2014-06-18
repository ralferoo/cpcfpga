// #define DUMP_ALL_JTAG_TRAFFIC

#include <time.h>
#include <errno.h>

#include "sidecar.h"

#include <stdio.h>
#include <libusb.h>

//#define DO_LOG

//#define BIGLOG

#ifdef DUMP_ALL_JTAG_TRAFFIC
int dumper_fd = -1;
unsigned char dumper_buffer[10000];
int dumper_bufptr = 0;
#endif

int serialMode = 0;
void jtagSendAndReceiveBitsRaw(int tms_at_end, int num_bits, unsigned char* send, unsigned char* recv_real);

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
			if ((*recv) & mask) out |= 2;			//    2=TDO (from JTAG to us) 
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

static libusb_device_handle *libusb_handle = NULL;

libusb_device_handle *find_cpc2013(libusb_device **devs);

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

libusb_device_handle *find_cpc2013(libusb_device **devs)
{
	libusb_device *dev;

	while ((dev = *devs++) != NULL) {
		struct libusb_device_descriptor desc;
		int r = libusb_get_device_descriptor(dev, &desc);
		if (r >= 0) {
/*
			printf("%04x:%04x (bus %d, device %d)\n",
				desc.idVendor, desc.idProduct,
				libusb_get_bus_number(dev), libusb_get_device_address(dev));
*/
			if (desc.idVendor == 0x1d50 && (desc.idProduct == 0x6063 || desc.idProduct == 0x6065)) {
				printf("Found CPC2013 device %04x:%04x rev %04x (manuf #%02x product #%02x serial #%02x)\n",
					desc.idVendor, desc.idProduct,
					desc.bcdDevice,
					desc.iManufacturer, desc.iProduct,
					desc.iSerialNumber );

				libusb_device_handle *device_handle;
				int r = libusb_open(dev, &device_handle);
				if (r<0) continue;

				char nbuffer[65];
				int len,i;
				char *strname="";

				for(i=0;i<4; i++) {
					int descid;
					switch (i) {
						default:
							descid=desc.iManufacturer;
							strname="manufacturer";
							break;
						case 1:
							descid=desc.iProduct;
							strname="product";
							break;
						case 2:
							descid=desc.iSerialNumber;
							strname="serial no";
							break;
						case 3:
							descid='v';
							strname="version";
							break;
					}
					len = libusb_get_string_descriptor_ascii(device_handle, descid, nbuffer, sizeof(nbuffer) );
					if (len>=0) {
						printf("#%02x %-12s %s (len %d)\n", descid, strname, nbuffer, len );
					}
				}

				return device_handle;
			}
		}
	}
	return NULL;
}

///////////////////////////////////////////////////////////////////////////

libusb_device_handle *find_dfu(libusb_device **devs)
{
	libusb_device *dev;

	while ((dev = *devs++) != NULL) {
		struct libusb_device_descriptor desc;
		int r = libusb_get_device_descriptor(dev, &desc);
		if (r >= 0) {
			if (desc.idVendor == 0x3eb && desc.idProduct == 0x2ff0) {
				printf("Found possible CPC2013 DFU device %04x:%04x, manuf #%02x product #%02x serial #%02x\n",
					desc.idVendor, desc.idProduct,
					desc.iManufacturer, desc.iProduct,
					desc.iSerialNumber );

				libusb_device_handle *device_handle;
				int r = libusb_open(dev, &device_handle);
				if (r<0) continue;

				return device_handle;
			}
		}
	}
	return NULL;
}

///////////////////////////////////////////////////////////////////////////

void jtagLog(void)
{
	libusb_device **devs;
	int r;
	ssize_t cnt;

	r = libusb_init(NULL);
	if (r < 0) {
		printf("Can't open libusb, error: %d\n", r);
		exit(10);
	}

	cnt = libusb_get_device_list(NULL, &devs);
	if (cnt > 0) {
		libusb_handle = find_cpc2013(devs);
		libusb_free_device_list(devs, 1);
	}

	if (libusb_handle == NULL) {
		printf("No cpc2013 device found, aborting...\n");
		jtagExit();
		exit(10);
	}

	if (libusb_claim_interface(libusb_handle, 1)==0) {
		char buffer[512];
		for (;;) {
			int res,xfer=0;
			res = libusb_bulk_transfer(libusb_handle, 0x82, buffer, sizeof(buffer)-1, &xfer, 1000);
			if (res ==0 && xfer>=0) {
				buffer[xfer]=0;
			//	printf("%d:%d:%s\n",res,xfer,buffer);
				printf("%s",buffer);
			} else if (res != LIBUSB_ERROR_TIMEOUT) {
				printf("[ERROR res %d xfer %d]\n",res,xfer);
			}
			if (res == LIBUSB_ERROR_PIPE)
				libusb_clear_halt(libusb_handle, 0x82);
			if (res == LIBUSB_ERROR_NO_DEVICE)
				break;
			fflush(stdout);
		}
		libusb_release_interface(libusb_handle, 1);
	} else {
		printf("Can't claim LOG interface...\n");
	}

	libusb_close(libusb_handle);
	libusb_handle = NULL;
	libusb_exit(NULL);
}

void jtagInit(void)
{
	libusb_device **devs;
	int r;
	ssize_t cnt;

	r = libusb_init(NULL);
	if (r < 0) {
		printf("Can't open libusb, error: %d\n", r);
		exit(10);
	}

	cnt = libusb_get_device_list(NULL, &devs);
	if (cnt > 0) {
		libusb_handle = find_cpc2013(devs);
		libusb_free_device_list(devs, 1);
	}

	if (libusb_handle == NULL) {
		printf("No cpc2013 device found, aborting...\n");
		jtagExit();
		exit(10);
	}

	if (libusb_claim_interface(libusb_handle, 0) != 0) {
		printf("Can't claim JTAG interface...\n");
		libusb_close(libusb_handle);
		libusb_handle = NULL;
		jtagExit();
		exit(10);
	}

	char nbuffer[1];
	int len = libusb_control_transfer(libusb_handle, 0xc0, 'R', 0, 0, nbuffer, 1, 500);
	if (len<0)
		printf("Couldn't send CPC2013 reset\n");
}

void jtagExit(void)
{
	if (libusb_handle) {
		libusb_release_interface(libusb_handle, 0);
		libusb_close(libusb_handle);
		libusb_handle = NULL;
	}
	libusb_exit(NULL);
}

unsigned char collect[64];
int collect_count=0;

void jtagFlush()
{
	if (collect_count) {
		jtagSendAndReceiveBitsRaw(0, collect_count, collect, NULL);
		collect_count=0;
	}
}

void jtagSendAndReceiveBits(int tms_at_end, int num_bits, unsigned char* send, unsigned char* recv)
{
	if (collect_count) {
//		printf("\tpurging %d collected bits\n", collect_count);
		jtagSendAndReceiveBitsRaw(0, collect_count, collect, NULL);
		collect_count=0;
	}

	jtagSendAndReceiveBitsRaw(tms_at_end, num_bits, send, recv);
	jtagChangeState(tms_at_end);
}

int jtagLowlevelClock(int tdi, int tms)
{
	if (collect_count) {
#ifdef NEWLOG
		printf("\tpurging %d collected bits\n", collect_count);
#endif
		jtagSendAndReceiveBitsRaw(0, collect_count, collect, NULL);
		collect_count=0;
	}

#ifdef NEWLOG
	printf("jtagLowlevelClock(tdi=%d,tms=%d)\n", tdi, tms);
#endif

	char byte = tdi ? 1 : 0;
	jtagSendAndReceiveBitsRaw(tms, 1, &byte, &byte);
	return byte&1;
}

void jtagLowlevelClockRO(int tdi, int tms)
{
#ifdef NEWLOG
	printf("jtagLowlevelClockRO(tdi=%d,tms=%d)\n", tdi, tms);
#endif

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
#ifdef NEWLOG
		printf("\tpurging %d collected bits\n", collect_count);
#endif
		jtagSendAndReceiveBitsRaw(tms, collect_count, collect, NULL);
		collect_count=0;
	}
}

///////////////////////////////////////////////////////////////////////////

void jtagRunTestTCK( unsigned int len )
{
	jtagIdle();

	uint8_t header[3];
	int res, xfer=-1;

	header[0] = 'Z';
	header[1] = (uint8_t)(len>>8);
	header[2] = (uint8_t)len;

	res = libusb_bulk_transfer(libusb_handle, 4, header, 3, &xfer, 1500);
	if (res<0 || xfer !=3) {
		printf("Error %d sending RunTCK header len %d\n", res, xfer);
		jtagExit();
		exit(1);
	}
}

void promBoot(int jtag)
{
	int res, xfer=-1;
	res = libusb_bulk_transfer(libusb_handle, 4, jtag?"p":"P", 1, &xfer, 1500);
	if (res<0 || xfer !=1) {
		printf("promBoot: error %d wrote %d bytes, expecting %d\n", res, xfer, 1);
	}
}

///////////////////////////////////////////////////////////////////////////

int atmegaRebootInternal( char type );

int atmegaBootloader( void )
{
	atmegaRebootInternal('B');
}

int atmegaReboot( void )
{
	atmegaRebootInternal('b');
}

int atmegaRebootInternal( char type )
{
	int bytes = usbControlMessage(0x40, type, 0, 0, "", 0, 500);

	libusb_device **devs;
	int r;
	ssize_t cnt;

	int i;
	for (i=0; i<10; i++)
	{
		jtagExit();

		r = libusb_init(NULL);
		if (r < 0) {
			printf("Can't open libusb, error: %d\n", r);
			exit(10);
		}
	
		cnt = libusb_get_device_list(NULL, &devs);
		if (cnt > 0) {
			libusb_device_handle *dfu_handle = find_dfu(devs);
			libusb_free_device_list(devs, 1);

			if (dfu_handle) {
				printf("Found DFU\n");
				libusb_close(dfu_handle);
				return 1;
			}
		}
#ifdef _MSC_VER
//		Sleep(500);
#else
		usleep(500000);
#endif
		putchar('.'); 
//		write(1, ".", 1);
	}
	putchar('\n');
//	write(1, "\n", 1);
//	jtagExit();
	return 0;
}

///////////////////////////////////////////////////////////////////////////

int usbControlMessage( int requesttype, int request, int value, int index, char *bytes, int size, int timeout)
{
	int res, retry;

	for(retry=0;retry<10;retry++) {
#ifdef _MSC_VER
//		Sleep(1);
#else
		usleep(30);
#endif
/*
		if( request =='Z' )
			printf("Z");
		else if (request=='J' && requesttype==0x40)
			printf("J> %c %d/%d\n", value?'T':' ', index, size);
		else if (request=='O' && requesttype==0xc0)
			printf("O< %c %d/%d\n", value?'T':' ', index, size);
		else
			printf("rt=%02x, rq=%02x, val=%04x, idx=%04x, size=%d\n", requesttype, request, value, index, size );
*/
		res = libusb_control_transfer(libusb_handle, requesttype, request, value, index, bytes, size, timeout);

		if (res != -110)
			break;

#ifdef _MSC_VER
//		Sleep(1000);
#else
		sleep(1);
#endif
		printf(retry?".":"USB timeout, retrying...");
	}
	if (retry)
		printf("\n");
	return res;
}

///////////////////////////////////////////////////////////////////////////

int getAtmegaRAM(unsigned char *ram)
{
	uint8_t header[1];
	int res, xfer=-1;

	header[0] = 'R';
	res = libusb_bulk_transfer(libusb_handle, 4, header, 1, &xfer, 1500);
	if (res<0 || xfer != 1) {
		printf("Error %d sending DumpRAM header xfer %d\n", res, xfer);
		return 0;
	}

	res = libusb_bulk_transfer(libusb_handle, 0x83, ram, 1024, &xfer, 1500);
	if (res<0 || xfer != 1) {
		printf("Error %d fetching DumpRAM data xfer %d\n", res, xfer);
	}
	return xfer;
}

///////////////////////////////////////////////////////////////////////////

static void LIBUSB_CALL simple_transfer_cb(struct libusb_transfer *transfer)
{
	int *completed = transfer->user_data;
	*completed = 1;
	/* caller interprets result and frees transfer */
}

void jtagSendAndReceiveBitsRaw(int tms_at_end, int num_bits, unsigned char* send, unsigned char* recv_real)
{
	int buflen = (num_bits + 7) >> 3;
	uint8_t header[3];
	header[0] = recv_real ? (tms_at_end ? 'J' : 'j') : (tms_at_end ? 'S' : 's');
	header[1] = (uint8_t)(num_bits >> 8);
	header[2] = (uint8_t)num_bits;

#if 0
	printf("num_bits=%d tms=%d, send=%p, recv=%p hdr=%02x:%02x:%02x\n",
		num_bits, tms_at_end, send, recv_real,
		header[0], header[1], header[2]);
#endif

	if (!recv_real)
	{
		int xfer_head = 0, xfer_send = 0;
		int res = libusb_bulk_transfer(libusb_handle, 4, header, 3, &xfer_head, 1500);
		if (res < 0 || xfer_head != 3)
		{
			printf("Can't send header: code %d, xfer %d\n", res, xfer_head);
			jtagExit();
			exit(1);
		}
		res = libusb_bulk_transfer(libusb_handle, 4, send, buflen, &xfer_send, 1500);
		if (res < 0 || xfer_send != buflen)
		{
			printf("Can't send data: code %d, xfer %d\n", res, xfer_send);
			jtagExit();
			exit(1);
		}
		return;
	}

	char* read_buffer = malloc(buflen);
	if (!read_buffer)
	{
		printf("Can't allocate read_buffer in jtagSendAndReceiveBitsRawAsync\n");
		jtagExit();
		exit(1);
	}

//	struct libusb_transfer *head_transfer = libusb_alloc_transfer(0);
	struct libusb_transfer *read_transfer = libusb_alloc_transfer(0);
//	struct libusb_transfer *send_transfer = libusb_alloc_transfer(0);

	if (/*!head_transfer ||*/ !read_transfer /*|| !send_transfer*/)
	{
		printf("Can't allocate transfers in jtagSendAndReceiveBitsRawAsync\n");
		jtagExit();
		free(read_buffer);
		exit(1);
	}

	int xfer_read = 0;
	int xfer_completed = 0;
	libusb_fill_bulk_transfer(read_transfer, libusb_handle, 0x83, read_buffer, buflen, simple_transfer_cb, &xfer_completed, 3500);
	read_transfer->type = LIBUSB_TRANSFER_TYPE_BULK;
	
//	int xfer_head = 0, xfer_read = 0, xfer_send = 0;
//	libusb_fill_bulk_transfer(head_transfer, libusb_handle,    4, header,      3,      sync_transfer_cb, &xfer_head, 1500);
//	libusb_fill_bulk_transfer(send_transfer, libusb_handle,    4, send,        buflen, sync_transfer_cb, &xfer_send, 1500);
//	head_transfer->type = LIBUSB_TRANSFER_TYPE_BULK;
//	send_transfer->type = LIBUSB_TRANSFER_TYPE_BULK;

	int r = libusb_submit_transfer(read_transfer);
	if (r < 0) {
		libusb_free_transfer(read_transfer);
		printf("Error in libusb_submit_transfer starting read\n");
		jtagExit();
		free(read_buffer);
		exit(1);
	}

	int xfer_head = 0, xfer_send = 0;
	int res = libusb_bulk_transfer(libusb_handle, 4, header, 3, &xfer_head, 1500);
	if (res >= 0 && xfer_head == 3)
	{
		res = libusb_bulk_transfer(libusb_handle, 4, send, buflen, &xfer_send, 1500);
	}

	// sync_transfer_wait_for_completion(transfer);
	struct libusb_context *ctx = NULL; // HANDLE_CTX(libusb_handle);
	while (!xfer_completed) {
		r = libusb_handle_events_completed(ctx, &xfer_completed);
		if (r < 0) {
			if (r == LIBUSB_ERROR_INTERRUPTED)
				continue;
			//usbi_err(ctx, "libusb_handle_events failed: %s, cancelling transfer and retrying", libusb_error_name(r));
			libusb_cancel_transfer(read_transfer);
			continue;
		}
	}

	xfer_read = read_transfer->actual_length;
	switch (read_transfer->status) {
	case LIBUSB_TRANSFER_COMPLETED:
		r = 0;
		break;
	case LIBUSB_TRANSFER_TIMED_OUT:
		r = LIBUSB_ERROR_TIMEOUT;
		break;
	case LIBUSB_TRANSFER_STALL:
		r = LIBUSB_ERROR_PIPE;
		break;
	case LIBUSB_TRANSFER_OVERFLOW:
		r = LIBUSB_ERROR_OVERFLOW;
		break;
	case LIBUSB_TRANSFER_NO_DEVICE:
		r = LIBUSB_ERROR_NO_DEVICE;
		break;
	case LIBUSB_TRANSFER_ERROR:
	case LIBUSB_TRANSFER_CANCELLED:
		r = LIBUSB_ERROR_IO;
		break;
	default:
		r = LIBUSB_ERROR_OTHER;
	}

	libusb_free_transfer(read_transfer);

	if (r < 0)
	{
		printf("Error in read transfer: code %d, xfer %d\n", r, xfer_read);
		jtagExit();
		free(read_buffer);
		exit(1);
	}
	
	if (res >= 0 && xfer_head == 3 && xfer_send == buflen && xfer_read == buflen)
	{
		if (recv_real)
		{
			memcpy(recv_real, read_buffer, buflen);
		}
		free(read_buffer);
	}
	else
	{
		printf("Error in read transfer: code %d, xfer %d\n", r, xfer_read);
		jtagExit();
		free(read_buffer);
		exit(1);
	}
}

int jtagGetState(bool log)
{
	uint8_t header[1];
	header[0] = '?';

	int xfer_head = 0, xfer_recv = 0;
	int res = libusb_bulk_transfer(libusb_handle, 4, header, 1, &xfer_head, 1500);

	if (res < 0 || xfer_head != 1)
	{
		printf("Can't send header: code %d, xfer %d\n", res, xfer_head);
		jtagExit();
		exit(1);
	}

	char buffer[100];
	res = libusb_bulk_transfer(libusb_handle, 0x83, buffer, sizeof(buffer), &xfer_recv, 1500);
	if (res < 0 || xfer_recv < 3 || buffer[0] != '!')
	{
		printf("Can't receive data: code %d, xfer %d valid %02x\n", res, xfer_recv, buffer[0]);
		jtagExit();
		exit(1);
	}

	if (log) {
		buffer[xfer_recv]=0;
		printf("JTAG state 0x%x (%s)\n", buffer[1], buffer+2);
	}
	return buffer[0];
}
