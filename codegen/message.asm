
	org #4000

	ld sp,#fffe
	ld bc,#fadd

	ld hl,string
loop:	
	defb #ed,#70	;in f,(c)
	jp p,loop

	ld a,(hl)
	or a
	jr z,restart

	dec c
	out (c),a
	inc c

	inc hl
	jr loop

restart:
	rst 0

string:
       defb 13,10,"Simple message test...",13,10,0

progend:

