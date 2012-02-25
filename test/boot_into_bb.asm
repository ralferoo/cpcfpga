        org #4000

; transfer 16K of data from #70000 on memory chip to #c000 (rom 7)
; transfer 16K of data from #74000 on memory chip to #c000 (rom 0)
; transfer 16K of data from #78000 on memory chip to #0000 and jump to it

    di

	ld de,#100
	ld hl,bootcode
	ld bc,bootcode_len
	ldir
	jp #100

bootcode:

	ld bc,#7f8d		; disable upper/lower ROM
	out (c),c

        ld de,#0300                             ; D=READ
        ld hl,#11                               ; HL = start page

        ld bc,#feff
        out (c),c                               ; ensure SPI bus is idle

        out (c),b                               ; turn on flash rom CE
        inc b                                   ; change to SPI data port
        out (c),d                               ; READ data bytes
        out (c),h                               ; page high
        out (c),l                               ; page low
        out (c),e                               ; zero offset

        in a,(c)                ; dummy read

        ld hl,#170
        ld a,#85                ; end at #8500 (#170+#82f4=#8464)

spixferloop:
	ini
	inc b
        cp h
        jr nz,spixferloop			; loop until we reach #0000

    jp #190


bootcode_len equ ($-bootcode)
