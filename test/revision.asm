
        org #4000

vsyncpos equ 17

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
        ld bc,&bd00 + 10		; nothing displayed
        out (c),c
        
        ld bc,&bc00 + 9
        out (c),c
        ld bc,&bd00 + 0
        out (c),c		; screen lines = raster lines
        
        ld bc,&bc00 + 2
        out (c),c
        ld bc,&bd00 + 48
        out (c),c		; horizontal position
        
        ld bc,&bc00 + 7
        out (c),c
        ld bc,&bd00 + 52-vsyncpos     ; vsync 2 line before the end of the frame 
        out (c),c

        ld bc,&bc00 + 4
        out (c),c
        ld bc,&bd00 + 51
        out (c),c		; screen is 52 lines high
        
            

	ld d,#40

testloop:
         ei
         halt

	ld bc,130			; 3
peak
pause:	dec bc				; 2
	ld a,b				; 1
	or c				; 1
	jr nz, pause			; 3 = 7 per loop


	ld bc,#7f10
	out (c),c
	out (c),d			; 11
	inc d
	res 5,d				; 3


	ld a,#46
	cp d
	jr nz,testloop
	ld d,#40

         
         jr testloop
                         
intvec:
       ret
                                
