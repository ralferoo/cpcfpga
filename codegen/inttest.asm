
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

	jr mainloop2

mainloop:
;	defs 13				; interestingly, i need 13 nops here where a real CPC should only need 12... :(

;	jr x
;x:	defs 9				; seems to equal 13 nops... hmmm

	defs 12


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
	ex af,af'
	ld bc,#fadc
	ld a,'.'
	out (c),a

	ld bc,#7f10
	inc d
	ld a,d
	and #1f
	or #40
	cp #46
	jr nz,cont
	ld d,#40
cont:
	out (c),c
	out (c),a

	ex af,af'
	exx
	ei
	ret


mainloop2:
	halt
	jr mainloop2

	ld bc,#7f10
	out (c),c
	ld hl,#41
	out (c),l						; colour 1
	out (c),h
	out (c),l	; and background colour

	halt
	ld bc,#7f10
	out (c),c
	ld hl,#42
	out (c),l						; colour 1
	out (c),h
	out (c),l	; and background colour

	halt
	ld bc,#7f10
	out (c),c
	ld hl,#43
	out (c),l						; colour 1
	out (c),h
	out (c),l	; and background colour

	halt
	ld bc,#7f10
	out (c),c
	ld hl,#44
	out (c),l						; colour 1
	out (c),h
	out (c),l	; and background colour

	halt
	ld bc,#7f10
	out (c),c
	ld hl,#45
	out (c),l						; colour 1
	out (c),h
	out (c),l	; and background colour

	halt
	ld bc,#7f10
	out (c),c
	ld hl,#46
	out (c),l						; colour 1
	out (c),h
	out (c),l	; and background colour

	jr mainloop2

