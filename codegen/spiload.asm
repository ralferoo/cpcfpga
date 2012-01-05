
	org #0000

; transfer 16K of data from #7c000 on memory chip

	ld bc,#fafe			; FAFE = SPI control
	out (c),c			; drive bit 0 low = flash ROM chip select

	ld hl,#4000			; transfer address
	inc c				; FAFF = SPI data port

	ld a,#03			; SPI: READ
	out (c),a
	
	ld de,#7c0			; transfer from #7c000, address is D:E:L (L=0)
	out (c),d
	out (c),e
	out (c),l			; output 3 bytes of address
	
	ld a,#80			; end at #8000
xferloop:
	out (c),a			; dummy write to trigger a read
	ini				; read the byte and store it in memory
	inc b				; fix b which has just been decremented
	cp h
	jr z,xferloop			; loop until we reach the last byte

	ld a,c				; FF
	dec c				; FAFE = SPI control
	out (c),a			; turn off ROM chip select

	jp #4000			; finally, execute the boot program
