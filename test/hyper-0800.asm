      org #800

	ld de,#7000
	ld hl,playcode
	ld bc,playcode_len
	ldir

	ld de,#4000
	ld hl,music
	ld bc,music_len
	ldir

	ld de,#1000
	push de
	ld hl,maincode
	ld bc,maincode_len
	ldir

	ret

maincode:
	incbin build/hyper-1000.bin
maincode_len equ ($-maincode)

music:
	incbin build/hyper-4000.bin
music_len equ ($-music)

playcode:
	incbin build/hyper-7000.bin
playcode_len equ ($-playcode)

