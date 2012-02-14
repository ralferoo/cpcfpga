

saved_cas_vectors	equ 0
long_jump_vector	equ (saved_cas_vectors+13*3)
existing_tape_in	equ (long_jump_vector+3)
existing_tape_out	equ (existing_tape_in+4)
data_area_size		equ (existing_tape_out+4)

	org #c000

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	defb 1			; background
	defb 0,1,0		; version

	defw names

	jp spi_dos_entry
	jp set_spi_vectors_all
	jp set_spi_vectors_in
	jp set_spi_vectors_out
	jp set_cas_vectors_all
	jp set_cas_vectors_in
	jp set_cas_vectors_out

names:
	defb 'SPI DO','S'+#80
	defb 'SP','I'+#80
	defb 'SPI.I','N'+#80
	defb 'SPI.OU','T'+#80
cmd_tape:
	defb 'TAP','E'+#80
cmd_tape_in:
	defb 'TAPE.I','N'+#80
cmd_tape_out:
	defb 'TAPE.OU','T'+#80
	defb 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

spi_dos_entry:
	push iy					; can't corrupt IY

	push de					; save lowest byte
	ld de,-data_area_size
	add hl,de
	push hl					; save updated highest byte

	inc hl
	push hl
	pop iy					; IY = our data area

	call setup_data_area

	ld hl, spi_dos_welcome_text
	call print

	pop hl
	pop de					; restore highest and lowest byte markers

	pop iy					; restore IY

	scf
	ret					; successful initialisation

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

print:
	ld a,(hl)
	inc hl
	or a
	ret z
	call #bb5a
	jr print

spi_dos_welcome_text:
	defb ' SPIDOS 1.0         (use |SPI or |TAPE)',13,10,0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

setup_data_area:
	ld hl,#bc77				; copy the tape vectors to a safe place
	ld de,saved_cas_vectors
	call add_iy_to_de
	ld bc,13*3
	ldir

	ld de,jump_vector
	ld (iy+long_jump_vector+0),e
	ld (iy+long_jump_vector+1),d
	call #b912				; KL_CURR_SELECTION
	ld (iy+long_jump_vector+2),a

;	ld hl,cmd_tape
;	call kl_find_command
;	ld (iy+existing_tape+0),l
;	ld (iy+existing_tape+1),h
;	ld (iy+existing_tape+2),c

	ld hl,cmd_tape_in
	call kl_find_command
	ld (iy+existing_tape_in+0),l
	ld (iy+existing_tape_in+1),h
	ld (iy+existing_tape_in+2),c
	ld (iy+existing_tape_in+3),a

	ld hl,cmd_tape_out
	call kl_find_command
	ld (iy+existing_tape_out+0),l
	ld (iy+existing_tape_out+1),h
	ld (iy+existing_tape_out+2),c
	ld (iy+existing_tape_out+3),a
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

kl_find_command:				; copies the command into RAM before passing to real KL_FIND_COMMAND
	push ix

	ld ix,0
	add ix,sp				; IX=stack pointer before string copy

	push hl
find_command_len:
	ld a,(hl)
	inc hl
	rla
	jr nc,find_command_len			; find end of string
	pop de
	and a
	sbc hl,de				; HL=length of string, DE=string

	ld b,l
	inc b
	srl b					; B=number of words in string

	adc hl,de				; HL=end of string again, and plus 1 if string length odd
find_command_copy:
	ld d,(hl)
	dec hl
	ld e,(hl)
	dec hl
	push de
	djnz find_command_copy			; copy all bytes in string onto the stack

	ld hl,0
	add hl,sp				; HL=copied string
	call #bcd4				; KL_FIND_COMMAND
	sbc a,a					; A=FF if found, 00 if not. carry left as is
	
	ld sp,ix				; skip back past string
	pop ix					; restore IX
	ret
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

jump_vector:
	di
	ex af,af'
	exx
	ld a,c

	pop de
	pop bc
	pop hl
	ex (sp),hl				; HL = return address after far call (RST 5)
	push bc
	push de					; shift remaining 3 items up stack

	ld c,a
	ld b,#74				; restore BC' manually

	ld de,spi_jump_table-#bc77-3		; HL=vector+3
	add hl,de				; HL=correct vector
	push hl

	exx
	ex af,af'
	ei
	ret

spi_jump_table:
	jp	spi_cas_in_open
	jp	spi_cas_in_close
	jp	spi_cas_in_abandon
	jp	spi_cas_in_char
	jp	spi_cas_in_direct
	jp	spi_cas_return
	jp	spi_cas_test_eof
	jp	spi_cas_out_open
	jp	spi_cas_out_abandon
	jp	spi_cas_out_char
	jp	spi_cas_out_direct
	jp	spi_cas_catalog

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

set_spi_vectors_all:
	call set_spi_vectors_out
	ret nc
set_spi_vectors_in:
	ld hl,#bc77
	ld b,7
	call set_spi_vectors		; set input related vectors
	ret nc

	ld hl,#bc9b
	inc b
	jr set_spi_vectors		; set cas catalog

set_spi_vectors_out:
	ld hl,#bc8c
	ld b,5				; set output related vectors

set_spi_vectors:
	or a
	jr nz, invalid_command

	ld de,long_jump_vector
	call add_iy_to_de

set_spi_vectors_loop:
	ld (hl),#df			; rst 5 = KL_FAR_CALL
	inc hl
	ld (hl),e
	inc hl
	ld (hl),d
	inc hl				; address of far call vector
	djnz set_spi_vectors_loop
	scf
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

set_cas_vectors_all:
	call set_cas_vectors_out
	ret nc
set_cas_vectors_in:
	or a
	jr nz, invalid_command

	ld l,(iy+existing_tape_in+0)
	ld h,(iy+existing_tape_in+1)
	ld c,(iy+existing_tape_in+2)
	ld a,(iy+existing_tape_in+3)	; FF if exists
	inc a
	jp z,#1b			; delegate to amsdos call

	ld hl,saved_cas_vectors
	ld de,#bc77		
	call add_iy_to_hl
	ld bc,7*3
	ldir				; restore input related vectors

	ld hl,saved_cas_vectors+#bc9b-#bc77
	ld de,#bc9b
	call add_iy_to_hl
	ld bc,3
	ldir				; restore cas catalog

	rra				; A=0, carry set (A was 1)
	ret

set_cas_vectors_out:
	or a
	jr nz, invalid_command

	ld l,(iy+existing_tape_out+0)
	ld h,(iy+existing_tape_out+1)
	ld c,(iy+existing_tape_out+2)
	ld a,(iy+existing_tape_out+3)	; FF if exists
	inc a
	jp z,#1b			; delegate to amsdos call

	ld hl,saved_cas_vectors+#bc8c-#bc77
	ld de,#bc8c
	call add_iy_to_hl
	ld bc,5*3
	ldir				; restore input related vectors

	rra				; A=0, carry set (A was 1)
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

invalid_command:
	ld hl, invalid_command_message
	call print
	xor a				; clear carry
	ret

invalid_command_message:
	defb "Bad command",13,10,0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

spi_cas_in_open:
        ld hl,spi_cas_in_open_message
        jp print
spi_cas_in_open_message: defb "spi_cas_in_open",13,10,0

spi_cas_in_close:
        ld hl,spi_cas_in_close_message
        jp print
spi_cas_in_close_message: defb "spi_cas_in_close",13,10,0

spi_cas_in_abandon:
        ld hl,spi_cas_in_abandon_message
        jp print
spi_cas_in_abandon_message: defb "spi_cas_in_abandon",13,10,0

spi_cas_in_char:
        ld hl,spi_cas_in_char_message
        jp print
spi_cas_in_char_message: defb "spi_cas_in_char",13,10,0

spi_cas_in_direct:
        ld hl,spi_cas_in_direct_message
        jp print
spi_cas_in_direct_message: defb "spi_cas_in_direct",13,10,0

spi_cas_return:
        ld hl,spi_cas_return_message
        jp print
spi_cas_return_message: defb "spi_cas_return",13,10,0

spi_cas_test_eof:
        ld hl,spi_cas_test_eof_message
        jp print
spi_cas_test_eof_message: defb "spi_cas_test_eof",13,10,0

spi_cas_out_open:
        ld hl,spi_cas_out_open_message
        jp print
spi_cas_out_open_message: defb "spi_cas_out_open",13,10,0

spi_cas_out_abandon:
        ld hl,spi_cas_out_abandon_message
        jp print
spi_cas_out_abandon_message: defb "spi_cas_out_abandon",13,10,0

spi_cas_out_char:
        ld hl,spi_cas_out_char_message
        jp print
spi_cas_out_char_message: defb "spi_cas_out_char",13,10,0

spi_cas_out_direct:
        ld hl,spi_cas_out_direct_message
        jp print
spi_cas_out_direct_message: defb "spi_cas_out_direct",13,10,0

spi_cas_catalog:
        ld hl,spi_cas_catalog_message
        jp print
spi_cas_catalog_message: defb "spi_cas_catalog",13,10,0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


















; nice table lookup code in rst 5 handler:
;	add a
;	add a,#table_l
;	ld l,a
;	adc a,#table_h
;	sub l
;	ld h,a


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;===============================================================
;; DE = IY+DE (AMSDOS ca98)
add_iy_to_de:
	push iy
	ex (sp),hl		; HL saved on stack, HL=IY
	add hl,de
	ex de,hl
	pop hl			; restore HL
	ret

;;===============================================================
;; HL = IY+HL (AMSDOS ca9f)

add_iy_to_hl:
	push de
	push iy
	pop de
	add hl,de
	pop de
	ret


