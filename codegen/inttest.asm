
	org #4000

	ld bc,#fadc
	ld a,'!'
	out (c),a

	ld bc,#7f8d
	out (c),c						; disable the roms, i.e. force the bootrom out of the way!

	di
	im 1
	ld hl,intvec
	ld a,#c3
	ld (#38),a
	ld (#39),hl
	ei							; every interrupt returns immediately

mainloop:
;	defs 13				; interestingly, i need 13 nops here where a real CPC should only need 12... :(

	jr x
x:	defs 9				; seems to equal 13 nops... hmmm

;	defs 12


	ld bc,#7f00
	inc d
	ld a,d
	and #1f
	or #40
	out (c),c
	out (c),a
	jr mainloop

intvec:
	exx
	ld bc,#fadc
	ld a,'.'
	out (c),a

	ld bc,#7f10
	inc d
	ld a,d
	and #1f
	or #40
	out (c),c
	out (c),a
	exx
	ei
	ret



	ld c,#41
	out (c),c						; colour 1

	halt
	ld bc,#7f10
	out (c),c
	ld c,#42
	out (c),c						; colour 1

	halt
	ld bc,#7f10
	out (c),c
	ld c,#43
	out (c),c						; colour 1

	halt
	ld bc,#7f10
	out (c),c
	ld c,#44
	out (c),c						; colour 1

	halt
	ld bc,#7f10
	out (c),c
	ld c,#45
	out (c),c						; colour 1

	halt
	ld bc,#7f10
	out (c),c
	ld c,#46
	out (c),c						; colour 1

	jr mainloop

