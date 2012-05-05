
	org #4000

	di
	ld sp,#bfff

	ld bc,#7f8c
	out (c),c

	ld hl,#c9fb		; ei : ret
	ld (#38),hl
	ei

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
	ld a,b
	call send_byte
	xor a
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

	ld hl,poll_msg
	call print
	ld a,#f0
	call send_byte
	xor a
	call send_byte
	xor a
	call send_byte
	xor a
	call send_byte

	ld hl,done_msg
	call print

	jp 0
hang:	jp hang

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


send_byte:
	push de
	push bc

	ld d,a
	call outhex

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
