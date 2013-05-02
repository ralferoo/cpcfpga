#define SD_SPARE	(1<<5)
#define SD_CS		(1<<4)
#define SD_MISO		(1<<0)
#define SD_CLK		(1<<1)
#define SD_MOSI		(1<<6)

#define SD_PORT		PORTD
#define SD_DDR		DDRD
#define SD_PIN		PIND

void DISK_Device_ProcessControlRequest(void);
void DISK_Init(void);
