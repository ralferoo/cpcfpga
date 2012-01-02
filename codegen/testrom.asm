
	org #0000


flash:
	; led flash

	ld bc,#fade
	ld a,l
	out (c),a
	add a,5
	ld l,a

	; check serial port
	dec c
	in a,(c)

	;and #80
	;or l
	;ld l,a

	rla
	jr nc,flash

	; serial port not busy, send data
	dec c
	inc h
	out (c),h

	jr flash

	end







	ld ix,0
	ld sp,#fffe

start:
	ld hl,#4000
fill:	ld (hl),#bd
	inc hl
	ld a,l
	or h
	jr nz, fill

repeat:	

	ld hl,string
loop:	
	ld a,(hl)
	or a
	jr z,restart
	call outchar
	inc hl
	jr loop

restart:
	ld a,ixh
	call outhex
	ld a,ixl
	call outhex

domodify:
	ld b,ixl
modify_loop2:
	ld c,b
	ld hl,#4000
modify_loop:
	inc (hl)
	inc hl
	djnz modify_loop
	ld b,c
	djnz modify_loop2

	inc ix

	ld hl,#0000

dump_memory:
	ld bc,#fade
	out (c),l

	ld a,l
	and #f
	jr nz,no_header

	ld a,#d
	call outchar
	ld a,#a
	call outchar

	ld a,h
	call outhex
	ld a,l
	call outhex

	ld a,':'
	call outchar

no_header:
	ld a,' '
	call outchar

	ld a,(hl)
	call outhex

donext:
	inc hl

	ld a,h
	cp #4
	jr z,skip
	cp #42
	jr nz,noskip
	ld h,#ff
skipped:
	ld a,#d
	call outchar
	ld a,#a
	call outchar
	ld a,'*'
	call outchar
noskip:
	or l
	jp nz, dump_memory

	; jp repeat

	push ix				; corrupt the stack a bit
	ld bc,#fadd
	in a,(c)
	push af
	call repeat

skip:
	ld h,#3f
	jr skipped

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; output hex in A, corrupts AF

outhex:
	push af
	rra
	rra
	rra
	rra
	call outhexnibble
	pop af
outhexnibble:
	and #f
	add a,#90
	daa
	adc a,#40
	daa
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; output character in A

outchar:
	push bc
	ld bc,#fadd
outcharbusy:
	defb #ed,#70	;in f,(c)
	jp p,outcharbusy
	dec c

;	in c,(c)
;	rl c
;	jr nc,outcharbusy
;	ld bc,#fadc

	out (c),a
	pop bc
	ret

string:
       defb 13,10,"Data dump, iteration ",0
