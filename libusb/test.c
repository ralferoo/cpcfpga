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
				printf("Found CPC2012 device %04x:%04x\n", dev->descriptor.idVendor, dev->descriptor.idProduct);
				return usb_open(dev);
			}
		}
	}
}

