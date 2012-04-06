        org #4000

; transfer 16K of data from #70000 on memory chip to #c000 (rom 7)
; transfer 16K of data from #74000 on memory chip to #c000 (rom 0)
; transfer 16K of data from #78000 on memory chip to #0000 and jump to it

    di


	ld bc,#7f8d		; disable upper/lower ROM
	out (c),c


	ld de,#9000
	ld hl,bootcode
	ld bc,bootcode_len
	ldir


	jp #9000

bootcode:

	ld bc,#7f10
	out (c),c
	ld c,#40
	out (c),c
	exx

        ld bc,#feff
        out (c),c                               ; ensure SPI bus is idle

        out (c),b                               ; turn on flash rom CE
        inc b                                   ; change to SPI data port


	ld de,#11

	ld hl,#8003
	out (c),l				; READ data bytes
	out (c),d				; addr 1
	out (c),e				; addr 2
	out (c),h				; addr 3


        in a,(c)                ; dummy read

        ld hl,#170

spixferloop:
	in a,(c)
	ld (hl),a
	inc hl
;	ini
;	inc b

	xor a
	or l
	jr nz,spixferloop

	exx
	out (c),c
	inc c
	res 5,c
	exx

        ld a,l
	cp #86
        jr nz,spixferloop			; loop until we reach #0000

    jp #190


bootcode_len equ ($-bootcode)
