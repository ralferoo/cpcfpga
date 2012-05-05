
	org #4000

	di
	ld sp,#bfff

	ld bc,#7f8c
	out (c),c

	ld hl,#c9fb		; ei : ret
	ld (#38),hl
	ei

	ld hl,bootloader
	ld de,bootloader2
	ld bc,bootloader2-bootloader
	ldir

	ld a,#4
	ld bc,#fade
	out (c),a

retry_sync:
	call doreset

	ld hl,intro_msg
	call print

	ld a,#ac
	call send_byte
	ld a,#53
	call send_byte
	xor a
	call send_byte
	push af
	xor a
	call send_byte
	pop af

	cp #53
	jr nz,retry_sync

	ld hl,found_msg
	call print

	ld hl,signature_byte_msg
	call print
	ld b,0
sigloop:
	ld a,#30
	call send_byte
	xor a
	call send_byte
	ld a,b
	call send_byte
	xor a
	call send_byte
	ld a,13
	call chout
	ld a,10
	call chout
	inc b
	ld a,4
	cp b
	jr nz,sigloop

	ld hl,lock_bits_msg
	call print
	ld a,#58
	call send_byte
	xor a
	call send_byte
	xor a
	call send_byte
	xor a
	call send_byte

	ld hl,fuse_bits_msg
	call print
	ld a,#50
	call send_byte
	xor a
	call send_byte
	xor a
	call send_byte
	xor a
	call send_byte

	ld hl,fuse_high_bits_msg
	call print
	ld a,#58
	call send_byte
	ld a,#8
	call send_byte
	xor a
	call send_byte
	xor a
	call send_byte

	ld hl,fuse_ext_bits_msg
	call print
	ld a,#50
	call send_byte
	ld a,#8
	call send_byte
	xor a
	call send_byte
	xor a
	call send_byte

	ld hl,cali_byte_msg
	call print
	ld a,#38
	call send_byte
	xor a
	call send_byte
	xor a
	call send_byte
	xor a
	call send_byte

	call do_erase

	ld hl,load_ext_byte_msg
	call print

	ld a,#4d
	call send_byte
	xor a
	call send_byte
	xor a
	call send_byte
	xor a
	call send_byte
	
	ld hl,writing_msg
	call print

	ld hl,bootloader
	ld de,#3000
	call write_bootloader

	ld hl,read_memory_msg
	call print
	ld hl,#3000
read_mem_loop:
	ld a,#4d
	call send_byte_silent
	xor a
	call send_byte_silent
	xor a
	call send_byte_silent
	xor a
	call send_byte_silent

	ld a,#20
	call send_byte_silent
	ld a,h
	call send_byte_silent
	ld a,l
	call send_byte_silent
	xor a
	call send_byte_silent
	call outhex

;	ld a,'|'
;	call chout
	ld a,' '
	call chout

	ld a,#28
	call send_byte_silent
	ld a,h
	call send_byte_silent
	ld a,l
	call send_byte_silent
	xor a
	call send_byte_silent
	call outhex

	ld a,' '
	call chout

	inc hl

	ld a,l
	and #f
	jr nz, read_mem_loop

	ld a,13
	call chout
	ld a,10
	call chout

	ld a,h
	and #3f
	jr nz, read_mem_loop

;	call do_poll

	ld hl,done_msg
	call print

	call restart

	jp 0
hang:	jp hang


do_erase:
	ld hl,chip_erase_msg
	call print
	ld a,#ac
	call send_byte
	ld a,#80
	call send_byte
	xor a
	call send_byte
	xor a
	call send_byte
	jp do_poll

;	ld hl,bootloader
;	ld de,#3800

write_bootloader:
	ld a,#40			; low byte
	call send_byte_silent
	ld a,d
	call send_byte_silent
	ld a,e
	call send_byte_silent
	ld a,(hl)
	inc hl
	call send_byte_silent

	ld a,#48			; high byte
	call send_byte_silent
	ld a,d
	call send_byte_silent
	ld a,e
	call send_byte_silent
	ld a,(hl)
	inc hl
	call send_byte_silent

	ld a,e
	inc a
	and #3f
	jr nz, nowritepage

	ld a,#4c			; flush page
	call send_byte
	ld a,d
	call send_byte
	ld a,e
	call send_byte
	xor a
	call send_byte

	call do_poll

nowritepage:
	inc de
	ld a,d
	and #3f
	jr nz,write_bootloader
	ret 				; finished writing

do_poll:
	push hl
;	ld hl,poll_msg
;	call print

poll_loop:
	ld a,'.'
	call chout

	ld a,#f0
	call send_byte_silent
	xor a
	call send_byte_silent
	xor a
	call send_byte_silent
	xor a
	call send_byte_silent
	rrca
	jr c, poll_loop
	pop hl
	ret

doreset:
	push hl
	ld hl,reset_msg
	call print
	pop hl

	push bc
	ld bc,#fade
	ld a,#0				; left LED, no reset
	out (c),a

	ld bc,0
reset_wait_1:
	dec bc
	ld a,b
	or c
	jr nz, reset_wait_1
	ld bc,#fade
	ld a,#a				; 2nd LED, reset
	out (c),a
	pop bc
	ret

restart:
	push bc
	ld bc,#fade
	ld a,#0				; left LED, no reset
	out (c),a
	pop bc
	ret

	ld bc,0

send_byte:
	push de
	push bc

	ld d,a
	call outhex

	call send_byte_internal
	
	ld a,'>'
	call chout

	ld a,d
	call outhex

	ld a,32
	call chout

	ld a,d
	pop bc
	pop de
	ret

send_byte_silent:
	push de
	push bc

	ld d,a
	call send_byte_internal
	ld a,d

	pop bc
	pop de
	ret

send_byte_internal:
	ld b,8

bit_loop:
	push bc

	ld b,#f5
	in a,(c)
	rla				; read data bit in

	rl d				; data bit out, save bit in
	sbc a,a
	and #20				; put bit into tape data
	ld b,#f6
	or #10
	out (c),a			; output bit
	and #20
	out (c),a			; toggle clock high

	pop bc
	djnz bit_loop

	ret
	
print:
	ld a,(hl)
	or a
	ret z
	inc hl
	call chout
	jr print

outhex:
        push af
        rra
        rra
        rra
        rra
        call outhexnibble
        pop af
outhexnibble:
        and #f
        add a,#90
        daa
        adc a,#40
        daa

chout:
	push bc
	push af
tryserial:
	ld bc,#fadd
	in a,(c)
	rlca
	jr nc,tryserial				; skip if no serial data
	pop af

	dec c
	out (c),a				; output the updated character
	inc c
	pop bc

	ret

reset_msg:
	defb "Doing reset...",13,10,0

intro_msg:
	defb 13,10,"Testing serial program mode:",13,10,0

found_msg:
	defb 13,10,"Received programming enable ack...", 13,10,0

lock_bits_msg:
	defb 13,10,"Lock bits:",13,10,0


fuse_bits_msg:
	defb 13,10,"Fuse bits:",13,10,0


fuse_ext_bits_msg:
	defb 13,10,"Extended fuse bits:",13,10,0


fuse_high_bits_msg:
	defb 13,10,"Fuse High bits:",13,10,0


cali_byte_msg:
	defb 13,10,"Calibration byte:",13,10,0

signature_byte_msg:
	defb 13,10,"Signature bytes:",13,10,0

poll_msg:
	defb 13,10,"Polling:",13,10,0

done_msg:
	defb 13,10,"Done!",13,10,0

read_memory_msg:
	defb 13,10,"Reading program memory:",13,10,0

load_ext_byte_msg:
	defb 13,10,"Loading extended byte:",13,10,0

chip_erase_msg:
	defb 13,10,"Erasing chip...",13,10,0

writing_msg:
	defb 13,10,"Writing...",13,10,0

bootloader:
	incbin "controller/LUFA-120219/Bootloaders/DFU/BootloaderDFU.hex"

bootloader2:

