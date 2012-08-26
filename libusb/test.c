#include <stdio.h>
#include <usb.h>

usb_dev_handle *find_cpc2012(void);

int main(int argc,char **argv[])
{
	usb_init();
//	usb_set_debug(2);
	usb_find_busses();
	usb_find_devices();

	usb_dev_handle *handle = find_cpc2012();
	if (handle) {

		int bytes = usb_control_msg(handle, 0x40, 0xac, 0x1234, 0x5678, "", 0, 500);
		printf("Wrote %d bytes\n", bytes);

		short count;
		bytes = usb_control_msg(handle, 0xc0, 0xac, 0x1234, 0x5678, (char*) &count, 2, 500);
		printf("Read %d bytes, count=%d\n", bytes, count);

		char tdo;
		bytes = usb_control_msg(handle, 0xc0, 'j', 0x80, 0, &tdo, 1, 500);
		printf("Read %d bytes, tdo=%d\n", bytes, tdo);

		usb_close(handle);
	}
}

usb_dev_handle *find_cpc2012(void)
{
        struct usb_bus *bus;
        struct usb_device *dev;
        usb_dev_handle *device_handle = 0;

	for (bus=usb_busses; bus; bus=bus->next) {
		for (dev=bus->devices; dev; dev=dev->next) {
//			printf("found %04x:%04x\n", dev->descriptor.idVendor, dev->descriptor.idProduct);
			if (dev->descriptor.idVendor == 0x16c0 && dev->descriptor.idProduct == 0x05e1) {
				printf("Found possible CPC2012 device %04x:%04x, manuf #%02x product #%02x serial #%02x\n",
					dev->descriptor.idVendor, dev->descriptor.idProduct,
					dev->descriptor.iManufacturer, dev->descriptor.iProduct,
					dev->descriptor.iSerialNumber );

				device_handle = usb_open(dev);

				char nbuffer[65];
				int len,i;

				for(i=0;i<3; i++) {
					int desc;
					switch (i) {
						default:
							desc=dev->descriptor.iManufacturer;
							break;
						case 1:
							desc=dev->descriptor.iProduct;
							break;
						case 2:
							desc=dev->descriptor.iSerialNumber;
							break;
					}
					len = usb_get_string_simple(device_handle, desc, nbuffer, sizeof(nbuffer) );
					if (len>=0) {
						printf("#%02x %s (len %d)\n", desc, nbuffer, len );
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

				return device_handle;
			}
		}
	}
}

