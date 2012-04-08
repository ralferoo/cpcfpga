
        org #4000

vsyncpos equ 3
blankgaps equ 1

	ld a,#ff
	ld (#c000),a
	ld (#c028),a
	ld (#c050),a

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
            

                                     
