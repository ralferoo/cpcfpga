
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

	ld b,#f5
	in a,(c)
	rrca
	sbc a,a

	ld bc,#fade
	out (c),a

	defs 32-8-3-4

	ld bc,#7f00
	inc d
	or d			;ld a,d
	and #1f
	or #40
	out (c),c
	out (c),a
	jr mainloop

