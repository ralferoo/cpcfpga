
	org #0000

; BC=FADD throughout
; IXH = errors over file
; IXL = lines within file
; IYH = length left in srec data this line
; IYL = xsum within line

;	di

;	ld sp,#bffe				; stack outside potential rom area

	ld bc,#fefe
	ld a,#e0
	out (c),a				; keep bootrom active, make ROM writeable

        ld de,#0307                             ; D=READ
        ld hl,#c000                             ; EHL = transfer address

;	push hl

        inc c		;ld bc,#feff
        out (c),c                               ; ensure SPI bus is idle

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

        dec b					; FEFF
        out (c),c                               ; finish with SPI bus

	jp #c000

;	ret

	end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	ld de,#ed0d
	push de
	ld de,#c979
	push de					; dec c ; out (c),a ; ret
	add hl,sp
	ld de,#c000
	push de
	jp (hl)		

	end

	dec c					; FEFE
	out (c),a				; A=00, turn off bootrom and write-protect ROM
	ret					; jmp #c000

