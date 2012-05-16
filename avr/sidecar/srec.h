void IHEX_Start( uint8_t type, uint16_t faddr, uint8_t len );
void IHEX_Byte( uint8_t byte );
void IHEX_EndLine(void);
void IHEX_AddrHigh( uint16_t hiaddr );
void IHEX_EndOfFile(void);

//////////////////////////////////////////////////////////////////////////////

void IHEX_DoError(char* str);
void StartIHEXRequest( void );

void StartIHEX( void (*fn)( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data) );

void IHEX_Early( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data);
void IHEX_Null( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data);
void IHEX_Program( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data);



