

	org #c000

	defb 1			; background
	defb 0,1,0		; version

	defw names

	jp entry
	jp do_srec_boot
	jp hello
	jp test

names:
	defb "TEST RO",'M'+#80
	defb "SRE",'C'+#80
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
	defb " Ralf's test rom 1.01.",13,10
	defb " Try |HELLO or |TEST",13,10
	defb " Use |SREC to load an SREC file",13,10,13,10,0

hello_msg:
	defb "Hello mate!",13,10,0

plustest_start:
	incbin plustest/plustest.bin
;	incbin plustest/plustest-ed4.bin
plustest_length equ ($-plustest_start)







;;;;;;;;;;;;; srec loader

do_srec_boot:

	ld bc,#fadd
	ld ixh,#80				; IXH = file error status

	ld hl,welcome_msg
	call printstr

	di
	exx
	push bc
	ld bc,#7f10
	out (c),c
	ld c,#5c
	out (c),c
	exx

mainloop:
	call getch
	cp 'S'
	jr z,is_s				; for first line
skipeol:
	cp 13
	jr z,maybe_s
	cp 10
	jr z,maybe_s
	call getch
	jr skipeol				; skip until CR/LF found
maybe_s:
	call getch
	cp 'S'
	jr nz,skipeol				; new line didn't start with an S, skip the rest
is_s:
	call getch				; get SREC type
	cp '0'
	jr z,srec_header
	cp '1'
	jr z,srec_data
	cp '5'
	jr z,srec_count
	cp '9'
	jp nz,mark_as_error			; not a valid SREC type

; handle an S9 record type

srec_exec:					; execution address
	call getlen_and_addr
	call endsrecline			; A=00 xsum OK

	exx
	pop bc
	exx

	push hl
	ld hl,exec_msg1
	call printstr
	pop hl
	push hl
	ld a,h
	call printhex
	ld a,l
	call printhex
	ld hl,exec_msg2
	call printstr
	ret

; handle an S5 record type

srec_count:
	call getlen_and_addr
	call endsrecline

	push ix
	pop de
	and a
	sbc hl,de				; check line counts
	jr z,mainloop_far			; all fine
	jr mark_as_error			; otherwise set message
	
; handle an S0 record type

srec_header:
	ld ix,0					; clear error flag/line count for file
	call getlen_and_addr
header_name:
	xor a
	or iyh					; check if len is 0
	jr z,header_end

	call gethex
	dec iyh

	dec c
	out (c),a				; output character
	;call &bb5a
	inc c
	jr header_name				; loop until end
header_end:
	call endsrecline			; A=00 xsum OK

	ld a,' '
printchar_jp_mainloop:
	dec c
	out (c),a				; output character
	;call &bb5a
	inc c

mainloop_far:
	jp mainloop

; handle an S1 record type

srec_data:
	ld a,ixh
	and #80
	jp nz,skipeol				; don't process data if previous error

	call getlen_and_addr
read_data:
	xor a
	or iyh					; check if at end of line
	jr z,data_end

	call gethex
	dec iyh

	ld (hl),a
	inc hl					; fetch byte
	jr read_data

data_end:
	call endsrecline			; verify xsum
	inc ix					; increase line count

	ld a,2
	exx
	xor c
	ld c,a
	out (c),c
	exx					; flash border

	ld a,'.'
	jr printchar_jp_mainloop 		; show progress

; checks the checksum byte at the end, aborts if wrong

endsrecline:
	call gethex				; dummy read xsum byte
	ld a,ixh
	and #80
	jr nz,mainloop_far			; already error previously in file
	ld a,iyl				; check xsum
	inc a					; 00 if OK
	or iyh					; add in if data left
	ret z

; abort function call and return to mainloop

mark_as_error:
	pop hl
	ld a,ixh
	and #80
	jr nz,mainloop_far			; error flag already set, don't print message again

	ld ixh,#80				; set error flag over file
	ld hl,error_msg
	call printstr
	jr mainloop_far				; error, display msg and restart

; reads the length of the record (data only, not addr/xsum) in IXL and the address part in HL

getlen_and_addr:
	ld iyl,0				; IYL=xsum per line reset
	call gethex
	sub 3
	ld iyh,a				; iyh = remaining bytes this line
	jr c,mark_as_error
	call gethex
	ld h,a
	call gethex
	ld l,a
	ret


; print message in HL, BC=FADD, AF corrupted

printstr:
	in a,(c)
	rla
	jr nc,printstr				; loop until tx uart idle
	ld a,(hl)
	or a
	ret z					; return at end of string
	dec c
	out (c),a				; output character
	call &bb5a
	inc c
	inc hl
	jr printstr

; output hex digit in A, BC=FADD

printhex:
	push af
	rra
	rra
	rra
	rra
	and #f					; upper nibble in A
	cp 10
	sbc a,#69
	daa					; A=hex character in ascii
printhexloop1:
	defb #ed,#70	;in f,(c)
	jp p,printhexloop1			; wait until port idle
	dec c
	out (c),a				; output character
	call &bb5a
	inc c
	
	pop af
	and #f					; lower nibble in A
	cp 10
	sbc a,#69
	daa					; A=hex character in ascii
printhexloop2:
	defb #ed,#70	;in f,(c)
	jp p,printhexloop2			; wait until port idle
	dec c
	out (c),a				; output character
	call &bb5a
	inc c
	ret

; getchar in A, BC=FADD

getch:
	in a,(c)
	and #40
	jr z,getch				; wait until port has data
	dec c
	in a,(c)				; input character
	inc c
	ret

; gethex in A, BC=FADD, DE trashed

gethex:
gethex1:
	in a,(c)
	and #40
	jr z,gethex1				; wait until port has data
	dec c
	in a,(c)				; input character
	inc c

	ld d,a
	add a,#c0
	sbc a,a
	and #9
	add a,d
	and #f
	rla
	rla
	rla
	rla
	ld e,a
gethex2:
	in a,(c)
	and #40
	jr z,gethex2				; wait until port has data
	dec c
	in a,(c)				; input character
	inc c

	ld d,a
	add a,#c0
	sbc a,a
	and #9
	add a,d
	and #f
	or e

	ld e,a
	add a,iyl
	ld iyl,a
	ld a,e					; add xsum to iyl
	ret


welcome_msg:
	defb 13,10,"SREC loader v0.05 ",164," 2012 Ranulf Doswell",13,10
	defb       "---------------------------------------",13,10
	defb 13,10,"Start SREC transfer...",13,10
exec_msg2:
	defb 13,10,0
exec_msg1:
	defb 13,10,"Jumping to ",0
error_msg:
	defb 13,10,"ERROR in SREC data, please restart SREC transfer...",13,10,0

	defb '****'
progend:

