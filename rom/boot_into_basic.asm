        org #4000

        ; org #4000

; transfer 16K of data from #70000 on memory chip to #c000 (rom 7)
; transfer 16K of data from #74000 on memory chip to #c000 (rom 0)
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

	ld bc,#fab5
	ld a,#c0
	out (c),a		; enabled AMSDOS rom + SPIDOS rom

	ld bc,#fab6
	ld a,#c0
	out (c),a		; make ROMs writeable...	 ;)

	ld bc,#df06
	out (c),c		; select SPIDOS rom

        ld de,#0306                             ; D=READ
        ld hl,#c000                             ; EHL = transfer address

        ld bc,#feff
        out (c),c                               ; ensure SPI bus is idle

        out (c),b                               ; turn on flash rom CE
        inc b                                   ; change to SPI data port
        out (c),d                               ; READ data bytes
        out (c),e                               ; addr 1
        out (c),h                               ; addr 2
        out (c),l                               ; addr 3

        in a,(c)                ; dummy read

						; read in the spidos rom
	ld a,#00				; end address (hi byte)
spixferloop:
	ini
	inc b
        cp h
        jr nz,spixferloop			; loop until we reach #0000

	ld bc,#df07
	out (c),c		; select AMSDOS rom

	ld bc,#ffff				; restore xfer reg

	ld h,#c0				; start address (low byte)
amsxferloop:
	ini
	inc b
        cp h
        jr nz,amsxferloop			; loop until we reach #0000

	ld bc,#df00
	out (c),c				; select BASIC rom

	ld bc,#ffff				; restore xfer reg

						; read in the basic and lower rom
	ld a,#40				; end address (hi byte)
	ld h,#c0				; start address (low byte)
xferloop:
	ini
	inc b
        cp h
        jr nz,xferloop				; loop until we reach #4000

        dec b
        out (c),c                               ; finish with SPI bus

	ld bc,#fab6
	xor a
	out (c),a		; protect ROM from writes...	 ;)

	ld hl,text_ofs
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

text_ofs:
	defb 13,10,'Booting into BASIC...',13,10,0

