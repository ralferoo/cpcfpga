
	org #0000

; transfer 16K of data from #7c000 on memory chip to #8000 and jump to it

	ld hl,#8000			; transfer address

	ld bc,#fafe			; FAFE = SPI control
	out (c),c			; drive bit 0 low = flash ROM chip select

	inc c				; FAFF = SPI data port
	ld de,#03c0			; D = SPI: READ, E = middle byte of address

	out (c),d			; 03 = read
	out (c),c			; FF = MSB addr
	out (c),e			; C0 = mid addr
	out (c),l			; 00 = LSB addr -> output 3 bytes of address FFC000 (top 16KB)
	
xferloop:
	out (c),l			; dummy write to trigger a read
	ini				; read the byte and store it in memory
	inc b				; fix b which has just been decremented
	ld a,h				; end at #c000
	cp e
	jr z,xferloop			; loop until we reach the last byte

;	ld a,c				; FF
;	dec c				; FAFE = SPI control
;	out (c),a			; turn off ROM chip select

	jp #8000			; finally, execute the boot program
