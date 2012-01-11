
	org #0000

        di			; 1
        im 1			; 2
        ld hl,&c9fb		; 3
        ld (&38),hl		; 5
        ei			; 1

	jr mainloop		; 3	; 15 total
xxx:

	defs #38-xxx
	
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
