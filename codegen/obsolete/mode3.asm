

	org #4000

;	jp start
;data:
;	incbin	codegen/snap_mode0.scr
;start:
;	ld de,#4000
;	ld hl,data
;	ld bc,#4000
;	ldir

	ld bc,#7f83
	out (c),c

	ld d,0
	ld hl,palette
loop:
	out (c),d
	ld a,(hl)
	inc hl
	or #40
	out (c),a
	inc d
	ld a,d
	cp 17
	jr nz,loop

	rst 0

palette:
	defb #4,#a,#13,#c,#b,#14,#15,#d,#6,#1e,#1f,#7,#12,#19,#a,#7,#4

