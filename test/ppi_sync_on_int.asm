

	org #4000

	di
	ld hl,intvec
	ld a,#c3
	ld (#38),a
	ld (#39),hl

;	ld hl,#c000
	ei

infloop:
	halt
	jr infloop

intvec:

	ld a,#f5
	in a,(0)
	rrca
	sbc a,a
	ld h,#c0
	ld (hl),a

	xor a
	ld h,#c8
	ld (hl),a
	ld h,#d8
	ld (hl),a

	ld bc,#f500
	in a,(c)
	rrca
	sbc a,a
	and #0f
	ld h,#d0
	ld (hl),a

	inc l
	ei
	ret


