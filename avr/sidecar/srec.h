void SREC_Start( uint8_t type, uint16_t faddr, uint8_t len );
void SREC_Byte( uint8_t byte );
void SREC_EndLine(void);
void SREC_AddrHigh( uint16_t hiaddr );
void SREC_EndOfFile(void);

//////////////////////////////////////////////////////////////////////////////

void StartSRECRequest( void );

void StartSREC( void (*fn)( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data) );

void SREC_Early( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data);
void SREC_Null( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data);
void SREC_Program( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data);



