
	org #0000

	ld bc,#fefe
	ld a,#a0
	out (c),a		; make upper ROM writeable, leave boot rom active

	ld bc,#7f00
	out (c),c		; keep roms enabled

	ld bc,#fefd
	ld a,#80
	out (c),a		; enable rom #7

	ld hl,#c543

	ld bc,#df07
	out (c),c		; select rom #7

	ld (hl),c		; write a marker to it
	ld a,(hl)		; test read it

	ld bc,#df00
	out (c),c		; select rom #0
	ld (hl),c
	ld a,(hl)

	ld bc,#fefe
	ld a,#20
	out (c),a		; make upper ROM read-only, leave boot rom active

	ld (hl),b
	ld a,(hl)		; test rom #0

	ld bc,#df07
	out (c),c		; select rom #7

	ld (hl),b
	ld a,(hl)		; test rom #7

	ld bc,#df00
	out (c),c		; select rom #0

	ld (hl),b
	ld a,(hl)		; test rom #0

	jr timings




	di

	ld bc,#7f8d		; disable upper/lower ROM
	out (c),c

	ld hl,test
	ld de,test
	ld bc,testlen
	ldir			; copy myself to RAM

	ld bc,#fefe
	xor a
	out (c),a		; roms read only, boot rom disabled

test:

	ld a,#69
	ld hl,#c000
	ld (hl),a
	ld e,(hl)

	ld d,#c0
	out (c),d		; roms writable, should still be ram selected

	inc hl
	ld (hl),a
	ld e,(hl)

	ld bc,#7f85		; enable upper, disable lower ROM
	out (c),c

	inc hl
	ld (hl),a
	ld e,(hl)

	ld bc,#fefe
	xor a
	out (c),a		; roms read only, boot rom disabled

	inc hl
	ld (hl),a
	ld e,(hl)

infloop:
	jr infloop

	ld de,#4000
	push de
	ld hl,test2
	ld bc,test2len
	ldir			; copy more data (this should be from ram not rom)
	ret

test2:				; running at #4000
	ld hl,(test)
	ld bc,#fe

test2len equ ($-test2)

	ld hl,(test)
	ld bc,#fe

testlen equ ($-test)

	nop	
	nop			; this 
	

timings:


        di			; 1
        im 1			; 2
        ld hl,&c9fb		; 3
        ld (&38),hl		; 5
        ei			; 1

	jr mainloop		; 3	; 15 total
xxx:

;	org #38

	ei
	ret

mainloop:
	defs 12				; interestingly, i need 13 nops here where a real CPC should only need 12... :(
;12

;	jr x
;x:	defs 9				; seems to equal 13 nops... hmmm

;	defs 12

	ld b,#f5		; 2
	in a,(c)		; 4
	rrca			; 1
	sbc a,a			; 1
;8
	ld bc,#fade		; 3
	out (c),a		; 4
;7
	defs 32-8-3-4		; 17
;17
	ld bc,#7f00		; 3
	inc d			; 1
	or d			; 1			ld a,d
	and #1f			; 2
	or #40			; 2
	out (c),c		; 4
	out (c),a		; 4
	jr mainloop		; 3			SEEMS TO TAKE 4!!!
;20

; = 64

; 3a = 15, 79, 143, 207, 15
