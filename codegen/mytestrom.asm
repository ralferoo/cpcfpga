

	org #c000

	defb 1			; background
	defb 0,1,0		; version

	defw names

	jp entry
	jp hello
	jp test

names:
	defb "TEST RO",'M'+#80
	defb "HELL",'O'+#80
	defb "TES",'T'+#80
	defb 0

entry:
	push de
	push hl

	ld hl,entry_msg
	call print

	pop hl
	pop de

	and a
	ld bc,#10
	sbc hl,bc

	scf
	ret

test:
	ld hl,plustest_start
	ld de,#8000
	ld bc,plustest_length
	ldir

	ld c,#ff
	ld hl,#8000
	jp #1b			; disable rom/ram, call #8000

hello:
	ld hl,hello_msg

print:
	ld a,(hl)
	inc hl
	or a
	ret z
	call #bb5a
	jr print

entry_msg:
	defb " Ralf's test rom 1.00.",13,10
	defb " Try |HELLO or |TEST",13,10,13,10,0

hello_msg:
	defb "Hello mate!",13,10,0

plustest_start:
	incbin plustest/plustest.bin
plustest_length equ ($-plustest_start)
