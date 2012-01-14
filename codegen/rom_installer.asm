
	org #4000

	ld hl,welcome
	call printstr

	ld bc,#feff
	out (c),c				; turn off SPI, default to clock high

;	call wakeup
;	call dumpmanuf
;	call dumpjedec
;	call dumpserial

;	ld de,0
;	call dumpcontents

	ld de,#7c0
;	call dumpcontents
	ld de,#7d0
;	call dumpcontents

	;rst 0

	ld de,#7c0
	ld hl, romimage_start
	ld ix, romimage_length 
	call writebytes

	ld de,#7d0
	ld hl, altimage_start
	ld ix, altimage_length 
	call writebytes

	ld de,#7c0
	call dumpcontents
	ld de,#7d0
	call dumpcontents

;	call dumpstatusreg
;	call modifycontents
;	call dumpstatusreg
;	call dumpcontents
;	call dumpstatusreg
	
	ld hl,end_msg
	call printstr

	rst 0					; jump back to the bootloader

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
wakeup:
	ld hl,wakeupmsg
	call printstr

	out (c),b				; turn on flash rom CE

	inc b					; change to SPI data port
	ld hl,#ab
	out (c),l				; release from deep power down and read electronic signature
	out (c),h
	out (c),h
	out (c),h				; dummy bytes

	in a,(c)		;; KLUDGE

	in a,(c)				; read RES
	call printhex
	call dumpmore
	
	dec b
	out (c),c				; turn off flash rom
	ret
;;;
dumpstatusreg:
	ld hl,statusreg
	call printstr

	out (c),b				; turn on flash rom CE

	inc b					; change to SPI data port
	ld a,#05
	out (c),a				; RDSR

	in a,(c)		;; KLUDGE

	in a,(c)				; read status
	call printhex
	call dumpmore
	
	dec b
	out (c),c				; turn off flash rom
	ret
;;;
dumpmanuf:
	ld hl,manuf
	call printstr

	out (c),b				; turn on flash rom CE

	inc b					; change to SPI data port
	ld hl,#90
	out (c),l				; read manufacturer ID
	out (c),h
	out (c),h
	out (c),h				; from address 0

	in a,(c)		;; KLUDGE

	in a,(c)				; read manufacturer ID
	call printhex
	in a,(c)				; read device ID
	call printhex
	call dumpmore
	
	dec b
	out (c),c				; turn off flash rom
	ret
;;;
dumpjedec:
	ld hl,jedec_id
	call printstr

	out (c),b				; turn on flash rom CE
	inc b					; change to SPI data port
	ld a,#9f
	out (c),a				; read jedec ID

	in a,(c)		;; KLUDGE

	in a,(c)				; read manufacturer ID
	call printhex
	in a,(c)				; read memory type ID
	call printhex
	in a,(c)				; read memory capacity ID
	call printhex
	call dumpmore

	dec b
	out (c),c				; turn off flash rom
	ret
;;;
dumpserial:
	ld hl,serial_id
	call printstr

	out (c),b				; turn on flash rom CE
	inc b					; change to SPI data port
	ld hl,#4b
	out (c),l				; read serial ID
	out (c),h				; dummy 1
	out (c),h				; dummy 2
	out (c),h				; dummy 3
	out (c),h				; dummy 4

	in a,(c)		;; KLUDGE

	in a,(c)				; read SN #1
	call printhex
	in a,(c)				; read SN #2
	call printhex
	in a,(c)				; read SN #3
	call printhex
	in a,(c)				; read SN #4
	call printhex
	in a,(c)				; read SN #5
	call printhex
	in a,(c)				; read SN #6
	call printhex
	in a,(c)				; read SN #7
	call printhex
	in a,(c)				; read SN #8
	call printhex
	call dumpmore

	dec b
	out (c),c				; turn off flash rom
	ret
;;;

send_write_enable:
	out (c),b				; turn on flash rom CE
	inc b					; change to SPI data port
	ld a,#06
	out (c),a				; write enable
	dec b
	out (c),c				; turn off CE
	ret
;;;

send_erase_page:
	out (c),b				; turn on flash rom CE
	inc b					; change to SPI data port
	ld a,#20
	out (c),a				; sector erase
	out (c),d
	out (c),e
	xor a
	out (c),a				; send address
	dec b
	out (c),c				; turn off CE
	ret
;;;

wait_while_wip:
	push hl
	out (c),b				; turn on flash rom CE
	inc b					; change to SPI data port
	ld a,#5
	out (c),a				; read status
	in a,(c)		; KLUDGE
	ld l,0
wait_wip_loop:
	ld a,'.'
	call putch
wait_wip_loop_no_dot:
	in a,(c)				; read status
	rrca
	jr nc, finished_wip			; bit now 0, finished write operation
	inc l
	jr nz,wait_wip_loop_no_dot
	jr wait_wip_loop
finished_wip:
	dec b
	out (c),c				; turn off CE
	pop hl
	ret
;;;
; checks if page DE is empty, return A=0 if page all set to #FF

check_page_empty:
	out (c),b				; turn on flash rom CE
	inc b					; change to SPI data port

	ld a,#3
	out (c),a				; read data
	out (c),d
	ld a,e
	and #f0					; 4K sector alignment
	out (c),a
	xor a
	out (c),a				; send address

	in a,(c)		; KLUDGE

	ld hl,#1000				; amount to check
check_empty_loop:
	in a,(c)
	inc a
	jr nz,notempty				; bail if we found data other than #ff
	dec hl
	ld a,h
	or l
	jr nz,check_empty_loop			; loop through all bytes
notempty:
	dec b
	out (c),c				; turn off CE
	ret
;;;

erasepage:					; DE holds page (block of 256)
	ld hl,erase_msg
	call printstr

	ld a,d
	call printhex
	ld a,e
	call printhex
	ld a,0
	call printhex

	call check_page_empty
	or a
	jr nz,do_erase

	ld hl,page_already_empty_msg
	call printstr
	jr done_erase
do_erase:
	call send_write_enable
	call send_erase_page
	call wait_while_wip
done_erase:

	ret


;;;
;	ld de,#7d0
;	call erasepage
;	ld hl, altimage_start
;	ld ix, altimage_length 
;	call writebytes

writebytes:
	ld a,e
	and #f

	push de
	push hl
	push ix
	call z,erasepage
	pop ix
	pop hl
	pop de

	push hl
	ld hl,writing_page_msg
	call printstr
	ld a,d
	call printhex
	ld a,e
	call printhex
	ld a,0
	call printhex

	ld hl,writing_page_msg2
	call printstr
	pop hl
	push hl
	ld a,h
	call printhex
	ld a,l
	call printhex
	pop hl

	call send_write_enable

	out (c),b				; turn on flash rom CE
	inc b					; change to SPI data port


	ld a,#2
	out (c),a				; program page data
	out (c),d
	out (c),e
	xor a
	out (c),a				; send address

	ld iyl,0				; low byte of address (counter)
writebytesloop:
	ld a,(hl)
	inc hl
	out (c),a				; write byte of data
	
	dec ix
	ld a,ixh
	or ixl					; decrement count
	jr z,finished_bytes

	inc iyl
	jr nz,writebytesloop			; continue with all bytes in this page
finished_bytes:
	dec b
	out (c),c				; turn off CE

	call wait_while_wip

	ld a,ixh
	or ixl					; any more bytes to process?
	ret z

	inc de
	jr writebytes



;;;;;;;;;;;;;

;;;
dumpcontents:					; DE holds page (block of 256)
	ld hl,dump_msg
	call printstr

	out (c),b				; turn on flash rom CE
	inc b					; change to SPI data port
	ld hl,#03
	out (c),l				; READ data bytes
	out (c),d				; addr 1
	out (c),e				; addr 2
	out (c),h				; addr 3

	in a,(c)		;; KLUDGE

	ld l,h
	ld h,e
dumploop:
	ld iyh,128
dumploopmaybe:
	ld a,l
	and #f
	jr nz, noheader

	ld a,13
	call putch
	ld a,10
	call putch

	ld a,d
	call printhex
	ld a,h
	call printhex
	ld a,l
	call printhex

	ld a,':'
	call putch
	ld a,' '
	call putch
noheader:
	in a,(c)				; read char
	push af
	call printhex
	ld a,' '
	call putch
	inc hl
	jr nz,noincd
	inc d
noincd:
	pop af
	inc a					; was it #FF?
	jr nz, dumploop				; reset counter if not

	dec iyh
	jr nz,dumploopmaybe			; otherwise loop until it looks likely

	dec b
	out (c),c				; turn off flash rom
	ret
	ld hl,crlf
	jp printstr
;;;
modifycontents:
	ld hl,modify_msg
	call printstr

	out (c),b				; turn on flash rom CE
	inc b					; change to SPI data port

	ld de,#03
	ld hl,0
	out (c),e				; READ data bytes
	out (c),d				; addr 1
	out (c),h				; addr 2
	out (c),l				; addr 3

	in a,(c)		;; KLUDGE

modify_search:
	in a,(c)
	inc a
	jr z,found_space			; found a #FF

	inc hl
	ld a,h
	and #3f
	or l
	jr nz,modify_search			; look through whole 16K block

	ld hl,modify_failed
	call printstr
	jr turn_off_chip

found_space:
	ld a,h
	call printhex
	ld a,l
	call printhex

	dec b
	out (c),c
	out (c),b				; next command
	inc b

	ld e,#06
	out (c),e				; write enable

	dec b
	out (c),c
	out (c),b				; next command
	inc b

	ld e,#02
	out (c),e				; program page
	out (c),d
	out (c),h
	out (c),l				; address bytes

	ld a,13
	out (c),a				; data byte
	ld a,10
	out (c),a				; data byte

	ld a,h
	rra
	rra
	rra
	rra
	and #f					; upper nibble in A
	cp 10
	sbc a,#69
	daa					; A=hex character in ascii
	out (c),a				; data byte

	ld a,h
	and #f					; lower nibble in A
	cp 10
	sbc a,#69
	daa					; A=hex character in ascii
	out (c),a				; data byte

	ld a,l
	rra
	rra
	rra
	rra
	and #f					; upper nibble in A
	cp 10
	sbc a,#69
	daa					; A=hex character in ascii
	out (c),a				; data byte

	ld a,l
	and #f					; lower nibble in A
	cp 10
	sbc a,#69
	daa					; A=hex character in ascii
	out (c),a				; data byte

	ld a,'-'
	out (c),a
	ld a,'x'
	out (c),a

	dec b
	out (c),c
	out (c),b				; next command
	inc b

	ld e,#04
	out (c),e				; write disable

turn_off_chip:
	dec b
	out (c),c				; turn off flash rom
	ret
;;;
dumpmore:
	ret

	ld a,' '
	call putch
	ld a,'('
	call putch
	in a,(c)				; hmmm
	call printhex
	ld a,' '
	call putch
	in a,(c)				; hmmm
	call printhex
	ld a,' '
	call putch
	in a,(c)				; hmmm
	call printhex
	ld a,' '
	call putch
	in a,(c)				; hmmm
	call printhex
	ld a,' '
	call putch
	in a,(c)				; hmmm
	call printhex
	ld a,' '
	call putch
	in a,(c)				; hmmm
	call printhex
	ld a,' '
	call putch
	in a,(c)				; hmmm
	call printhex
	ld a,' '
	call putch
	in a,(c)				; hmmm
	call printhex
	ld a,' '
	call putch
	in a,(c)				; hmmm
	call printhex
	ld a,' '
	call putch
	in a,(c)				; hmmm
	call printhex
	ld a,' '
	call putch
	in a,(c)				; hmmm
	call printhex
	ld a,' '
	call putch
	in a,(c)				; hmmm
	call printhex
	ld a,' '
	call putch
	in a,(c)				; hmmm
	call printhex
	ld a,' '
	call putch
	in a,(c)				; hmmm
	call printhex
	ld a,' '
	call putch
	in a,(c)				; hmmm
	call printhex
	ld a,' '
	call putch
	in a,(c)				; hmmm
	call printhex
	ld a,')'
	jp putch
;;;

welcome:
	defb 13,10,"Boot flash installer v0.01, (c) 2012 Ranulf Doswell",13,10
	defb       "---------------------------------------------------",13,10
	defb 13,10,"Testing ROM chip...",0
wakeupmsg:
	defb 13,10,"Doing wakeup and read RES: ",0
manuf:
	defb 13,10,"Fetching REMS: ",0
jedec_id:
	defb 13,10,"Fetching JEDEC ID: ",0
serial_id:
	defb 13,10,"Serial number: ",0
erase_msg:
	defb 13,10,"Erasing page ",0
page_already_empty_msg:
	defb       " - skipped, page already empty",0
writing_page_msg:
	defb 13,10,"Writing page ",0
writing_page_msg2:
	defb " from data at ",0

modify_msg:
	defb 13,10,"Modifying some data... ",0
modify_failed:
	defb 13,10,"Couldn't find a #FF anywhere in first 16KB block!",0
statusreg:
	defb 13,10,"Status register: ",0
dump_msg:
	defb 13,10,"Current ROM contents:", 0
crlf:
	defb 13,10,0
end_msg:
	defb 13,10,"Resetting...",13,10,0

; print message in HL, BC=FADD, AF corrupted

printstr:
	ld a,(hl)
	or a
	ret z					; return at end of string
	call putch
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
	call putch
	pop af
	and #f					; lower nibble in A
	cp 10
	sbc a,#69
	daa					; A=hex character in ascii

; output char in A

putch:
	push bc
	ld bc,#fadd
putchloop:
	defb #ed,#70	;in f,(c)
	jp p,putchloop				; loop until tx uart idle
	dec c
	out (c),a
	pop bc
	ret











	ld hl,romimage_start
	ld de,#07c0				; upper 2 bytes of destination
	ld bc,romimage_length

romimage_start:
	incbin build/rom_c000.bin
romimage_length equ ($-romimage_start)



altimage_start:

	ld de,#4000
	ld hl,#d000+reloc_ofs
	ld bc,reloc_len
	push de
	ldir
	ret

reloc_ofs equ ($-altimage_start)
reloc_start:

        ; org #4000

; transfer 16K of data from #74000 on memory chip to #c000
; transfer 16K of data from #78000 on memory chip to #0000 and jump to it

	ld bc,#7f8d		; disable upper/lower ROM
	out (c),c

	ld bc,#bc0c
	out (c),c
	ld bc,#bd30
	out (c),c		; start screen at #c000

	ld hl,#c000		; fill the screen with garbage
	xor a
fill:	ld (hl),a
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

	ld hl,#4000+text_ofs
	ld bc,#fadd
xputchloop:
	in a,(c)
	rlca
	jr nc,xputchloop				; loop until tx uart idle
	ld a,(hl)
	inc hl
	or a
	jp z,0					; and reboot
	dec c
	out (c),a
	inc c
	jr xputchloop

;	jp 0			; and reset

text_ofs equ ($-reloc_start)
	defb 13,10,'Booting into BASIC...',13,10,0


reloc_len equ ($-reloc_start)



;	ld bc,#fadc
;	ld a,'.'
;	out (c),a
;
;	ld c,#de
;	out (c),e
;	inc e
;pause:
;	dec hl
;	ld a,h
;	or l
;	jr nz,pause
;	jr altimage_start

altimage_length equ ($-altimage_start)
