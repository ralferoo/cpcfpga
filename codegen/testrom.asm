
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

	ld bc,#fadd
busy1:	in a,(c)
	rla
	jr nc,busy1
	dec c

	ld a,(hl)
	out (c),a

	inc hl
	jr loop

restart:
	inc c
busy2:	in a,(c)
	rla
	jr nc,busy2
	dec c

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

	inc c
busy3:	in a,(c)
	rla
	jr nc,busy3
	dec c

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

	inc c
busy4:	in a,(c)
	rla
	jr nc,busy4
	dec c
	out (c),d

	inc c
busy5:	in a,(c)
	rla
	jr nc,busy5
	dec c
	out (c),e

	inc c
busy6:	in a,(c)
	rla
	jr nc,busy6
	dec c

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

	inc c
busy7:	in a,(c)
	rla
	jr nc,busy7
	dec c

	ld a,'0'
	out (c),a

	inc c
busy8:	in a,(c)
	rla
	jr nc,busy8
	dec c

	ld a,':'
	out (c),a

	inc c
busy9:	in a,(c)
	rla
	jr nc,busy9
	dec c

	ld a,' '
	out (c),a
no_header:

	inc c
busya:	in a,(c)
	rla
	jr nc,busya
	dec c

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

	inc c
busyb:	in a,(c)
	rla
	jr nc,busyb
	dec c


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
	jp nz, dump_memory

	; output a counter



	jp repeat


string:
       defb 13,10,"Data dump - ",0
