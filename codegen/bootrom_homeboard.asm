
	org #0000

	ld bc,#fab6
	ld a,#7f
	out (c),a			; disable upper rom, 
	
; BC=FADD throughout
; IXH = errors over file
; IXL = lines within file
; IYH = length left in srec data this line
; IYL = xsum within line

	ld bc,#bc00
	out (c),c
	ld bc,#bd3f
	out (c),c

	ld bc,#bc01
	out (c),c
	ld bc,#bd28
	out (c),c

	ld bc,#bc02
	out (c),c
	ld bc,#bd2e
	out (c),c

	ld bc,#bc03
	out (c),c
	ld bc,#bd8e
	out (c),c

	ld bc,#bc04
	out (c),c
	ld bc,#bd26
	out (c),c

	ld bc,#bc05
	out (c),c
	ld bc,#bd00
	out (c),c

	ld bc,#bc06
	out (c),c
	ld bc,#bd19
	out (c),c

	ld bc,#bc07
	out (c),c
	ld bc,#bd1e
	out (c),c

	ld bc,#bc08
	out (c),c
	ld bc,#bd00
	out (c),c

	ld bc,#bc09
	out (c),c
	ld bc,#bd07
	out (c),c

	ld bc,#bc0a
	out (c),c
	ld bc,#bd00
	out (c),c

	ld bc,#bc0b
	out (c),c
	ld bc,#bd00
	out (c),c

	ld bc,#bc0c
	out (c),c
	ld bc,#bd30
	out (c),c

	ld bc,#bc0d
	out (c),c
	ld bc,#bd00
	out (c),c


	ld bc,#7f81
	out (c),c			; mode 1

	ld de,#0044
	out (c),d
	out (c),e			; ink 0

	ld de,#014a
	out (c),d
	out (c),e			; ink 1

	ld de,#0253
	out (c),d
	out (c),e			; ink 2

	ld de,#034c
	out (c),d
	out (c),e			; ink 3


	ld hl,#c000
	ld e,0
	exx

	ld hl,#c000
floop:
	ld bc,#fade
	out (c),e

	ld a,e
	add a,l
	add a,h

	ld c,d
	ld a,e

	rr c
	rra
	rr c
	rra
	rr c
	rra


	ld (hl),a
	inc hl
	ld a,h
	or l
	jr nz,floop

	ld h,#c0
	inc de
	jr floop

	dec c
	dec c
	out (c),d

	exx
	ld (hl),e
	inc hl
	inc e
	ld a,h
	or l
	jr nz,resetscr

	ld hl,#c000
	inc e
resetscr:
	exx 


	ld hl,200 ;50000/256
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
