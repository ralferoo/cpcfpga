
	org #4000

tryserial:
	ld bc,#fadd
	in a,(c)
	rlca
	jr nc,tryserial				; skip if no serial data

	dec c
	out (c),d				; output the updated character
	inc c

	inc d
	jr tryserial

