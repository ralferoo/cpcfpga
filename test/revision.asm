
        org #4000

vsyncpos equ 3
blankgaps equ 1

render_base_high  equ #50
render_width      equ 2*40
render_height     equ 50
screen_base       equ #c000
screen_width      equ 2*40
render_func       equ render_base_high*256

        call create_render

        ld a,#ff
        ld (#5001),a
        ld (#5006),a
        ld (#5156),a
        ld (#515b),a
        ld (#5201),a
        ld (#525b),a
        ld (#5301),a
        ld (#530b),a
        
        call render_func          


        di
        ld hl,&c3fb			; ei : jp intvec
        ld (&38),hl
        ld hl,intvec
        ld (#3a),hl

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
        ld bc,&bd00 + 46
        out (c),c		; horizontal position
        
        ld bc,&bc00 + 7
        out (c),c
        ld bc,&bd00 + 52-vsyncpos     ; vsync 2 line before the end of the frame 
        out (c),c

        ld bc,&bc00 + 4
        out (c),c
        ld bc,&bd00 + 51
        out (c),c		; screen is 52 lines high
        

         ei
         halt
         halt
         halt

        ld hl,int0
        ld (#3a),hl
        
newmainloop:
        halt
        jr newmainloop        
            

	ld d,#48

testloop:
         ei
         halt

	ld bc,130			; 3

pause:	dec bc				; 2
	ld a,b				; 1
	or c				; 1
	jr nz, pause			; 3 = 7 per loop


	ld bc,#7f10
	out (c),c
	out (c),d			; 11
	inc d
	res 5,d				; 3

        ld bc,&bc00 + 7
        out (c),c

        ld e,b

	ld a,#4a
	cp d
	jr nz,dovsync
	ld d,#44

        ld e, 52-vsyncpos     ; vsync 2 line before the end of the frame 

dovsync:
        inc b
        out (c),e
         
         jr testloop
                         
intvec:
       ret
                                
                                
int0:
     exx
     ld hl,int1
     ld (#3a),hl
     
     ld bc,#7f10
     out (c),c
     ld c,#54
     out (c),c
     
        ld bc,&bc00 + 7
        out (c),c
        inc b
        out (c),b                     ; disable vsync

        ld bc,&bc00 + 6
        out (c),c
        ld bc,&bd00 + 0		; display nothing
        out (c),c
        
    exx
    ret
    
int1:
     exx
     ld hl,int2
     ld (#3a),hl
     
     ld bc,#7f10
     out (c),c
     ld c,#48
     out (c),c

        ld bc,&bc00 + 6
        out (c),c
        ld bc,&bd00 + 52 - blankgaps		; display full amount
        out (c),c

    exx
    ret
    
int2:
     exx
     ld hl,int3
     ld (#3a),hl
     
     ld bc,#7f10
     out (c),c
     ld c,#41
     out (c),c

    exx
    ret
    
int3:
     exx
     ld hl,int4
     ld (#3a),hl
     
     ld bc,#7f10
     out (c),c
     ld c,#42
     out (c),c

    exx
    ret
    
int4:
     exx
     ld hl,int5
     ld (#3a),hl
     
     ld bc,#7f10
     out (c),c
     ld c,#43
     out (c),c

    exx
    ret
    
int5:
     exx
     ld hl,int0
     ld (#3a),hl
     
     ld bc,#7f10
     out (c),c
     ld c,#4d
     out (c),c
        
        ld bc,&bc00 + 7
        out (c),c
        ld bc,&bd00 + 52-vsyncpos     ; vsync 2 line before the end of the frame 
        out (c),c

        ld bc,&bc00 + 6
        out (c),c
        ld bc,&bd00 + 10		; partial display
        out (c),c
        
    exx
    ret
            

create_render:
        ld hl,render_base_high*256
        ld c,render_width
        ld de,screen_base
create_render_column:
        ld b,render_height
        push de   
        ld a,#3e                     ; 3E = ld a,x
create_render_row:
        ld (hl),a
        inc hl
        xor a
        ld (hl),a
        inc hl                       ; ld a,0 / xor 0
        ld (hl),#32                  ; 32 = LD (xxxx),a
        inc hl
        ld (hl),e
        inc hl
        ld (hl),d
        inc hl
        
        ld a,screen_width
        add a,e
        ld e,a
        ld a,d
        adc a,0
        ld d,a                       ; DE += screen_width
        
        ld a,#ee                     ; EE = xor #xx
        djnz create_render_row

        dec c
        ld a,c
        or a
        jr z,create_render_end 

        ld (hl),#c3                  ; C3 = jp #xxxx
        inc hl
        ld b,0
        ld (hl),b
        inc hl
        ld a,h
        inc a
        ld (hl),a                    ; JP to next block
        
        ld h,a
        ld l,b                       ; advance ip to next block

        pop de
        inc de
        jr create_render_column
       
create_render_end:        
        ld (hl),#c9                  ; C9 = ret
        pop de
        ret
              
                            
                                     
