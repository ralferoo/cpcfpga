#include "gpio.h"

void promValidate(struct Device* prom)
{
	// idcode
	jtagSendIR(0xfe, prom);
	uint32_t idcode = jtagSendDR(0, 32, prom);
	if (idcode!=PROM_XCF02S) {
		printf("IDCODE from PROM isn't for XCF02S: %08x\n", idcode);
		exit(1);
	}

	// ISC_DISABLE conld
	jtagSendIR(0xf0, prom);
	jtagRunTestTCK(110000);

	int protect = (int) jtagSendIR(0xff, prom);
	if ( (protect&7) != 1 ) {
		printf("IR status register not as expected: %02x\n", protect);
		exit(1);
	}
	//printf("IR status register: %02x\n", protect);
}

void promDumpBlock( int faddr, struct Device *device)
{
	int i, j, bit;

        // ISC_ADDRESS_SHIFT faddr instruction
        jtagSendIR(0xeb, device);
        jtagSendDR(faddr, 16, device);
        jtagRunTestTCK(2);

        // ISC_READ fvfy0 instruction
        jtagSendIR(0xef, device);
        jtagRunTestTCK(1);
        jtagRunTestTCK(50);

        // read the data
        jtagShiftDR();
        for (i=0; i<device->hdr; i++)
                jtagOutputSilent(0,0);              // ignore all data before the data we want

        uint16_t addr = faddr << 4;
        for (i=0; i<8192; i+=HEX_BLOCK_SIZE*8 ) {
                hexStart( 0, addr, HEX_BLOCK_SIZE );
                for(j=0; j<HEX_BLOCK_SIZE; j++ ) {
                        uint8_t byte = 0;
                        for(bit = 0; bit<8; bit++) {
                                byte >>= 1;
                		if (jtagOutputSilent(0,0) )
                                        byte |= 0x80;
                        }
                        hexByte( byte );
                        addr++;
                }
                hexEndLine();
        }

	jtagUpdateOrIdle();
}

void promDump(struct Device* prom)
{
	promValidate(prom);

        // bypass instruction
        jtagSendIR( 0xff, prom);
        // ISC_ENABLE ispen instruction
        jtagSendIR( 0xe8, prom);
        jtagSendDR( 0x34, 6, prom);
        // ISC_DISABLE conld instruction
        jtagSendIR( 0xf0, prom);
        jtagRunTestTCK(110000);
        // ISC_ENABLE ispen instruction
        jtagSendIR( 0xe8, prom);
        jtagSendDR( 0x34, 6, prom);

        uint16_t faddr, faddr_base = (uint16_t) ~0U;
        for( faddr=0x0000; faddr<0x4000; faddr+=0x40 ) {
		if (faddr)
			printf("\n");
                printf( "# faddr=%04X\n", faddr );
                if ( (faddr & 0xf000) != faddr_base ) {
                        faddr_base = faddr & 0xf000;
                        hexAddrHigh( faddr >> 12 );
                }
                promDumpBlock(faddr, prom);
        }
        hexEndOfFile();

	// ISC_DISABLE conld
	jtagSendIR(0xf0, prom);
	jtagRunTestTCK(110000);
}
