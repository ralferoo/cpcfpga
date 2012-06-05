#include "gpio.h"

extern int g_noisy;

void pintest(void)
{
	struct Device *fpga = devFindDevice(FPGA_XC3S400);
	struct Device *prom = devFindDevice(PROM_XCF02S);

	if (fpga==0 || prom==0) {
		printf("Can't find suitable PROM and FPGA.\n");
		exit(1);
	}

	struct Device *first, *second;
	if (fpga->hir < prom->hir) {
		first = fpga; second = prom;
	} else {
		first = prom; second = fpga;
	}

	int mir = second->hir - first->hir - first->len;
	int mdr = second->hdr - first->hdr - 1;

	printf("BSR chain is: pre(%d/%d) %s(%d/%d) mid(%d/%d) %s(%d/%d) end(%d/%d)\n",
				first->hir, first->hdr,
		first->name,	first->len, first->bsrlen,
				mir, mdr,
		second->name,	second->len, second->bsrlen,
				second->tir, second->tdr);

}

int main(int argc, char **argv)
{
	jtagInit();
	devScanDevices();
	devDump();
	printf("\n");
	pintest();

/*
//	g_noisy = 1;

#ifdef REPEAT
	printf("%c[2J",27);
	for(;;) {
	printf("%c[1;1f",27);
#endif
		struct Device *device = devGetFirstDevice();
		while (device) {
			jtagBoundaryScanDump(device);
			device = device->next;
			if (device)
				printf("\n");
		}
#ifdef REPEAT
	}
#endif
*/
	exit(0);
}
