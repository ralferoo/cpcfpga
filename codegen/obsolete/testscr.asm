

	org #4000

	ld bc,#bc00+12
	out (c),c
	ld bc,#bd30
	out (c),c

	ld sp,#bffe

restart:
	ld bc,#7f01
	out (c),c

	ld a,d
	and #1f
	or #40
	out (c),a
	inc d

	ld hl,#c000
	ld bc,#fade
	in c,(c)
loop:
	ld (hl),c
	inc hl

	ld a,l
	or h
	jr nz,loop
	
	jr restart

