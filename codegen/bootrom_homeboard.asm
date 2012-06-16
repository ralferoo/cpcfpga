
	org #0000

	di

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

;	ld de,#1042
;	out (c),d
;;	out (c),e			; border

	
	ld hl,0
	ld de,#c000
	ld bc,16384
	ldir

qqq:
	ld a,l
	and #1f
	or #40
	ld bc,#7f10
	out (c),c
	out (c),a
	inc l
;	jr qqq

	ld e,#12

bloop:
	ld hl,#c004
	inc e
aloop:

	ld a,h
	rra
	rra
	rra
	ld bc,#fade
	out (c),a

	ld a,l
	and #1f
	or #40
	ld bc,#7f10
	out (c),c
	out (c),a

	ld (hl),e
	inc hl

	ld a,l
	or a
	jr nz, aloop
	ld l,4
	or h
	jr nz, aloop
	ld h,#c0

	ld ix,numbers
	ld a,e
	and #f0
	ld c,a
	ld b,0
	add ix,bc

	ld a,(ix+0)
	ld (#c000),a
	ld a,(ix+1)
	ld (#c001),a

	ld a,(ix+2)
	ld (#c800),a
	ld a,(ix+3)
	ld (#c801),a

	ld a,(ix+4)
	ld (#d000),a
	ld a,(ix+5)
	ld (#d001),a

	ld a,(ix+6)
	ld (#d800),a
	ld a,(ix+7)
	ld (#d801),a

	ld a,(ix+8)
	ld (#e000),a
	ld a,(ix+9)
	ld (#e001),a

	ld a,(ix+10)
	ld (#e800),a
	ld a,(ix+11)
	ld (#e801),a

	ld a,(ix+12)
	ld (#f000),a
	ld a,(ix+13)
	ld (#f001),a

	ld a,(ix+14)
	ld (#f800),a
	ld a,(ix+15)
	ld (#f801),a

	ld ix,numbers
	ld a,e
	add a,a
	add a,a
	add a,a
	add a,a
	and #f0
	ld c,a
	ld b,0
	add ix,bc

	ld a,(ix+0)
	ld (#c002),a
	ld a,(ix+1)
	ld (#c003),a

	ld a,(ix+2)
	ld (#c802),a
	ld a,(ix+3)
	ld (#c803),a

	ld a,(ix+4)
	ld (#d002),a
	ld a,(ix+5)
	ld (#d003),a

	ld a,(ix+6)
	ld (#d802),a
	ld a,(ix+7)
	ld (#d803),a

	ld a,(ix+8)
	ld (#e002),a
	ld a,(ix+9)
	ld (#e003),a

	ld a,(ix+10)
	ld (#e802),a
	ld a,(ix+11)
	ld (#e803),a

	ld a,(ix+12)
	ld (#f002),a
	ld a,(ix+13)
	ld (#f003),a

	ld a,(ix+14)
	ld (#f802),a
	ld a,(ix+15)
	ld (#f803),a

	jp bloop

;	nop

	inc hl


numbers:
	defb %0111,%1100		; 0
	defb %1100,%0110
	defb %1100,%1110
	defb %1101,%0110
	defb %1110,%0110
	defb %1100,%0110
	defb %0111,%1100
	defb %0000,%0000

	defb %0001,%1000		; 1
	defb %0011,%1000
	defb %0001,%1000
	defb %0001,%1000
	defb %0001,%1000
	defb %0001,%1000
	defb %0111,%1110
	defb %0000,%0000

	defb %0011,%1100		; 2
	defb %0110,%0110
	defb %0000,%0110
	defb %0011,%1100
	defb %0110,%0000
	defb %0110,%0110
	defb %0111,%1110
	defb %0000,%0000

	defb %0011,%1100		; 3
	defb %0110,%0110
	defb %0000,%0110
	defb %0001,%1100
	defb %0000,%0110
	defb %0110,%0110
	defb %0011,%1100
	defb %0000,%0000

	defb %0001,%1100		; 4
	defb %0011,%1100
	defb %0110,%1100
	defb %1100,%1100
	defb %1111,%1110
	defb %0000,%1100
	defb %0001,%1110
	defb %0000,%0000

	defb %0111,%1110		; 5
	defb %0110,%0010
	defb %0110,%0000
	defb %0111,%1100
	defb %0000,%0110
	defb %0110,%0110
	defb %0011,%1100
	defb %0000,%0000

	defb %0011,%1100		; 6
	defb %0110,%0110
	defb %0110,%0000
	defb %0111,%1100
	defb %0110,%0110
	defb %0110,%0110
	defb %0011,%1100
	defb %0000,%0000

	defb %0111,%1110		; 7
	defb %0100,%0110
	defb %0000,%0110
	defb %0000,%1100
	defb %0001,%1000
	defb %0001,%1000
	defb %0001,%1000
	defb %0000,%0000

	defb %0011,%1100		; 8
	defb %0110,%0110
	defb %0110,%0110
	defb %0011,%1100
	defb %0110,%0110
	defb %0110,%0110
	defb %0011,%1100
	defb %0000,%0000

	defb %0011,%1100		; 9
	defb %0110,%0110
	defb %0110,%0110
	defb %0011,%1110
	defb %0000,%0110
	defb %0110,%0110
	defb %0011,%1100
	defb %0000,%0000

	defb %0001,%1000		; a
	defb %0011,%1100
	defb %0110,%0110
	defb %0110,%0110
	defb %0111,%1110
	defb %0110,%0110
	defb %0110,%0110
	defb %0000,%0000

	defb %1111,%1100		; b
	defb %0110,%0110
	defb %0110,%0110
	defb %0111,%1100
	defb %0110,%0110
	defb %0110,%0110
	defb %1111,%1100
	defb %0000,%0000

	defb %0011,%1100		; c
	defb %0110,%0110
	defb %1100,%0000
	defb %1100,%0000
	defb %1100,%0000
	defb %0110,%0110
	defb %0011,%1100
	defb %0000,%0000

	defb %1111,%1000		; d
	defb %0110,%1100
	defb %0110,%0110
	defb %0110,%0110
	defb %0110,%0110
	defb %0110,%1100
	defb %1111,%1000
	defb %0000,%0000

	defb %1111,%1110		; e
	defb %0110,%0010
	defb %0110,%1000
	defb %0111,%1000
	defb %0110,%1000
	defb %0110,%0010
	defb %1111,%1110
	defb %0000,%0000

	defb %1111,%1110		; f
	defb %0110,%0010
	defb %0110,%1000
	defb %0111,%1000
	defb %0110,%1000
	defb %0110,%0000
	defb %1111,%0000
	defb %0000,%0000

	end


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

	ld de,#1042
	out (c),d
	out (c),e			; border

	ld hl,#c010
	ld a,0
qqq:
	inc de
	ld a,d
	and #3f
	or #40
	ld d,a
	out (c),d

	ld (hl),d
	inc hl
	jr qqq

;	ld bc,#fade
;	out (c),e
;	ld a,h
;	or l
;	jr nz, qqq
;	inc e

	ld (hl),h



	ld e,0
	ld hl,#c000
gloop:
	ld (hl),e
	inc hl

	ld a,l
	or h
	jr nz,gloop
	
	inc e
	ld h,#c0
	jr gloop


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
