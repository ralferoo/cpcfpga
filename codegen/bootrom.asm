
	org #0080

; transfer 16K of data from #7c000 on memory chip to #c000 and jump to it

	ld bc,#fade
	ld a,ixl
	inc ix
	out (c),a
	
	ld a,'~'
	ld c,#dc
	out (c),a

	ld bc,#feff
	out (c),c				; ensure SPI bus is idle

	sbc hl,hl
delay:	dec hl
	ld a,h
	or l
	jr nz,delay				; wait a bit

	ld a,#ab
	out (c),b				; turn on flash rom CE
	inc b					; change to SPI data port
	out (c),a				; wake up
	out (c),a				; dummy
	out (c),a				; dummy
	out (c),a				; dummy
	out (c),a				; dummy
	dec b
	out (c),b

delay2:	dec hl
	ld a,h
	or l
	jr nz,delay2				; wait a bit

	ld de,#0307				; D=READ
	ld hl,#c000				; EHL = transfer address

	ld sp,hl
	push hl

	out (c),b				; turn on flash rom CE
	inc b					; change to SPI data port
	out (c),d				; READ data bytes
	out (c),e				; addr 1
	out (c),h				; addr 2
	out (c),l				; addr 3

	in a,(c)				; dummy read
	;dec hl	;	in a,(c)		; dummy read
xferloop:
	in a,(c)
	ld (hl),a
	inc hl

	call printhex

	ld a,h
	or l
	jr nz,xferloop

	dec b
	out (c),c				; finish with SPI bus

	ret	;jp #c000


printhex:
	push af
	rra
	rra
	rra
	rra
	and #f					; upper nibble in A
	cp 10
	sbc a,#69
	daa					; A=hex character in ascii
	call putch
	pop af
	and #f					; lower nibble in A
	cp 10
	sbc a,#69
	daa					; A=hex character in ascii

; output char in A

putch:
	push bc
	ld bc,#fadd
putchloop:
	defb #ed,#70	;in f,(c)
	jp p,putchloop				; loop until tx uart idle
	dec c
	out (c),a
	pop bc
	ret


