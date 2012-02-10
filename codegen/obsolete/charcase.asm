
	org #4000

tryserial:
	ld bc,#fadd
	in a,(c)
	and #40
	jr z,tryserial				; skip if no serial data
	dec c
	in a,(c)				; get serial character
	ld d,a
	and #40
	rrca					; if alphabetical, a now contains #20
	xor d					; and now the case inverted
	out (c),a				; output the updated character

	ld (hl),a
	inc l

	jr tryserial
