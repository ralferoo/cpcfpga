
	org #4000


	ld hl,welcome
	call printstr

	ld bc,#feff
	out (c),c				; turn off SPI, default to clock high

	call wakeup
	call dumpmanuf
	call dumpjedec
	call dumpserial
	call dumpcontents
	call dumpstatusreg
	call modifycontents
	call dumpstatusreg
	call dumpcontents
	call dumpstatusreg
	
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
	inc h
	out (c),h				; from address 0

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
dumpcontents:
	ld hl,dump_msg
	call printstr

	out (c),b				; turn on flash rom CE
	inc b					; change to SPI data port
	ld hl,#03
	out (c),l				; READ data bytes
	out (c),h				; addr 1
	out (c),h				; addr 2
	out (c),h				; addr 3

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

	ld a,'*'
	out (c),a				; data byte
	out (c),a				; data byte
	out (c),a				; data byte

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
	in a,(c)				; hmmm
	call printhex
	in a,(c)				; hmmm
	call printhex
	in a,(c)				; hmmm
	call printhex
	in a,(c)				; hmmm
	call printhex
	in a,(c)				; hmmm
	call printhex
	in a,(c)				; hmmm
	call printhex
	in a,(c)				; hmmm
	call printhex
	in a,(c)				; hmmm
	call printhex
	in a,(c)				; hmmm
	call printhex
	in a,(c)				; hmmm
	call printhex
	in a,(c)				; hmmm
	call printhex
	in a,(c)				; hmmm
	call printhex
	in a,(c)				; hmmm
	call printhex
	in a,(c)				; hmmm
	call printhex
	in a,(c)				; hmmm
	call printhex
	in a,(c)				; hmmm
	jp printhex
;;;

welcome:
	defb 13,10,"Testing ROM chip...",13,10,0
wakeupmsg:
	defb 13,10,"Doing wakeup and read RES: ",0
manuf:
	defb 13,10,"Fetching REMS: ",0
jedec_id:
	defb 13,10,"Fetching JEDEC ID: ",0
serial_id:
	defb 13,10,"Serial number: ",0
modify_msg:
	defb 13,10,"Modifying some data... ",0
modify_failed:
	defb 13,10,"Couldn't find a #FF anywhere in first 16KB block!",0
statusreg:
	defb 13,10,"Status register: ",0
dump_msg:
	defb 13,10,"Current ROM contents:"
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
