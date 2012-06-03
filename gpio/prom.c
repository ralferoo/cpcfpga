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

void promReload(struct Device* prom)
{
	promValidate(prom);

	jtagSendIR(0xee, prom);
	jtagRunTestTCK(100);
	jtagRunTestTCK(100000);
	jtagReset();

//	jtagSendIR(0xf0, prom);
//	jtagRunTestTCK(110000);
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
                jtagOutput(0,0);              // ignore all data before the data we want

        uint16_t addr = faddr << 4;
        for (i=0; i<8192; i+=HEX_BLOCK_SIZE*8 ) {
                hexStart( 0, addr, HEX_BLOCK_SIZE );
                for(j=0; j<HEX_BLOCK_SIZE; j++ ) {
                        uint8_t byte = 0;
                        for(bit = 0; bit<8; bit++) {
                                byte >>= 1;
                		if (jtagOutput(0,0) )
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
//		if (faddr)
//			printf("\n");
//		printf( "# faddr=%04X\n", faddr );
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

void promErase(struct Device* prom)
{
	promValidate(prom);

        // bypass instruction
        jtagSendIR( 0xff, prom);
        // ISC_ENABLE ispen instruction
        jtagSendIR( 0xe8, prom);
        jtagSendDR( 0x34, 6, prom);

        // ISC_ADDRESS_SHIFT faddr instruction
        jtagSendIR( 0xeb, prom);
        jtagSendDR( 1, 16, prom);
        jtagRunTestTCK(2);

        // ISC_ERASE ferase instruction
        jtagSendIR( 0xec, prom);

	printf("Waiting for erase to complete...  ");

	int i;
	for(i=0; i<128; i++) {
		printf("\b%c", "|/-\\"[i&3]);
		fflush(stdout);
		jtagRunTestTCK(15000000/128);
	}
	printf("\n");

        // ISC_DISABLE conld instruction
        jtagSendIR( 0xf0, prom);
        jtagRunTestTCK(110000);
}

static struct Device* promProgramCurrent = 0;
static int prom_in_block;
static uint16_t prom_addr_hi, prom_addr_lo, prom_addr_lo_start;
static uint8_t zerobyte=0;

void promProgramStart(struct Device *prom)
{
	promValidate(prom);

        // bypass instruction
        jtagSendIR( 0xff, prom);

        // ISC_DISABLE conld instruction
        jtagSendIR( 0xf0, prom);
        jtagRunTestTCK(110000);

        // ISC_ENABLE ispen instruction
        jtagSendIR( 0xe8, prom);
        jtagSendDR( 0x34, 6, prom);

	prom_in_block = 0;
	prom_addr_hi = 0;
	promProgramCurrent = prom;

	printf("Programming PROM chip...  ");
}

int promProgramData(uint8_t type, uint8_t len, uint16_t addr, uint8_t *data)
{
	if (!promProgramCurrent)
		return -2;

	int i;
        if (data) {
                // valid data block
                switch( type ) {
                        case 1: // end of file
                                if (prom_in_block) {
                                        uint16_t padding = (-prom_addr_lo)&511;
					printf("\nPadding end of last block with %d bytes\n", padding);
                                        while( padding-- ) {
						int i=promProgramData(0,1,prom_addr_lo,&zerobyte);
						if (i) return i;
					}
                                }
				prom_in_block = 0;

                                // ISC_ADDRESS_SHIFT faddr instruction
                                jtagSendIR( 0xeb, promProgramCurrent);
                                jtagSendDR( 1, 16, promProgramCurrent);
                                jtagIdle();
                                jtagRunTestTCK(1);
                                                
                                // ISC_SERASE instruction
                                jtagSendIR( 0x0a, promProgramCurrent);
                                jtagIdle();
                                jtagRunTestTCK(37000);
                                                
                                // ISC_DISABLE conld instruction
                                jtagSendIR( 0xf0, promProgramCurrent);
                                jtagRunTestTCK(110000);
				printf("\nFinished programming PROM\n");

				promProgramCurrent = 0;
				return 1;

                        case 4: // address high
                                if (prom_in_block) {
                                        printf("\nHEX high address word changed mid sector\n");
					return -1;
				}
                                prom_addr_hi = (data[0]<<8) | data[1];
                                break;
                                
                        default:
                                printf("\nInvalid HEX type %02X\n", type);
				return -1;
                                break;

                        case 0: // data
                                if (!prom_in_block) {
                                        if( addr&511 ) {
                                                printf("\n# HEX starts mid sector\n");
						return -1;
                                        }
                                        prom_addr_lo=addr;
                                        prom_addr_lo_start=addr;
next_sector:
                                        // ISC_DATA_SHIFT fdata0 instruction
                                        jtagSendIR( 0xed, promProgramCurrent);
                                        jtagShiftDR();
                                        for (i=0; i<promProgramCurrent->hdr; i++)
                                                jtagOutput(0,0);              // ignore all data before the data we want
                                        prom_in_block = 1;
                                } else if (addr != prom_addr_lo) {
                                        printf("\nHEX changes sector mid sector\n");
                                        return -1;
                                }
                                while( len-- ) {
                                        uint8_t b = *data++;
                                        for(i=0; i<7; i++) {
                                                jtagOutput(b&1,0);
                                                b >>= 1;
                                        }                                       // send 7 bytes
                                        if( (++prom_addr_lo & 511) ) {
                                                jtagOutput(b&1,0);
                                        } else {
                                                if (promProgramCurrent->tdr) {
                                                	jtagOutput(b&1,0);
                                                        for(i=1; i<promProgramCurrent->tdr; i++)
                                                		jtagOutput(0,0);
                                               		jtagOutput(0,1);           // send TMS bit at end of padding
                                                } else
                                               		jtagOutput(b&1,1);         // no padding, add TMS bit on last bit

                                                jtagRunTestTCK(2);

                                                uint16_t prom_faddr = (prom_addr_hi<<12) | (prom_addr_lo_start>>4);
						static int slowdown;
                                                if( (++slowdown&15) == 0 ) { //prom_addr_lo & 4096) {
							static int display;
							printf("\b%c", "|/-\\"[display++&3]);
							fflush(stdout);
						}

                                                // ISC_ADDRESS_SHIFT faddr instruction
                                                jtagSendIR( 0xeb, promProgramCurrent);
                                                jtagSendDR( prom_faddr, 16, promProgramCurrent);
                                                jtagRunTestTCK(2);
                                                
                                                // ISC_PROGRAM fpgm instruction
                                                jtagSendIR( 0xea, promProgramCurrent);
                                                jtagIdle();
                                                jtagRunTestTCK(14000);

                                                prom_in_block = 0;
                                                if (len)
                                                        goto next_sector;
                                        }
                                }
                }
        }

	return 0;
}

