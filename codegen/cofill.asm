
; test interrupt driven split screen

	org #4000

aaa_start:

; 50 + 231 -> 281 -> 32 + 1 + 6*33

intvec	equ #39

hpos equ 49	; 49 maximum for crtc 2, 50 best for other crtc

     	 ; 48 is the lowest we can go and get a switch in time so we only have 6 lines

scr_start_1	equ 53

scr_disp_1	equ 102
scr_total_1	equ 102

scr_disp_2	equ 96
scr_total_2	equ 108

scr_disp_3	equ 22
scr_total_3	equ 102

width 			equ 32			; should be 46?
repeat_line_width	equ 40			; should be 64
scroll_width		equ 46			; should be 46

;;
;
;    ---   0 int0
;
;    ---  25 physical monitor top
;
;    ---  50 frame 1 start
;    ---  52 int1
;
;
;
;    ---  104 int2
;
;
;    ---  152 frame 2 start
;    ---  156 int3
;
;
;
;    ---  208 int4
;
;    ---  248 frame 2 stop
;    ---  249 scroll frame start
;
;    ---  260 int5
;
;    ---  281 scroll frame stop
;
;    ---  312 int0

; frame sizes:
; @  50 disp 102 tot 102   chunky frame 1
; @ 152 disp  96 tot  97   chunky frame 2
; @ 249 disp  32 tot 113   scroll text
;                    --- 
;                    312 
;                    --- 
                        
	; set up the initial sync wait interrupt

	di
	ld hl,initial_sync
	ld (intvec),hl
	ld a,#c3
	ld (intvec-1),a

	ld a,#c3
	ld (#20),a
	ld hl,coroutine_swap
	ld (#21),hl			; rst 4 = coroutine swap

	; set up initial cotasks
	
	ld de,task1_sp_save
	ld hl,task1_sp_top
	ld bc,task1_code
	call setup_task

	ld de,task2_sp_save
	ld hl,task2_sp_top
	ld bc,task2_code
	call setup_task

	; set up the initial split screen	

        ld bc,&bc00 + 9
        out (c),c
        ld bc,&bd00 + 0
        out (c),c		; screen lines = raster lines
        
        ld bc,&bc00 + 2
        out (c),c
        ld bc,&bd00 + hpos
        out (c),c		; horizontal position
        
        ld bc,&bc00 + 6
        out (c),c
        ld bc,&bd00 + 0		; nothing displayed
        out (c),c
        
        ld bc,&bc00 + 7
        out (c),c
        ld bc,&bd00 + 102-1-scr_start_1	; vsync, i.e. full frame after last
        out (c),c

        ld bc,&bc00 + 4
        out (c),c
        ld bc,&bd00 + 102-1
        out (c),c		; screen is 104 high

        ld bc,&bc00 + 1
        out (c),c
        ld bc,&bd00 + 0		; nothing displayed
        out (c),c
       

	; enable interrupts so we can wait for interrupts

	ei


	ld hl,#4000
	ld c,#f0
	call fill	
	ld hl,#8000
	ld c,#0f
	call fill	
	ld hl,#c000
	ld c,#ff
	call fill	

	ld bc,#7f10
	out (c),c

	rst #20

waste:
	halt
;	jr waste

;	out (c),c

	ld b,#10
zzz	djnz zzz

	ld bc,&bc01
        out (c),c
	ld bc,&bd00+width
;        out (c),b

	ld b,#60
aaa	djnz aaa

	ld bc,&bd00+width
;        out (c),c

	ld b,#60
bbb	djnz bbb

	ld bc,&bd00+width
;        out (c),b

	ld b,#60
ccc	djnz ccc

	ld bc,&bd00+width
;        out (c),c

	call keyboard_reset
	
	jr waste

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

fill:	ld b,0
	
f_loop:	ld (hl),h
	inc hl
	ld (hl),l
	inc hl
	ld (hl),c
	inc hl
	ld (hl),c
	inc hl
	ld (hl),c
	inc hl
	ld (hl),c
	inc hl
	ld a,h
	xor l
	ld (hl),a
	inc hl
	ld (hl),c
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

nosync:
	exx
	     
	ei
	ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

int0:	
	exx     
        
	ld bc,#7f42		; green
   	out (c),c

        ld a,#f6
        ld bc,&bc00 + 3
        out (c),c
        inc b
        out (c),a

        ld bc,&bc00 + 2
        out (c),c
        ld bc,&bd00 + hpos
        out (c),c		; horizontal position
        
	; define end of screen 3

        ld bc,&bc00 + 4
        out (c),c
        ld bc,&bd00 + scr_total_3-1
        out (c),c			; screen 1 end trigger

        ld bc,&bc00 + 12	; 3
	out (c),c		; 4
	ld bc,&bdc0 + #10
	out (c),c			; screen 1 at #4000

	ld bc,&bc00 + 13	; 3
	out (c),c		; 4
	ld bc,&bd00 + #09
	out (c),c			; screen 1 at #4000


	ld hl,int1
	ld (intvec),hl

	exx     
	ei
	ret

int1:
	exx     

	ld bc,#7f53 
	out (c),c

	; full width

        ld bc,&bc00 + 1
        out (c),c
        ld bc,&bd00 + repeat_line_width	; full width - start screen 1 in line repeat mode
        out (c),c

	; define end of screen 1

        ld bc,&bc00 + 6
        out (c),c
        ld bc,&bd00 + scr_disp_1	; screen 1 visible
        out (c),c
        
        ld bc,&bc00 + 4
        out (c),c
        ld bc,&bd00 + scr_total_1-1
        out (c),c			; screen 1 end trigger

        ld bc,&bc00 + 7
	out (c),c
        ld bc,&bd00 + 127		; don't do vsync at end of screen 1
        out (c),c


	; colour

	ld hl,int2
	ld (intvec),hl

	ld bc,#7f45		; pink 
	out (c),c

	exx     

	ei

	jp coroutine_swap
	ret

int2:
	exx     

	ld bc,#7f57		; darky blue
	out (c),c

        ld bc,&bc00 + 1
        out (c),c
        ld bc,&bd00 + width		; normal width
        out (c),c
        
	; define screen 2 position
	
        ld bc,&bc00 + 12	; 3
	out (c),c		; 4
	ld bc,&bdc0 + #20
	out (c),c			; screen 2 at #8000

	ld bc,&bc00 + 13	; 3
	out (c),c		; 4
	ld bc,&bd00 + #25
	out (c),c			; screen 2 at #8000


	; update scroll text

	ld hl,(scroller_pos)
	ld c,l

	dec hl

	ld de,scroll_width*2

	ld b,8
;	rlc c
	sbc a,a

	jr skip2lines
scrdata:
	rlc c
	sbc a,a

	ex af,af'
	add hl,de
	ld a,h
	and #7
	or #c0	
	ld h,a
	ex af,af'

	ld (hl),a
	inc hl
	ld (hl),d
	dec hl

	ex af,af'
	add hl,de
	ld a,h
	and #7
	or #c0	
	ld h,a
	ex af,af'

	ld (hl),a
	inc hl
	ld (hl),d
	dec hl

skip2lines:
	ex af,af'
	add hl,de
	ld a,h
	and #7
	or #c0	
	ld h,a
	ex af,af'

	ld (hl),a
	inc hl
	ld (hl),d
	dec hl

	djnz scrdata

	; colour

	ld hl,int3
	ld (intvec),hl

	exx     
	ei
	ret

int3:
	exx     

	ld bc,#7f43		; yellow
	out (c),c

	; define end of screen 2

        ld bc,&bc00 + 6
        out (c),c
        ld bc,&bd00 + scr_disp_2	; screen 1 visible
        out (c),c
        
        ld bc,&bc00 + 4
        out (c),c
        ld bc,&bd00 + scr_total_2-1
        out (c),c			; screen 1 end trigger

	; update scroller position

	ld hl,(scroller_pos)
        inc hl
	ld a,h
	and #7
	or #60
	ld h,a
	ld (scroller_pos),hl

	; define screen 3 position
	
        rr h
        rr l
        ld bc,&bc00 + 12	; 3
	out (c),c		; 4
	inc b
	out (c),h			; screen 3 at #c000

	dec b
	inc c
	out (c),c		; 4
	inc b
	out (c),l			; screen 3 at #c000

	; colour

	ld hl,int4
	ld (intvec),hl

	exx     
	ei

	ret

int4:
	exx     

	ld bc,#7f46		; dirty green
	out (c),c

	ld hl,int5
	ld (intvec),hl

	exx     
	ei
	
	ret

int5:
	exx     

	ld bc,#7f47		; pink
	out (c),c

	; fine scroll

	ld a,(scroller_pos)
	and #1
        add a,#f5
        ld bc,&bc00 + 3
        out (c),c
        inc b
        out (c),a
        
	; full width for scroller

        ld bc,&bc00 + 1
        out (c),c
        ld bc,&bd00 + scroll_width	; full width - start screen 1 in line repeat mode
        out (c),c

	; define end of screen 3

        ld bc,&bc00 + 6
        out (c),c
        ld bc,&bd00 + scr_disp_3	; screen 1 visible
        out (c),c
        
	; define end of screen 3

        ld bc,&bc00 + 7
	out (c),c
        ld bc,&bd00 + scr_total_3-1-scr_start_1	; vsync at end of screen 3
        out (c),c

	; colour

	ld hl,int0
	ld (intvec),hl

	exx     
	ei

	jr coroutine_swap
	ret
	     			    	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; switch to specific task to run (passed in hl)

switch_to_specific_task:
        push hl
        jr task_switch_common

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; switch to next task to run
; hl = "end ptr" of next task

switch_to_next_task:
        push hl

task_switch_next_save equ $+1
        ld hl,idle_task_def_end                 ; h1 = next task

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; switch to task common code, hl already pushed and loaded with next taks

task_switch_common:
        push de
        push bc
        push af

task_switch_sp_save equ $+1
        ld (idle_task_sp_save),sp

        di
        ld sp,hl                                ; for ease of getting regs        
        pop hl                                  ; hl = next task after that                                 
        ld (task_switch_next_save),hl           ; update next task pointer                                                            

        pop hl                                  ; hl = saved stack pointer                                                                                      
        ld (task_switch_sp_save),sp             ; update location to store                                   
       
        ld sp,hl                                ; get the most recent stack ptr 
        ei

	pop af
	pop bc
	pop de
	pop hl
	ret

register_space equ 2*4

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; default idle task

idle_task_sp_save:
        defw idle_task_stack_ptr                ; end of idle task stack                                                            
        defw idle_task_def_end                  ; pointer to "next" task
idle_task_def_end:                  

idle_task_stack_ptr:
        defs register_space                     ; storage for regs
        defw idle_task_code                     ; resume address                               

idle_task_code:
	rst #20			                ; swap to next task immediately 
        jr idle_task_code                       ; loop
                     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; coroutine swap

coroutine_swap:
        push af
        push bc
        push de
        push hl
        
        ld hl,(task1_sp_save)
        ld (task1_sp_save),sp
        ld sp,hl

	pop hl
	pop de
	pop bc
	pop af
	
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; set up coroutine
;
;	ld de,task1_sp_save             
;	ld hl,task1_sp_top
;	ld bc,task1_code

setup_task:
	ld (hl),b
	dec hl
	ld (hl),c

	xor a
	ld b,8
setup_task_null:
	dec hl
	ld (hl),a
	djnz setup_task_null		; stored intial registers on stack	

	ex de,hl
	ld (hl),e
	inc hl
	ld (hl),d			; store stack pointer in saved location    

	ret				; all done		   

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     			    	
task1_sp_save equ $+1
	ld sp,0
	      
task2_sp_save equ $+1
	ld sp,0
	      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

task1_sp_top equ #7ff
task2_sp_top equ #6ff

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

task1_code:
	;halt
	
	ld bc,#7f10
	out (c),c
	
	ld d,#44

task1_loop:	
;	inc d
	res 7,d
	set 6,d
	out (c),d
;	nop
;	nop
	
	ld a,d
	and #3f
	jr nz, task1_code

;	rst #20			; swap 
	
        jr task1_code

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

task2_code:
	;halt
	
	ld bc,#7f10
	out (c),c
	
	dec d
	res 7,d
	set 6,d
	out (c),d
	
task2_zzz:
	djnz task2_zzz
	
        jr task2_code


scroller_pos: defw #3002	
	     			    	
	     			    	
aaa_end:
	     			    	
