
	org #4000


	ld e,0
keybloop:
	ld a,e
	call printsinglehex
	ld a,':'
	call putch

	ld d,0
	ld bc,#f782			; port A out
	out (c),c
	ld bc,#f40e			; select port A
	out (c),c
	ld bc,#f6c0			; latch address
	out (c),c
	out (c),d			; idle

	ld bc,#f792			; port A in
	out (c),c
	dec b
	ld a,e
	or #40
	out (c),a			; select kbdline

	ld b,#f4
	in a,(c)			; read port
	ld bc,#f782
	out (c),c			; port A out
	dec b
	out (c),d			; idle

	call printhex			; output kbd line

	ld a,13
	call putch
	ld a,10
	call putch

	inc e
	ld a,e
	sub 10
	sbc a,a				; A=FF if less than 10
	and e
	ld e,a
	jr keybloop


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
printsinglehex:
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
