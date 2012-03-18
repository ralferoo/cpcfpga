
; test interrupt driven split screen

	org #4000

vsync_time		equ 35		; 30 = first visible at top, 25 = first visible after vsync
screen_height		equ 261		; total visible height of all 3 screens
inter_screen_gap	equ 1		; creates a gap between the smaller screens
split_height		equ 104
	
intvec	equ #39

hpos equ 48	; 49 maximum for crtc 2, 50 best for other crtc

	; set up the initial sync wait interrupt

	ld sp,#9000

	ld a,'!'
	call ttyout

	di
	ld hl,initial_sync
	ld (intvec),hl
	ld a,#c3
	ld (intvec-1),a

	; set up the initial split screen	

        ld bc,&bc00 + 6
        out (c),c
        ld bc,&bd00 + 0		; nothing displayed
        out (c),c
        
        ld bc,&bc00 + 9
        out (c),c
        ld bc,&bd00 + 0
        out (c),c		; screen lines = raster lines
        
        ld bc,&bc00 + 2
        out (c),c
        ld bc,&bd00 + hpos
        out (c),c		; horizontal position
        
        ld bc,&bc00 + 7
        out (c),c
        ld bc,&bd00 + split_height-1-vsync_time	; vsync, i.e. full frame after last
        out (c),c

        ld bc,&bc00 + 4
        out (c),c
        ld bc,&bd00 + split_height-1
        out (c),c		; screen is 104 high

width equ 48

	ld bc,&bc01
        out (c),c
	ld bc,&bd00+width
        out (c),b
xx:
	ld a,'#'
	call ttyout

	; enable interrupts so we can wait for interrupts

	ei

	ld a,'@'
	call ttyout

;	ld hl,#4000
;	call fill	

	ld a,'1'
	call ttyout

	ld hl,#8000
;	call fill	

	ld a,'2'
	call ttyout

	ld hl,#c000
;	call fill	

	ld a,'3'
	call ttyout

	ld bc,#7f8c
	out (c),c

	ld a,'#'
	call ttyout

	ld bc,#7f10
	out (c),c

	ld a,'4'
	call ttyout

waste:	jr waste
	halt

	ld a,'5'
	call ttyout

;	out (c),c

	ld b,#10
zzz	djnz zzz

	ld bc,&bc01
        out (c),c
	ld bc,&bd00+width
        out (c),b

	ld b,#60
aaa	djnz aaa

	ld bc,&bd00+width
        out (c),c

	ld b,#60
bbb	djnz bbb

	ld bc,&bd00+width
        out (c),b

	ld b,#60
ccc	djnz ccc

	ld bc,&bd00+width
        out (c),c

	ld a,'6'
	call ttyout

	call keyboard_reset
	
	jr waste

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

fill:	ld b,0
	ld a,h
	
f_loop:	ld (hl),h
	inc hl
	ld (hl),l
	inc hl
	ld (hl),a
	inc hl
	ld (hl),a
	inc hl
	ld (hl),h
	inc hl
	ld (hl),l
	inc hl
	ld (hl),a
	inc hl
	ld (hl),a
	inc hl
	djnz f_loop
	ret	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; checks if escape is pressed and do a reset if so...

keyboard_reset:
	ld bc,#f782
	out (c),c
	ld bc,#f40e
	out (c),c
	ld bc,#f6c0
	out (c),c
	xor a
	out (c),a

	ld bc,#f792
	out (c),c
	ld bc,#f648		; 48 is keyboard line
	out (c),c
	ld b,#f4
	in a,(c)
	ld bc,#f782
	out (c),c
	ld bc,#f600
	out (c),c

	and #4			; bit 3 is escape
	ret nz

;;;; full reset

	ld hl,#ffff
	ld (hl),#49
	dec hl
	ld (hl),#ed		; store out (c),c at #fffe
	ld bc,#7f89		; enable lower ROM
	jp (hl)			; jump to it

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

initial_sync:
	ld a,'-'
	call ttyout

	exx     
	ld bc,#7f10
	out (c),c
here:
	ld bc,#7f45
	out (c),c

	inc c
	set 6,c
	res 7,c
	ld (here+1),bc      

	ld b,#f5
        in c,(c)
        rr c
        jr nc,nosync

	ld hl,int1
	ld (intvec),hl

	ld c,#42
nosync:
        out (c),c
		
	exx
	
	ld c,#23
	     
	ei
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

int0:	
	exx     

        ld bc,&bc00 + 6
        out (c),c
        ld bc,&bd00 + split_height-inter_screen_gap     ; display graphics for every line
        out (c),c
        
        ld bc,&bc00 + 7
        out (c),c
        ld bc,&bd00 + 127
        out (c),c

        ld bc,&bc00 + 12	; 3
	out (c),c		; 4
	ld bc,&bdc0 + #10
	out (c),c		; 2nd part at #8000

	ld bc,&bc00 + 13	; 3
	out (c),c		; 4
	ld bc,&bd00 + #00
	out (c),c		; 2nd part at #8000

	ld bc,#7f42
   	out (c),c

	ld hl,int1
	ld (intvec),hl

	exx     
	ei
	ret

int1:
	exx     

	ld bc,#7f45
	out (c),c

	ld hl,int2
	ld (intvec),hl

	exx     
	ei
	ret

int2:
	exx     

        ld bc,&bc00 + 12	; 3
	out (c),c		; 4
	ld bc,&bdc0 + #20
	out (c),c		; 3rd part at #c000

	ld bc,&bc00 + 13	; 3
	out (c),c		; 4
	ld bc,&bd00 + #00
	out (c),c		; 3rd part at #c000

	ld bc,#7f41
	out (c),c

	ld hl,int3
	ld (intvec),hl

	exx     
	ei
	ret

int3:
	exx     

	ld bc,#7f43
	out (c),c

	ld hl,int4
	ld (intvec),hl

	exx     
	ei
	ret

int4:
	exx     

        ld bc,&bc00 + 12	; 3
	out (c),c		; 4
	ld bc,&bdc0 + #30
	out (c),c		; 1st part at #4000

	ld bc,&bc00 + 13	; 3
	out (c),c		; 4
	ld bc,&bd00 + #00
	out (c),c		; 1st part at #4000

	ld bc,#7f46
	out (c),c

	ld hl,int5
	ld (intvec),hl

	exx     
	ei
	ret

int5:
	exx     

        ld bc,&bc00 + 6
        out (c),c
        ld bc,&bd00 + screen_height+split_height-312	; remainder of screen
        out (c),c
        
        ld bc,&bc00 + 7
        out (c),c
        ld bc,&bd00 + split_height-1-vsync_time	; vsync on line 208+103, i.e. full frame after last
        out (c),c

	ld bc,#7f47
	out (c),c

	ld hl,int0
	ld (intvec),hl

	exx     
	ei
	ret
	     			    	

ttyout:
	push bc
	push af
tryserial:
        ld bc,#fadd
        in a,(c)
        rlca
        jr nc,tryserial                         ; skip if no serial data

        dec c
	pop af
        out (c),a                               ; output the updated character
	pop bc
	ret


