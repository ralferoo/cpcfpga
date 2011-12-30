
	org #0000

start:


	ld ix,0

	ld hl,#8000
	xor a
fill:	ld (hl),a
	inc l
	cp l
	jr nz, fill

repeat:	

	ld hl,string
loop:	
	ld a,(hl)
	or a
	jr z,restart
	inc hl

	ld bc,#fadc
	out (c),a
	jr loop

restart:
	ld a,ixl

	rra
	rra
	rra
	rra

	and #f
	add a,#90
	daa
	adc a,#40
	daa
	out (c),a

	ld a,ixl

	and #f
	add a,#90
	daa
	adc a,#40
	daa
	out (c),a

domodify:
	ld b,ixl

	ld hl,#8000
modify_loop:
	inc (hl)
	inc hl
	djnz modify_loop

	inc ixl

	ld hl,#8000
	ld de,#d0a

dump_memory:
	ld bc,#fade
	out (c),l

	ld bc,#fadc

	ld a,l
	and #f
	jr nz,no_header

	out (c),d
	out (c),e

	ld a,l
	rra
	rra
	rra
	rra

	and #f
	add a,#90
	daa
	adc a,#40
	daa
	out (c),a
	ld a,'0'
	out (c),a
	ld a,':'
	out (c),a
	ld a,' '
	out (c),a
no_header:
	ld a,(hl)

	rra
	rra
	rra
	rra

	and #f
	add a,#90
	daa
	adc a,#40
	daa
	out (c),a

	ld a,(hl)

	and #f
	add a,#90
	daa
	adc a,#40
	daa
	out (c),a
donext:
	inc l
	ld a,l
	or a
	jr nz, dump_memory

	; output a counter



	jp repeat


string:
       defb 13,10,"Data dump - ",0
