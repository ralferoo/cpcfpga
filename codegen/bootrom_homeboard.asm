
	org #0000

	di
	ld sp,#bfff

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	ld bc,#feff
	out (c),c			; turn off flash, clock high

	out (c),b			; turn on flash
	inc b
	ld hl,#90
	out (c),l
	out (c),h
	out (c),h
	out (c),h			; read manufacturer
	in a,(c)

	ld hl,#c006
	in a,(c)
	call hex2digits
	inc hl
	inc hl
	inc hl
	inc hl
	in a,(c)
	call hex2digits

	dec b
	out (c),c			; turn off flash

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	ld bc,#feff
	out (c),c			; turn off flash, clock high

	out (c),b			; turn on flash
	inc b
	ld a,#9f
	out (c),a			; read jedec
	in a,(c)

	ld hl,#c010
	in a,(c)
	call hex2digits
	inc hl
	inc hl
	inc hl
	inc hl
	in a,(c)
	call hex2digits
	inc hl
	inc hl
	inc hl
	inc hl
	in a,(c)
	call hex2digits

	dec b
	out (c),c			; turn off flash

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	ld bc,#feff
	out (c),c			; turn off flash, clock high

	out (c),b			; turn on flash
	inc b
	ld hl,#4b
	out (c),l
	out (c),h
	out (c),h
	out (c),h			; read serial number
	in a,(c)

	ld hl,#c01e
	in a,(c)
	call hex2digits
	inc hl
	inc hl
	inc hl
	inc hl
	in a,(c)
	call hex2digits
	inc hl
	inc hl
	inc hl
	inc hl
	in a,(c)
	call hex2digits
	inc hl
	inc hl
	inc hl
	inc hl
	in a,(c)
	call hex2digits
	inc hl
	inc hl
	inc hl
	inc hl
	in a,(c)
	call hex2digits
	inc hl
	inc hl
	inc hl
	inc hl
	in a,(c)
	call hex2digits
	inc hl
	inc hl
	inc hl
	inc hl
	in a,(c)
	call hex2digits
	inc hl
	inc hl
	inc hl
	inc hl
	in a,(c)
	call hex2digits

	dec b
	out (c),c			; turn off flash

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	ld e,0

bloop:
	ld hl,#c050
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
	ld a,h
	and 7
	jr nz, aloop
	ld l,80
	or h
	jr nz, aloop
	ld h,#c0

	ld a,e
	ld hl,#c000
	call hex2digits

	ld a,0

	jr bloop

hex2digits:
	push af
	inc hl
	inc hl
	add a,a
	add a,a
	add a,a
	add a,a
	call hexdigit
	dec hl
	dec hl
	pop af

hexdigit:			; a[7:4] -> screen (hl)
	push af
	push hl
	push ix
	push bc

	ld ix,numbers
	and #f0
	ld c,a
	ld b,0
	add ix,bc

	ld a,(ix+0)
	ld (hl),a
	ld a,(ix+1)
	inc hl
	ld (hl),a
	dec hl

	set 3,h			;0800

	ld a,(ix+2)
	ld (hl),a
	ld a,(ix+3)
	inc hl
	ld (hl),a
	dec hl

	set 4,h			;1800

	ld a,(ix+6)
	ld (hl),a
	ld a,(ix+7)
	inc hl
	ld (hl),a
	dec hl

	res 3,h			;1000

	ld a,(ix+4)
	ld (hl),a
	ld a,(ix+5)
	inc hl
	ld (hl),a
	dec hl

	set 5,h			;3000

	ld a,(ix+12)
	ld (hl),a
	ld a,(ix+13)
	inc hl
	ld (hl),a
	dec hl

	set 3,h			;3800

	ld a,(ix+14)
	ld (hl),a
	ld a,(ix+15)
	inc hl
	ld (hl),a
	dec hl

	res 4,h			;2800

	ld a,(ix+10)
	ld (hl),a
	ld a,(ix+11)
	inc hl
	ld (hl),a
	dec hl

	res 3,h			;2000

	ld a,(ix+8)
	ld (hl),a
	ld a,(ix+9)
	inc hl
	ld (hl),a
	dec hl

	pop bc
	pop ix
	pop hl
	pop af
	ret

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
