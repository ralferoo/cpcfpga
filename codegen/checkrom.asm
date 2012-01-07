
	org #4000


	ld hl,welcome
	call printstr

	ld bc,#feff
	out (c),c				; turn off SPI, default to clock high
	out (c),b				; turn on flash rom CE

	inc b					; change to SPI data port
	ld hl,#90
	out (c),l				; read manufacturer ID
	out (c),h
	out (c),h
	out (c),h				; from address 0

	in a,(c)				; read manufacturer ID
	call printhex
	in a,(c)				; read device ID
	call printhex
	
	dec b
	out (c),c				; turn off flash rom
;;;
	ld hl,jedec_id
	call printstr

	out (c),b				; turn on flash rom CE
	inc b					; change to SPI data port
	ld a,#9f
	out (c),a				; read jedec ID

	in a,(c)				; read manufacturer ID
	call printhex
	in a,(c)				; read memory type ID
	call printhex
	in a,(c)				; read memory capacity ID
	call printhex
	dec b
	out (c),c				; turn off flash rom
;;;
	ld hl,serial_id
	call printstr

	out (c),b				; turn on flash rom CE
	inc b					; change to SPI data port
	ld hl,#4b
	out (c),l				; read serial ID
	out (c),h				; dummy 1
	out (c),h				; dummy 2
	out (c),h				; dummy 3
	out (c),h				; dummy 4

	in a,(c)				; read SN #1
	call printhex
	in a,(c)				; read SN #2
	call printhex
	in a,(c)				; read SN #3
	call printhex
	in a,(c)				; read SN #4
	call printhex
	in a,(c)				; read SN #5
	call printhex
	in a,(c)				; read SN #6
	call printhex
	in a,(c)				; read SN #7
	call printhex
	in a,(c)				; read SN #8
	call printhex

	dec b
	out (c),c				; turn off flash rom
;;;

	
	ld hl,end_msg
	call printstr

	rst 0					; jump back to the bootloader

welcome:
	defb 13,10,"Testing ROM chip...",13,10

	defb 13,10,"Fetching REMS: ",0
jedec_id:
	defb 13,10,"Fetching JEDEC ID: ",0
serial_id:
	defb 13,10,"Serial number: ",0
end_msg:
	defb 13,10,13,10,"Resetting...",13,10,0

; print message in HL, BC=FADD, AF corrupted

printstr:
	ld a,(hl)
	or a
	ret z					; return at end of string
	call putch
	inc hl
	jr printstr

; output hex digit in A, BC=FADD

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
