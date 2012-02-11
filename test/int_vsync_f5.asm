
	org #4000
	
	ld a,#c3
	ld hl,intvec

	ld bc,#7f40
	ld de,#0010
	
	di
	ld (#38),a
	ld (#39),hl
	ei

infloop:
	halt
	jr infloop
	
intvec:
       	ld a,#f5
       	in a,(0)
       	rra
       	jr c, nov
       	
       	inc c
       	res 5,c
       	out (c),d
       	out (c),c
       	out (c),e
       	out (c),c
       	ei
       	ret

nov:
    	ld c,#46
       	out (c),d
       	out (c),c
       	out (c),e
       	out (c),c
    	ei
    	ret

