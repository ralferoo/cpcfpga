
	org #4000

	di
	im 1
	ld hl,intvec
	ld a,#c3
	ld (#38),a
	ld (#39),hl

	ld bc,#7f10
	out (c),c
	ld c,#40

	ei							; every interrupt returns immediately

dohalt:
	ld a,#f5
	in a,(0) 		;(#f5)
	rra
	jr nc,dohalt
	halt

settle:
	ld a,#f5
	in a,(0) 		;(#f5)
	rra
	jr c,settle

	ld bc,#7f40
noclear:
	inc c
	res 5,c
	out (c),c

        ld a,#f5
	in a,(0)
	rra
	jr nc,noclear

;;	halt
	jr dohalt

intvec:
	ei
	ret

