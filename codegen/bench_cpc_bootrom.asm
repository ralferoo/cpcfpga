
	org #0000

        di
        im 1
        ld hl,&c9fb
        ld (&38),hl
        ei

	jr mainloop
xxx:

	defs #38-xxx
	
;	org #38

	ei
	ret

mainloop:
	defs 11				; interestingly, i need 13 nops here where a real CPC should only need 12... :(

;	jr x
;x:	defs 9				; seems to equal 13 nops... hmmm

;	defs 12

	ld b,#f5		; 2
	in a,(c)		; 4
	rrca			; 1
	sbc a,a			; 1

	ld bc,#fade		; 3
	out (c),a		; 4

	defs 32-8-3-4		; 17

	ld bc,#7f00		; 3
	inc d			; 1
	or d			; 1			ld a,d
	and #1f			; 2
	or #40			; 2
	out (c),c		; 4
	out (c),a		; 4
	jr mainloop		; 3			SEEMS TO TAKE 4!!!

