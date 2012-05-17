void HEX_DoError(const char* str);
void HEX_DoErrorConst( const char* PROGMEM str );

void HEX_Start( uint8_t type, uint16_t faddr, uint8_t len );
void HEX_Byte( uint8_t byte );
void HEX_EndLine(void);
void HEX_AddrHigh( uint16_t hiaddr );
void HEX_EndOfFile(void);

//////////////////////////////////////////////////////////////////////////////

void StartHEXRequest( void );

void StartHEX( void (*fn)( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data) );

void HEX_Early( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data);
void HEX_Null( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data);
void HEX_Program( uint8_t type, uint8_t len, uint16_t addr, uint8_t *data);



