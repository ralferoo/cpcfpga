
SPI_PORT			equ	#feff
AMSDOS_HEADER_SIZE		equ 64
AMSDOS_ADDR			equ 18	; CHECK
AMSDOS_LEN			equ 20	; CHECK
AMSDOS_TYPE			equ 22	; CHECK

iy_current_spi_status		equ 0
iy_is_writing			equ (iy_current_spi_status+1)
iy_write_spi_offset		equ (iy_is_writing+1)
iy_is_reading			equ (iy_write_spi_offset+3)
iy_read_spi_offset	 	equ (iy_is_reading+1)
iy_long_jump_vector		equ (iy_read_spi_offset+3)
iy_existing_tape_in		equ (iy_long_jump_vector+3)
iy_existing_tape_out		equ (iy_existing_tape_in+4)

iy_read_scratch_buffer		equ (iy_existing_tape_out+2)
iy_read_name			equ (iy_read_scratch_buffer+2)
iy_read_name_len		equ (iy_read_name+1)
iy_read_page_low		equ (iy_read_name_len+1)
iy_read_page_high		equ (iy_read_page_low+1)
iy_read_page_ofs		equ (iy_read_page_high+1)

iy_amsdos_header_write		equ (iy_read_page_ofs+4)
iy_amsdos_header_read		equ (iy_amsdos_header_write+AMSDOS_HEADER_SIZE)
iy_saved_cas_vectors		equ (iy_amsdos_header_read+AMSDOS_HEADER_SIZE)

iy_data_area_size		equ (iy_saved_cas_vectors+13*3)


SPI_STATUS_IDLE			equ 0
SPI_STATUS_READING		equ 1
SPI_STATUS_WRITING		equ 2

ENTRY_TYPE_FREE			equ #ff
ENTRY_TYPE_DIRTY		equ #7f
ENTRY_TYPE_DIRTY_MASK		equ #c0

ENTRY_TYPE_MASK			equ #3f
ENTRY_TYPE_NON_AMSDOS_MASK	equ #20		; 00=AMSDOS
ENTRY_TYPE_DELETED		equ #00

ENTRY_TYPE_HIDDEN_MASK		equ #10
ENTRY_TYPE_HIDDEN_INVMASK	equ #2f
ENTRY_TYPE_NORMAL_FILE		equ #01

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
	ld de,-iy_data_area_size
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
	ld de,iy_saved_cas_vectors
	call add_iy_to_de
	ld bc,13*3
	ldir

	ld de,jump_vector
	ld (iy+iy_long_jump_vector+0),e
	ld (iy+iy_long_jump_vector+1),d
	call #b912				; KL_CURR_SELECTION
	ld (iy+iy_long_jump_vector+2),a

;	ld hl,cmd_tape
;	call kl_find_command
;	ld (iy+iy_existing_tape+0),l
;	ld (iy+iy_existing_tape+1),h
;	ld (iy+iy_existing_tape+2),c

	ld hl,cmd_tape_in
	call kl_find_command
	ld (iy+iy_existing_tape_in+0),l
	ld (iy+iy_existing_tape_in+1),h
	ld (iy+iy_existing_tape_in+2),c
	ld (iy+iy_existing_tape_in+3),a

	ld hl,cmd_tape_out
	call kl_find_command
	ld (iy+iy_existing_tape_out+0),l
	ld (iy+iy_existing_tape_out+1),h
	ld (iy+iy_existing_tape_out+2),c
	ld (iy+iy_existing_tape_out+3),a

	xor a
	ld (iy+iy_is_reading),a
	ld (iy+iy_is_writing),a
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

	ld de,spi_jump_table-#bc7a		; HL=vector+3
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
	jp	spi_cas_out_close
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

	ld de,iy_long_jump_vector
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

	ld l,(iy+iy_existing_tape_in+0)
	ld h,(iy+iy_existing_tape_in+1)
	ld c,(iy+iy_existing_tape_in+2)
	ld a,(iy+iy_existing_tape_in+3)	; FF if exists
	inc a
	jp z,#1b			; delegate to amsdos call

	ld hl,iy_saved_cas_vectors
	ld de,#bc77		
	call add_iy_to_hl
	ld bc,7*3
	ldir				; restore input related vectors

	ld hl,iy_saved_cas_vectors+#bc9b-#bc77
	ld de,#bc9b
	call add_iy_to_hl
	ld bc,3
	ldir				; restore cas catalog

	call	spi_cas_in_abandon
	xor a
	scf
	ret

set_cas_vectors_out:
	or a
	jr nz, invalid_command

	ld l,(iy+iy_existing_tape_out+0)
	ld h,(iy+iy_existing_tape_out+1)
	ld c,(iy+iy_existing_tape_out+2)
	ld a,(iy+iy_existing_tape_out+3)	; FF if exists
	inc a
	jp z,#1b			; delegate to amsdos call

	ld hl,iy_saved_cas_vectors+#bc8c-#bc77
	ld de,#bc8c
	call add_iy_to_hl
	ld bc,5*3
	ldir				; restore input related vectors

	call	spi_cas_out_abandon
	xor a
	scf
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
;
; iterate all blocks in the filesystem, calling the function at IX for each
; non-deleted record

iterate_records:

; HL=filename, B=length of filename, DE=offset to add to IY
; BC,DE,HL,AF corrupt

copy_filename_to_header:
	call add_iy_to_de			; DE=file header
	ld c,16					; B=name length, C=buffer length
filename_loop:
	ld a,c
	or a
	ret z					; return if all 16 bytes copied

	ld a,(hl)
	inc hl					; A=character
	cp 'a'
	jr c,nocap
	cp 'z'+1
	jr nc,nocap
	and #df					; make uppercase
nocap:
	ld (de),a
	inc de					; store uppercase char
	dec c
	djnz filename_loop			; copy all input chars

	ld a,c
	or a
	ret z					; return if no characters left to pad

	ld b,c
	xor a
null_rest_loop:
	ld (de),a
	inc de
	djnz null_rest_loop			; pad the rest of the filename buffer
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; HL=address of filename
;  B=length of filename
; DE=2K buffer
;
; Opened OK
;	Carry true, Zero false, HL=file header, DE=data location, BC=file length, A=file type
;
; Stream in use
;	Carry false, Zero false, A=#0E
;
; Hit escape
;	Carry false, Zero true, A=#00

spi_cas_in_open:
	ld (iy+iy_read_scratch_buffer+0),e
	ld (iy+iy_read_scratch_buffer+1),d
	ld (iy+iy_read_name+0),l
	ld (iy+iy_read_name+1),h
	ld (iy+iy_read_name_len),b

	ld de,iy_amsdos_header_read
	call copy_filename_to_header

	ld a,(iy+iy_is_writing)			; make sure we're not currently writing anything
	and a
	jr nz, stream_already_in_use

	call wait_while_wip			; ensure anything being written has finished
	ld hl,#0100				; HL is start page (0100.00)

try_next_file:
	ld de,#300				; D is read command
	out (c),b				; turn on flash rom CE
	out (c),d				; read
	out (c),h				; page high
	out (c),l				; page low
	out (c),e				; offset 0 in page
	inc b
	in a,(c)				; pull first byte in

	in e,(c)				; get status byte
	ld a,ENTRY_TYPE_DIRTY_MASK
	and e					; check block valid bits
	jr nz, file_not_found			; either end of file or damaged block

	ld a,e
	in e,(c)
	in d,(c)				; DE = next page
	push de					; store next block on stack

	and ENTRY_TYPE_HIDDEN_INVMASK		; get file type mask, ignoring visible bit
	cp ENTRY_TYPE_NORMAL_FILE
	jr nz, not_this_file			; deleted, skip

	inc hl
	ld (iy+iy_read_page_low),l
	ld (iy+iy_read_page_high),h

	ld hl,iy_amsdos_header_read
	call add_iy_to_hl			; HL=file header (file name)
	ld d,16					; maximum length
checkname:
	in a,(c)
	cp (hl)
	jr nz, not_this_file			; filename isn't a match
	inc hl
	dec d
	jr nz, checkname			; check remaining chars

	; now we have a file match
	ld (iy+iy_read_page_ofs),0

	ld d,AMSDOS_HEADER_SIZE-16
copy_header:
	in a,(c)
	ld (hl),a
	inc hl
	dec d
	jr nz, copy_header			; read in the rest of the header

	dec b
	out (c),c				; turn off flash rom CE
	pop hl					; pull next block off stack (junked)

	ld hl,iy_amsdos_header_read
	call add_iy_to_hl			; HL=file header (file name)

;	Carry true, Zero false, HL=file header, DE=data location, BC=file length, A=file type

	scf
	sbc a,a					; carry set, zero clear, A=FF
	ld (iy+iy_is_writing),a			; mark stream as in use

	ld e,(iy+iy_amsdos_header_read+AMSDOS_ADDR+0)
	ld d,(iy+iy_amsdos_header_read+AMSDOS_ADDR+1)
	ld c,(iy+iy_amsdos_header_read+AMSDOS_LEN+0)
	ld b,(iy+iy_amsdos_header_read+AMSDOS_LEN+1)
	ld a,(iy+iy_amsdos_header_read+AMSDOS_TYPE)

	ret					; return success

not_this_file:
	dec b
	out (c),c				; turn off flash rom CE
	pop hl					; pull next block off stack
	jr try_next_file

file_not_found:
	dec b
	out (c),c				; turn off flash rom CE
	xor a					; clear A, zero, carry
	ret

stream_already_in_use:
	ld a,#0e
	and a					; clear A, zero, carry
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Closed OK
;	Carry true, Zero false
;
; Stream not open
;	Carry false, Zero false, A=#0E

spi_cas_in_close:
        ld hl,spi_cas_in_close_message
        jp print
spi_cas_in_close_message: defb "spi_cas_in_close",13,10,0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

spi_cas_in_abandon:
        ld hl,spi_cas_in_abandon_message
        jp print
spi_cas_in_abandon_message: defb "spi_cas_in_abandon",13,10,0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Read OK
;	Carry true, Zero false, A=character
;
; Stream not open
;	Carry false, Zero false, A=#0E
;
; EOF
;	Carry false, Zero false, A=#0F
;
; Soft EOF
;	Carry false, Zero false, A=#1A

spi_cas_in_char:
        ld hl,spi_cas_in_char_message
        jp print
spi_cas_in_char_message: defb "spi_cas_in_char",13,10,0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; HL=destination address
;
; Read OK
;	Carry true, Zero false, HL=entry address
;
; Stream not open
;	Carry false, Zero false, A=#0E

spi_cas_in_direct:
        ld hl,spi_cas_in_direct_message
        jp print
spi_cas_in_direct_message: defb "spi_cas_in_direct",13,10,0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Everything preserved

spi_cas_return:
        ld hl,spi_cas_return_message
        jp print
spi_cas_return_message: defb "spi_cas_return",13,10,0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Not EOF
;	Carry true, Zero false
;
; Stream not open
;	Carry false, Zero false, A=#0E
;
; EOF
;	Carry false, Zero false, A=#0F
;
; Soft EOF
;	Carry false, Zero false, A=#1A

spi_cas_test_eof:
        ld hl,spi_cas_test_eof_message
        jp print
spi_cas_test_eof_message: defb "spi_cas_test_eof",13,10,0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; HL=address of filename
;  B=length of filename
; DE=2K buffer
;
; Opened OK
;	Carry true, Zero false, HL=file header
;
; Stream in use
;	Carry false, Zero false, A=#0E
;
; Hit escape
;	Carry false, Zero true, A=#00

spi_cas_out_open:
        ld hl,spi_cas_out_open_message
        jp print
spi_cas_out_open_message: defb "spi_cas_out_open",13,10,0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; nothing written if length==0
;
; Closed OK
;	Carry true, Zero false
;
; Stream not open
;	Carry false, Zero false, A=#0E

spi_cas_out_close:
	ld a,(iy+iy_is_writing)
	or a
	jr z,clear_c_clear_z_return_0e

	ld d,#f0
	call spi_cas_terminate_stream

set_c_clear_z_return_00:
	xor a	
	scf
	ret

clear_c_clear_z_return_0e:
	ld a,#e
	or a
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

spi_cas_out_abandon:
	ld d,#f8				; abandoned status

spi_cas_terminate_stream:

	ld a,(iy+iy_is_writing)
	or a					; 00 -> Z=1,C=0
	jr z,set_c_clear_z_return_00		; return 0 if closed, stream(#0e) if open

	; abandon any partial write in progress
	ld bc,SPI_PORT
	out (c),c				; turn off CE
	call wait_while_wip			; wait for any active write to finish

	; update the header
	ld bc,SPI_PORT
	out (c),b				; turn on flash rom CE


; 1	ENTRY_TYPE
;								FF = free
;			bit 0 - 0=started writing		FE = garbage
;			bit 1 - 0=updated NEXT_RECORD		FC = abandoned
;			bit 2 - 0=valid data block		F8 = special file
;			bit 3 - 0=valid AMSDOS header		F0 = AMSDOS file
;			bit 4 -					E0 = ???
;			bit 5 - 0=entry is "system file"	C0 = invisible file
;			bit 6					80 = ???
;			bit 7 - 0=deleted			00 = deleted
;
;			file can be considered valid if bit7=1 and bit3=0, i.e.
;			(entry_type & 0x88)==0x80
;
; 3	NEXT_RECORD
;			FFFFFF = end of disk / unknown length
;			xxxxxx = address of next record (LSB first)
; 64	AMSDOS_HDR

	ld l,(iy+iy_write_spi_offset)
	ld h,(iy+iy_write_spi_offset+1)
	ld e,(iy+iy_write_spi_offset+2)

	inc b					; change to SPI data port
	ld a,#2
	out (c),a				; program page data
	out (c),e				; send address
	out (c),h
	out (c),l

	push de
	push hl
	xor a
	ld l,(iy+iy_amsdos_header_write+19)	; lo byte of length
	ld h,(iy+iy_amsdos_header_write+20)	; hi byte of length
	ld de,AMSDOS_HEADER_SIZE
	add hl,de
	adc a,a					; A:HL = length of file + header

	pop de
	add hl,de
	pop de
	add a,e					; A:HL = length of file + header + write_spi_offset

	out (c),d				; write status flag
	out (c),l
	out (c),h
	out (c),a				; and offset of free data

	dec b
	out (c),c				; turn off CE
	call wait_while_wip			; wait for any active write to finish

	ld (iy+iy_is_writing),0
	jr clear_c_clear_z_return_0e

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Write OK
;	Carry true, Zero false, HL=entry address
;
; Stream not open
;	Carry false, Zero false, A=#0E

spi_cas_out_char:
        ld hl,spi_cas_out_char_message
        jp print
spi_cas_out_char_message: defb "spi_cas_out_char",13,10,0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; HL=address, DE=length of data, BC=entry address, A=file type
;
; Write OK
;	Carry true, Zero false
;
; Stream not open
;	Carry false, Zero false, A=#0E

spi_cas_out_direct:
        ld hl,spi_cas_out_direct_message
        jp print
spi_cas_out_direct_message: defb "spi_cas_out_direct",13,10,0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

get_start_address:				; E:HL is the start address of this block
	ld de,#301				; D is read command
	ld hl,0
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Catalog OK
;	Carry true, Zero false
;
; Stream in use
;	Carry false, Zero false, A=#0E

spi_cas_catalog:
	call spi_cas_out_abandon		; abandon any writes before we do a catalog

	ld bc,SPI_PORT

	call get_start_address
catalog_loop:
	out (c),c				; turn off CE
	out (c),b				; turn on flash rom CE
	inc b
	out (c),d				; start read
	out (c),e
	out (c),h
	out (c),l
	in a,(c)				; read dummy byte

	in a,(c)				; get type byte
	in e,(c)
	in h,(c)
	in l,(c)				; get next address
	dec b

; 1	ENTRY_TYPE
;								FF = free
;			bit 0 - 0=started writing		FE = garbage
;			bit 1 - 0=updated NEXT_RECORD		FC = abandoned
;			bit 2 - 0=valid data block		F8 = special file
;			bit 3 - 0=valid AMSDOS header		F0 = AMSDOS file
;			bit 4 -					E0 = ???
;			bit 5 - 0=entry is "system file"	C0 = invisible file
;			bit 6					80 = ???
;			bit 7 - 0=deleted			00 = deleted
;
;			file can be considered valid if bit7=1 and bit3=0, i.e.
;			(entry_type & 0x88)==0x80

	bit 1,a
	ret nz				; free or garbage block found, abort

	bit 3,a
	jr nz,catalog_loop		; found something, but it's not a file

	bit 5,a
	jr z,catalog_loop		; found a deleted or invisible file, skip over it

	push de
	push hl				; save address	
	inc b				; back to data input

	ld d,16
catalog_name_loop:
	in a,(c)
	jr nz, catalog_name_nopad
	ld a,32
catalog_name_nopad:
	push de
	push bc
	call #bb5d
	pop bc
	pop de
	dec d
	ld a,d
	or a
	jr nz,catalog_name_loop

	ld a,32
	call #bb5a

	in a,(c)			; block #
	in a,(c)			; last block
	in a,(c)			; file type

	add a,#24			; format
	call #bb5a

	ld a,13
	call #bb5a
	ld a,10
	call #bb5a

 	pop hl
	pop de
	dec b
	jr catalog_loop			; next entry

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



wait_while_wip:
	ld bc,SPI_PORT
	ld a,(iy+iy_current_spi_status)		; see if we're in an SPI write
	cp SPI_STATUS_WRITING
	jr nz,write_finished

	out (c),c				; turn off CE
	out (c),b				; turn on flash rom CE
	inc b					; change to SPI data port
	ld a,#5
	out (c),a				; read status
	in a,(c)		; KLUDGE
wait_wip_loop:
	in a,(c)				; read status
	rrca
	jr c,wait_wip_loop			; bit still 1, not finished write operation
	dec b
	out (c),c				; turn off CE

write_finished:
	ld (iy+iy_current_spi_status),SPI_STATUS_IDLE
	ret


send_write_enable:
	ld bc,SPI_PORT
	out (c),c				; turn off CE
	out (c),b				; turn on flash rom CE
	inc b					; change to SPI data port
	ld a,#06
	out (c),a				; write enable
	dec b
	out (c),c				; turn off CE
	ret
;;;












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


