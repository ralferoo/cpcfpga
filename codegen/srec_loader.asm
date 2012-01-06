
	org #0000

	ld sp,#fffe
restart:
	ld ix,0					; count of srec records=0
	ld hl,welcome_msg
	call print_str

mainloop:					; mainloop - fetch command
	call getch
	cp #d
	jr z,mainloop
	cp #a
	jr z,mainloop

mainloop_char:					; mainloop with command in A
	cp 'S'
	jr z,handle_srec

invalid_command:				; invalid command. skip rest of line and continue with next
	push af
	ld hl,only_srec_msg
	call print_str
	pop af

skip_to_nl:					; check if this char is end of line, if so continue
	cp #d
	jr z,mainloop
	cp #a
	jr z,mainloop
	call getch				; otherwise get next char and try again
	jr skip_to_nl

handle_srec:
	call getch
	cp '1'
	jr z,handle_srec_1
	cp '9'
	jr z,handle_srec_9
	cp '5'
	jr z,handle_srec_5
	cp '0'
	jr nz,invalid_command

handle_srec_0:
	ld ix,0					; count of srec records=0
	jr skip_to_nl

handle_srec_5:
	call start_srec_line
	call gethex_hl
	push ix
	pop de
	and a
	sbc hl,de				; check we read the correct number of records
	jr z,end_srec_line

srec_count_wrong:
	ld hl,incorrect_number
	call print_str
	jr skip_to_nl

handle_srec_9:
	call start_srec_line
	call gethex_hl				; hl is address to run from
	call check_end_srec_line
	jr nz,invalid_line			; print error

	ld a,ixh
	and #80
	jr nz,invalid_line			; seen at least one error

	push hl
	ld hl,ok_msg
	jr print_str	; jp (hl)		; finally execute the code

handle_srec_1:
	call start_srec_line
	sub 3
	ld b,a					; byte count
	call gethex_hl				; hl is address

	ld a,ixh
	and #80
	jr nz,invalid_line			; seen at least one error, don't want to read any bytes!
get_bytes:
	call gethex_a
	ld (hl),a
	inc hl
	djnz get_bytes
	inc iy					; increase line count
	jr end_srec_line

start_srec_line:
	ld iy,1					; iyh = xsum so far, iyl = count left
	call gethex_a				; length
	ld iyl,a				; bytes left
	ret
	
check_end_srec_line:
	call gethex_a				; fetch checksum byte (ignore it)
	ld a,iyl				; the checksum should be FF
	inc a					; make it 00 for success
	or iyh					; add in bits for characters left (should be 0)
	ret z					; return if everything ok 

	ld a,ixh
	or #80
	ld ixh,a				; set marker that code can't be run
	ret

end_srec_line:
	call check_end_srec_line
	jr z,skip_to_nl_far			; no data expected left, great!
invalid_line:
	ld hl,invalid_xsum
	call print_str
skip_to_nl_far:
	jp skip_to_nl
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; output string in HL

print_str:
	ld a,(hl)
	or a
	ret z
	call outchar
	inc hl
	jr print_str

welcome_msg:
	defb "SREC",13,10,13,10,0
	;defb "SREC loader, by Ranulf Doswell",13,10,13,10
only_srec_msg:
	;defb "S0,S1,S5,S9 only",13,10,0
	;defb "Only SREC types S0,S1,S5,S9 supported.",13,10,0
invalid_xsum:
	;defb "xsum error",13,10,0
	;defb "Invalid checksum detected, please try again...",13,10,0
incorrect_number:
	;defb "count error",13,10,0
	;defb "Record count in S5 record didn't match number of S1 records.",13,10,0

	defb "ERROR",13,10,0

ok_msg:
	defb "OK",13,10,0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; input hex word in HL

gethex_hl:
	call gethex_a
	ld h,a
	call gethex_a
	ld l,a
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; input hex byte in A

gethex_a:
	push bc
	call hex_nibble
	rla
	rla
	rla
	rla
	ld c,a
	call hex_nibble
	or c
	pop bc
	ret

hex_nibble:
	call getch
	or #20			; lowercase any alpha
	cp 'g'
	jr nc,hexerr
	cp 'a'
	jr c,hexalpha
	sub '0'
	jr c,hexerr
	cp '9'+1
	ret nc
hexerr:
	ld a,ixh
	or #80
	ld ixh,a				; set marker that code can't be run
	ret
hexalpha:
	sub 'a'-10
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; input character in A

getch:
	push bc
	ld bc,#fadd
incharbusy:
	in a,(c)
	and #40
	jr z,incharbusy
	dec c
	in a,(c)				; get serial character
	pop bc
	ret

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














	end

	ld hl,#4000

tryserial:
	ld bc,#fadd
	in a,(c)
	and #40
	jr z,noserial				; skip if no serial data
	dec c
	in a,(c)				; get serial character
	ld d,a
	and #40
	rrca					; if alphabetical, a now contains #20
	xor d					; and now the case inverted
	out (c),a				; output the updated character

	ld (hl),a
	inc l
noserial:
	jr tryserial

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

more_mods:
	inc (hl)
	djnz more_mods

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
