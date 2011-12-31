
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

	inc ix

	ld hl,#3000
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


; output hight byte of address

	ld a,h
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
busy7h:	in a,(c)
	rla
	jr nc,busy7h
	dec c

	ld a,h
	and #f
	add a,#90
	daa
	adc a,#40
	daa
	out (c),a

	inc c
busy8l:	in a,(c)
	rla
	jr nc,busy8l
	dec c

; output low byte of address

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

; continue with output

	ld a,':'
	out (c),a

no_header:

	inc c
busy9:	in a,(c)
	rla
	jr nc,busy9
	dec c

	ld a,' '
	out (c),a

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
	inc hl
	ld a,l
	or h
	jp nz, dump_memory

	; output a counter

	; jp repeat

	push ix				; corrupt the stack a bit
	ld bc,#fadd
	in a,(c)
	push af
	call repeat



string:
       defb 13,10,"Data dump - ",0
