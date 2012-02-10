
; test interrupt driven split screen

	org #4000

vsync_time		equ 35		; 30 = first visible at top, 25 = first visible after vsync
screen_height		equ 261		; total visible height of all 3 screens
inter_screen_gap	equ 1		; creates a gap between the smaller screens
split_height		equ 104
	
intvec	equ #39

hpos equ 48	; 49 maximum for crtc 2, 50 best for other crtc

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

width equ 16

	ld bc,&bc01
        out (c),c
	ld bc,&bd00+width
        out (c),b


	; enable interrupts so we can wait for interrupts

	ei


	ld hl,#4000
	call fill	
	ld hl,#8000
	call fill	
	ld hl,#c000
	call fill	

	ld bc,#7f10
	out (c),c

waste:	halt

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

	ld bc,#7f42		; green
   	out (c),c

	ld hl,int1
	ld (intvec),hl

	exx     
	ei
	ret

int1:
	exx     

	ld bc,#7f45		; pink 
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

	ld bc,#7f57		; darky blue
	out (c),c

	ld hl,int3
	ld (intvec),hl

	exx     
	ei
	ret

int3:
	exx     

	ld bc,#7f43		; yellow
	out (c),c

	ld hl,int4
	ld (intvec),hl

	exx     
	ei

	jr coroutine_swap
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

	ld bc,#7f46		; dirty green
	out (c),c

	ld hl,int5
	ld (intvec),hl

	exx     
	ei
	
	jr coroutine_swap
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

	ld bc,#7f47		; pink
	out (c),c

	ld hl,int0
	ld (intvec),hl

	exx     
	ei
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
	
	inc d
	res 7,d
	set 6,d
	out (c),d
	
	ld a,d
	and #1f
	jr nz, task1_code
	
	rst #20			; swap 
	
        jr task1_code

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

task2_code:
	;halt
	
	ld bc,#7f01
	out (c),c
	
	dec d
	res 7,d
	set 6,d
	out (c),d
	
task2_zzz:
	djnz task2_zzz
	
        jr task2_code


	     			    	
	     			    	
