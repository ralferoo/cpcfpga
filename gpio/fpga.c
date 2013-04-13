#include "gpio.h"

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
	if (idcode!=FPGA_XC3S400) {
		printf("IDCODE from FPGA isn't for XC3S400: %08x\n", idcode);
		exit(1);
	}

	uint32_t usercode = fpgaUserCode(fpga);
	if (usercode!=FPGA_USERCODE) {
		printf("USECODE from FPGA isn't for CPC FPGA: %08x\n", usercode);
		exit(1);
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

