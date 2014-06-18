#include "sidecar.h"

//#define CONSTANT_110000 110000
#define CONSTANT_110000 30000

void promValidate(struct Device* prom)
{
	// idcode
	jtagSendIR(0xfe, prom);
	uint32_t idcode = jtagSendDR(0, 32, prom);
	if ((idcode&0xffff000) != (PROM_XCF02S&0xffff000)) {
		printf("IDCODE from PROM isn't for XCF02S: %08x\n", idcode);
		jtagExit();
		exit(1);
	}

	// ISC_DISABLE conld
	jtagSendIR(0xf0, prom);
	jtagRunTestTCK(CONSTANT_110000);

	int protect = (int) jtagSendIR(0xff, prom);

	jtagIdle();
	jtagReset();

	if ( (protect&7) != 1 ) {
		printf("IR status register not as expected: %02x\n", protect);
		jtagExit();
		exit(1);
	}
	//printf("IR status register: %02x\n", protect);
}

void promReload(struct Device* prom)
{
	promValidate(prom);

	jtagSendIR(0xee, prom);
	jtagRunTestTCK(100);
//	jtagRunTestTCK(100000);
//	jtagReset();

//	jtagSendIR(0xf0, prom);
//	jtagRunTestTCK(CONSTANT_110000);

	jtagIdle();
	jtagReset();

}

void promDumpBlock( int faddr, struct Device *device)
{
	int i, j;

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
#define PROM_DUMP_BLOCK_SIZE 1024
#ifdef USB_SPEEDUP
		unsigned char bytes[PROM_DUMP_BLOCK_SIZE];
	if( device->hdr ) {
		memset(bytes, 0, (device->hdr+7)>>3 );
		jtagSendAndReceiveBits(0, device->hdr, bytes, NULL);
	}
#else
        for (i=0; i<device->hdr; i++)
                jtagOutput(0,0);              // ignore all data before the data we want
#endif

        uint16_t addr = faddr << 4;
#ifdef USB_SPEEDUP
		for (i = 0; i<8192; i += PROM_DUMP_BLOCK_SIZE * 8) {
			memset(bytes, 0, PROM_DUMP_BLOCK_SIZE);
			jtagSendAndReceiveBits(0, PROM_DUMP_BLOCK_SIZE * 8, bytes, bytes);
		int k,jj;
		for (k = jj = 0; k<PROM_DUMP_BLOCK_SIZE * 8; k += HEX_BLOCK_SIZE * 8) {
                	hexStart( 0, addr, HEX_BLOCK_SIZE );
	                for(j=0; j<HEX_BLOCK_SIZE; j++,jj++ ) {
        	                hexByte( bytes[jj] );
			}
                        addr+=HEX_BLOCK_SIZE;
	                hexEndLine();
		}
        }
#else
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
#endif

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
        jtagRunTestTCK(CONSTANT_110000);
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
	jtagRunTestTCK(CONSTANT_110000);

        // bypass instruction
        jtagSendIR( 0xff, prom);
	jtagRunTestTCK(CONSTANT_110000);

	jtagIdle();
	jtagReset();

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
	for(i=0; i<25; i++) {
//		int bit;
//		bit = jtagOutput(0,0);
//		printf("\b%d%c", bit, "|/-\\"[i&3]);
		printf("\b%c", "|/-\\"[i&3]);
		fflush(stdout);
		jtagRunTestTCK(1500000/25);
	}
	printf("\n");

        // ISC_DISABLE conld instruction
        jtagSendIR( 0xf0, prom);
        jtagRunTestTCK(CONSTANT_110000);

        // bypass instruction
        jtagSendIR( 0xff, prom);
	jtagRunTestTCK(CONSTANT_110000);

	jtagIdle();
	jtagReset();

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
        jtagRunTestTCK(CONSTANT_110000);

        // ISC_ENABLE ispen instruction
        jtagSendIR( 0xe8, prom);
        jtagSendDR( 0x34, 6, prom);

	prom_in_block = 0;
	prom_addr_hi = 0;
	promProgramCurrent = prom;

	printf("Programming PROM chip...       ");
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
                                jtagRunTestTCK(2);
                                                
                                // ISC_SERASE instruction
                                jtagSendIR( 0x0a, promProgramCurrent);
                                jtagIdle();
                                //jtagRunTestTCK(37000);
                                jtagRunTestTCK(9000);
                                                
                                // ISC_DISABLE conld instruction
                                jtagSendIR( 0xf0, promProgramCurrent);
                                jtagRunTestTCK(CONSTANT_110000);

			        // bypass instruction
			        jtagSendIR( 0xff, promProgramCurrent);
				jtagRunTestTCK(CONSTANT_110000);

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

#ifdef USB_SPEEDUPxxx
				while( len ) {
					int bytes_to_go = 512 - (prom_addr_lo & 511);
					if (bytes_to_go > len)
						bytes_to_go = len;
					if (bytes_to_go > 64)
						bytes_to_go = 64;		// choose minimum useful size

					int end_offset_in_sector = (prom_addr_lo + bytes_to_go)&511;
					int do_tms = (end_offset_in_sector || promProgramCurrent->tdr)?0:1;

					printf("btg=%d, len=%d, eois=%d, tms=%d, pal=$%x\n", bytes_to_go, len, end_offset_in_sector, do_tms, prom_addr_lo);

					jtagSendAndReceiveBits(do_tms, bytes_to_go*8, data, NULL);
					data += bytes_to_go;
					len -= bytes_to_go;
					prom_addr_lo += bytes_to_go;

					if (end_offset_in_sector == 0) {
						if( promProgramCurrent->tdr ) {
							unsigned char bytes[64];
							memset(bytes, 0, (promProgramCurrent->tdr+7)>>3 );
							jtagSendAndReceiveBits(1, promProgramCurrent->tdr, &bytes, NULL);
						}

						jtagRunTestTCK(2);

						uint16_t prom_faddr = (prom_addr_hi<<12) | (prom_addr_lo_start>>4);
						static int slowdown;
//						if( (++slowdown&3) == 0 ) { //prom_addr_lo & 4096) {
							static int display;
							printf("\b\b\b\b\b\b%04x %c",prom_faddr, "|/-\\"[display++&3]);
							fflush(stdout);
//						}

						// ISC_ADDRESS_SHIFT faddr instruction
						jtagSendIR( 0xeb, promProgramCurrent);
						jtagSendDR( prom_faddr, 16, promProgramCurrent);
						jtagRunTestTCK(2);
					
						// ISC_PROGRAM fpgm instruction
						jtagSendIR( 0xea, promProgramCurrent);
						jtagIdle();
						//jtagRunTestTCK(14000);
						jtagRunTestTCK(9000);
					
						// ISC_DISABLE conld instruction
						jtagSendIR( 0xf0, promProgramCurrent);
						jtagRunTestTCK(CONSTANT_110000);
                                                
						prom_in_block = 0;
						if (len)
							goto next_sector;
					}
				}
#elif defined( USB_SPEEDUPsddsds )
                                while( len-- ) {
                                        if( (++prom_addr_lo & 511) ) {
						jtagSendAndReceiveBits(0, 8, data++, NULL);
                                        } else {
                                                if (promProgramCurrent->tdr) {
							jtagSendAndReceiveBits(0, 8, data++, NULL);
                                                        for(i=1; i<promProgramCurrent->tdr; i++)
                                                		jtagOutput(0,0);
                                               		jtagOutput(0,1);           // send TMS bit at end of padding
                                                } else
							jtagSendAndReceiveBits(1, 8, data++, NULL);         // no padding, add TMS bit on last bit

                                                jtagRunTestTCK(20);

                                                uint16_t prom_faddr = (prom_addr_hi<<12) | (prom_addr_lo_start>>4);
						static int slowdown;
                                                if( (++slowdown&3) == 0 ) { //prom_addr_lo & 4096) {
							static int display;
//							printf("\b%c", "|/-\\"[display++&3]);
							printf("\b\b\b\b\b\b%04x %c",prom_faddr, "|/-\\"[display++&3]);
							fflush(stdout);
						}

                                                // ISC_ADDRESS_SHIFT faddr instruction
                                                jtagSendIR( 0xeb, promProgramCurrent);
                                                jtagSendDR( prom_faddr, 16, promProgramCurrent);
                                                jtagRunTestTCK(20);
                                                
                                                // ISC_PROGRAM fpgm instruction
                                                jtagSendIR( 0xea, promProgramCurrent);
                                                jtagIdle();
						//jtagRunTestTCK(14000);
						jtagRunTestTCK(9000);

                                                prom_in_block = 0;
                                                if (len)
                                                        goto next_sector;
                                        }
                                }
#elif defined( USB_SPEEDUP )
                                while( len ) {
					int bytes_to_go = 512 - (prom_addr_lo & 511);
					if (bytes_to_go > len)
						bytes_to_go = len;
					if (bytes_to_go > 16)
						bytes_to_go = 16;		// choose minimum useful size

					prom_addr_lo += bytes_to_go;
                                        if( prom_addr_lo & 511 ) {
						jtagSendAndReceiveBits(0, bytes_to_go*8, data, NULL);
						data += bytes_to_go;
						len -= bytes_to_go;
                                        } else {
                                                if (promProgramCurrent->tdr) {
							jtagSendAndReceiveBits(0, bytes_to_go*8, data, NULL);
                                                        for(i=1; i<promProgramCurrent->tdr; i++)
                                                		jtagOutput(0,0);
                                               		jtagOutput(0,1);           // send TMS bit at end of padding
                                                } else
							jtagSendAndReceiveBits(1, bytes_to_go*8, data, NULL);         // no padding, add TMS bit on last bit
						data += bytes_to_go;
						len -= bytes_to_go;

                                                jtagRunTestTCK(20);

                                                uint16_t prom_faddr = (prom_addr_hi<<12) | (prom_addr_lo_start>>4);
//						static int slowdown;
  //                                              if( (++slowdown&3) == 0 ) { //prom_addr_lo & 4096) {
							static int display;
//							printf("\b%c", "|/-\\"[display++&3]);
							printf("\b\b\b\b\b\b%04x %c",prom_faddr, "|/-\\"[display++&3]);
							fflush(stdout);
//						}

                                                // ISC_ADDRESS_SHIFT faddr instruction
                                                jtagSendIR( 0xeb, promProgramCurrent);
                                                jtagSendDR( prom_faddr, 16, promProgramCurrent);
                                                jtagRunTestTCK(20);
                                                
                                                // ISC_PROGRAM fpgm instruction
                                                jtagSendIR( 0xea, promProgramCurrent);
                                                jtagIdle();
						//jtagRunTestTCK(14000);
						jtagRunTestTCK(9000);

                                                prom_in_block = 0;
                                                if (len)
                                                        goto next_sector;
                                        }
                                }
#else
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

                                                jtagRunTestTCK(20);

                                                uint16_t prom_faddr = (prom_addr_hi<<12) | (prom_addr_lo_start>>4);
						static int slowdown;
                                                if( (++slowdown&3) == 0 ) { //prom_addr_lo & 4096) {
							static int display;
							printf("\b%c", "|/-\\"[display++&3]);
//							printf("\b\b\b\b\b\b%04x %c",prom_faddr, "|/-\\"[display++&3]);
							fflush(stdout);
						}

                                                // ISC_ADDRESS_SHIFT faddr instruction
                                                jtagSendIR( 0xeb, promProgramCurrent);
                                                jtagSendDR( prom_faddr, 16, promProgramCurrent);
                                                jtagRunTestTCK(20);
                                                
                                                // ISC_PROGRAM fpgm instruction
                                                jtagSendIR( 0xea, promProgramCurrent);
                                                jtagIdle();
						//jtagRunTestTCK(14000);
						jtagRunTestTCK(9000);

                                                prom_in_block = 0;
                                                if (len)
                                                        goto next_sector;
                                        }
                                }
#endif
                }
        }

	return 0;
}

