
	org #4000

	di
	ld sp,#bfff

	ld bc,#7f8c
	out (c),c

	ld hl,#c9fb		; ei : ret
	ld (#38),hl
	ei

	ld bc,#fade
	ld a,#a				; left LED, no reset
	out (c),a

	ld bc,0
reset_wait_1:
	dec bc
	ld a,b
	or c
	jr nz, reset_wait_1
	ld bc,#fade
	ld a,#0				; 2nd LED, reset
	out (c),a


	jp 0
