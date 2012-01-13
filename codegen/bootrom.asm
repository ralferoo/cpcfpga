
	org #0000

; BC=FADD throughout
; IXH = errors over file
; IXL = lines within file
; IYH = length left in srec data this line
; IYL = xsum within line

	di

	ld sp,#bffe				; stack outside potential rom area
	ld bc,#7f8d				; disable upper/lower ROM
	out (c),c

        ld bc,#fade
        in a,(c)
        dec bc                                  ; BC=FADD

        and #01
        jp z,boot_basic

	ld bc,#fadd				; serial port address
	ld ixh,#80				; IXH = file error status

	ld hl,welcome_msg
	call printstr

mainloop:
	call getch
skipeol:
	cp 'S'
	jr z,is_s				; for first line
;skipeol:
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
	jr nz,mark_as_error			; not a valid SREC type

; handle an S9 record type

srec_exec:					; execution address
	call getlen_and_addr
	call endsrecline			; A=00 xsum OK

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
	inc c
	jr header_name				; loop until end
header_end:
	call endsrecline			; A=00 xsum OK

	ld a,' '
printchar_jp_mainloop:
	dec c
	out (c),a				; output character
	inc c

mainloop_far:
	jr mainloop

; handle an S1 record type

srec_data:
	ld a,ixh
	and #80
	jr nz,skipeol				; don't process data if previous error

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
	ld a,'.'
	jr printchar_jp_mainloop 		; show progress

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
	defb 13,10,"SREC loader v0.02b, (c) 2012 Ranulf Doswell",13,10
exec_msg2:
	defb 13,10,0
exec_msg1:
	defb 13,10,"Jumping to ",0
error_msg:
	defb 13,10,"ERROR",13,10,0
progend:





boot_basic:				; move out of way of ROM and boot basic

	ld de,#4000
	ld hl,basicprog
	ld bc,basic_prog_len
	push de
	ldir
	ret

basicprog:

; transfer 16K of data from #74000 on memory chip to #c000
; transfer 16K of data from #78000 on memory chip to #0000 and jump to it

	ld bc,#bc0c
	out (c),c
	ld bc,#bd30
	out (c),c		; start screen at #c000

	ld hl,#c000		; fill the screen with garbage
	ld b,#5a
	xor a
fill:	ld (hl),b
	inc hl
	cp h
	jr nz,fill


	ld bc,#7f81		; enable upper/lower ROM
	out (c),c

	ld bc,#fefe
	ld a,#c0
	out (c),a		; make ROM writeable...	 ;)

        ld de,#0307                             ; D=READ
        ld hl,#4000                             ; EHL = transfer address

        ld bc,#feff
        out (c),c                               ; ensure SPI bus is idle

        out (c),b                               ; turn on flash rom CE
        inc b                                   ; change to SPI data port
        out (c),d                               ; READ data bytes
        out (c),e                               ; addr 1
        out (c),h                               ; addr 2
        out (c),l                               ; addr 3

        in a,(c)                ; dummy read

						; read in the lower rom
	ld a,#40				; end address (hi byte)
	ld h,#c0				; start address (low byte)
xferloop:
	ini
	inc b
        cp h
        jr nz,xferloop				; loop until we reach #4000

        dec b
        out (c),c                               ; finish with SPI bus

	ld bc,#fefe
	xor a
	out (c),a		; protect ROM from writes...	 ;)

	rst 0			; and reset
basic_prog_len equ ($-basicprog)

