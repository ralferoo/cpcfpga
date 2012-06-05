
	org #0000

; BC=FADD throughout
; IXH = errors over file
; IXL = lines within file
; IYH = length left in srec data this line
; IYL = xsum within line

	ld bc,#fade
floop:
	out (c),d
	inc d

	ld hl,50000
delayloop:
	dec hl
	ld a,h
	or l
	jr nz,delayloop
	
	jr floop

        ld de,#0307                             ; D=READ
        ld hl,#c000                             ; EHL = transfer address

	ld bc,#feff
        out (c),b                               ; turn on flash rom CE
        inc b                                   ; change to SPI data port (FFFF)
        out (c),d                               ; READ data bytes
        out (c),e                               ; addr 1
        out (c),h                               ; addr 2
        out (c),l                               ; addr 3

	xor a 	; ld a,0 			; end address (hi byte)

        dec hl  ;       in a,(c)                ; dummy read
xferloop:
	ini
	inc b
        cp h
        jr nz,xferloop				; loop until we reach #0000

	jp #c000

	end
