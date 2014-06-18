#include "sidecar.h"

uint32_t fpgaUserCode(struct Device* fpga)
{
	// idcode
	jtagSendIR(0x08, fpga);
	uint32_t usercode = jtagSendDR(0, 32, fpga);
	jtagIdle();

	return usercode;
}

void fpgaValidate(struct Device* fpga)
{
	jtagSendIR(0x09, fpga);
	uint32_t idcode = jtagSendDR(0, 32, fpga);
	if ((idcode&0xffff000) != (FPGA_XC3S400&0xffff000)) {
		printf("IDCODE from FPGA isn't for XC3S400: %08x\n", idcode);
		jtagExit();
		exit(1);
	}

	uint32_t usercode = fpgaUserCode(fpga);
	if (usercode!=FPGA_USERCODE && usercode!=FPGA_USERCODE2) {
		printf("Warning: USERCODE from FPGA isn't for CPC FPGA: %08x\n", usercode);
//		jtagExit();
//		exit(1);
	}

	jtagReset();
}

void cpcSetCommand(struct Device* fpga, unsigned char command)
{
	// idcode
	jtagSendIR(0x02, fpga);
	jtagSendDR(command, 8, fpga);
	jtagUpdateOrIdle();
}

uint32_t cpcTransferData(struct Device* fpga, uint32_t value)
{
	// idcode
	jtagSendIR(0x03, fpga);
	uint32_t result = jtagSendDR(value, 32, fpga);
	jtagUpdateOrIdle();
	return result;
}

///////////////////////////////////////////////////////////////////////////
// jtag_bus_ctl_3.vhd interface

int fpga_user_last_address = -1;

void fpga_user_set(struct Device *fpga, int addr, int val)
{
	addr |= 0x30000;
	if (addr != fpga_user_last_address) {
		// send address
		jtagSendIR(0x02, fpga);
		jtagSendDR(addr, 18, fpga);
		jtagUpdateOrIdle();
	}

	// get data
//	jtagSendIR(0x02, fpga);
	jtagSendDR(val | 0x10000, 18, fpga);
	jtagUpdateOrIdle();

	fpga_user_last_address = addr+1;
}

int fpga_user_get(struct Device *fpga, int addr)
{
	int val;
	addr |= 0x20000;
	if (addr != fpga_user_last_address) {
		// send address
		jtagSendIR(0x02, fpga);
		jtagSendDR(addr, 18, fpga);
		jtagUpdateOrIdle();
	}

	// get data
//	jtagSendIR(0x02, fpga);
//	jtagSendDR(0x10000, 18, fpga);
	val = jtagSendDR(0x10000, 18, fpga);
	jtagUpdateOrIdle();

	fpga_user_last_address = addr+1;
	return val;
}
