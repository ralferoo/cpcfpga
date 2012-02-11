
	org #4000

	ld a,1
	call &bc0e
	
	ld b,4
prloop2:
	ld a, 32
prloop:	call &bb5a
	inc a
	jr nz,prloop
	djnz prloop2

	ld a,#c3
	ld hl,intvec

	ld bc,#7f01
	out (c),c
	ld c,#54
	out (c),c
	ld de,#034b
	out (c),d
	out (c),e
	ld de,#0010
	
	di
	ld (#38),a
	ld (#39),hl

	exx
	ex af,af'

	ei

infloop:
	halt

	exx
	ld a,c
	exx
	cp #45
	jr nz,infloop

	ld e,13
	call waitrowe

	ld bc,#7f9d
	out (c),c

	ld de,#52
	out (c),d
	out (c),e

;	ld bc,#7f8d
;	out (c),c

	jr infloop

waitrowe:
	ld b,14
lpwtrow:
	djnz lpwtrow
	nop
	nop
	nop
	dec e
	jr nz,waitrowe
	ret
	
intvec:
	exx
	ex af,af'

       	ld a,#f5
       	in a,(0)
       	rra
       	jr c, vblank

       	inc c
       	res 5,c
       	jr docolour

vblank:
	ld c,#42
	defs 3

;	sbc a,a
;	and -6
;	add a,c
;	ld c,a

;       	jr nc, docolour
;    	ld c,#42			; reset on vsync

docolour:      	
       	out (c),d
       	out (c),c
       	out (c),e
       	out (c),c


	jp doret



	ld a,#45
	sub c
	sub #1
	sbc a,a				; A=FF for C=48, 00 otherwise
	

	defs 30				; move to an appropriate bit of screen		
	
marker:
        ld (#c370+0*#800),a
        ld (#c374+1*#800),a
        ld (#c378+2*#800),a
        ld (#c37c+3*#800),a
        ld (#c330+4*#800),a
        ld (#c334+5*#800),a
        ld (#c338+6*#800),a
        ld (#c33c+7*#800),a
        defs 63-8*4

        ld (#c370+1*#800),a
        ld (#c374+2*#800),a
        ld (#c378+3*#800),a
        ld (#c37c+4*#800),a
        ld (#c330+5*#800),a
        ld (#c334+6*#800),a
        ld (#c338+7*#800),a
        ld (#c33c+0*#800),a
        defs 63-8*4

        ld (#c370+1*#800),a
        ld (#c374+2*#800),a
        ld (#c378+3*#800),a
        ld (#c37c+4*#800),a
        ld (#c330+5*#800),a
        ld (#c334+6*#800),a
        ld (#c338+7*#800),a
        ld (#c33c+0*#800),a
        defs 63-8*4

        ld (#c370+2*#800),a
        ld (#c374+3*#800),a
        ld (#c378+4*#800),a
        ld (#c37c+5*#800),a
        ld (#c330+6*#800),a
        ld (#c334+7*#800),a
        ld (#c338+0*#800),a
        ld (#c33c+1*#800),a
        defs 63-8*4

        ld (#c370+3*#800),a
        ld (#c374+4*#800),a
        ld (#c378+5*#800),a
        ld (#c37c+6*#800),a
        ld (#c330+7*#800),a
        ld (#c334+0*#800),a
        ld (#c338+1*#800),a
        ld (#c33c+2*#800),a
        defs 63-8*4

        ld (#c370+4*#800),a
        ld (#c374+5*#800),a
        ld (#c378+6*#800),a
        ld (#c37c+7*#800),a
        ld (#c330+0*#800),a
        ld (#c334+1*#800),a
        ld (#c338+2*#800),a
        ld (#c33c+3*#800),a
        defs 63-8*4

        ld (#c370+5*#800),a
        ld (#c374+6*#800),a
        ld (#c378+7*#800),a
        ld (#c37c+0*#800),a
        ld (#c330+1*#800),a
        ld (#c334+2*#800),a
        ld (#c338+3*#800),a
        ld (#c33c+4*#800),a
        defs 63-8*4

        ld (#c370+6*#800),a
        ld (#c374+7*#800),a
        ld (#c378+0*#800),a
        ld (#c37c+1*#800),a
        ld (#c330+2*#800),a
        ld (#c334+3*#800),a
        ld (#c338+4*#800),a
        ld (#c33c+5*#800),a
        defs 63-8*4

        ld (#c370+7*#800),a
        ld (#c374+0*#800),a
        ld (#c378+1*#800),a
        ld (#c37c+2*#800),a
        ld (#c380+3*#800),a
        ld (#c384+4*#800),a
        ld (#c388+5*#800),a
        ld (#c38c+6*#800),a
;        defs 63-8*4

doret:
	exx
	ex af,af'

       	ei
       	ret


