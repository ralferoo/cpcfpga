        org #4000

; transfer 16K of data from #74000 on memory chip to #c000
; transfer 16K of data from #78000 on memory chip to #0000 and jump to it

	ld bc,#7f8d		; disable upper/lower ROM
	out (c),c

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

	jp 0			; and reset

