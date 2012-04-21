
                  org #0800

vsyncpos          equ 3
blankgaps         equ 1

char_width        equ 46
render_base_high  equ #a0
render_left_offset equ 3 
render_width      equ 2*40
render_height     equ 50
screen_base       equ #0080
screen_width      equ 2*char_width
render_func       equ render_base_high*256

hpos              equ 49     ; 49 maximum for crtc 2, 50 best for other crtc

screen1_hi        equ #00
screen1_lo        equ #40
screen2_hi        equ #30
screen2_lo        equ #00
screen3_hi        equ #20
screen3_lo        equ #00

; 5 bytes / 6 cycles per pixel: ld a,#xx/xor #xx, ld (#yyyy),a
;
; 6*52*64 cycles per frame, so maximum is 52*64 = 3328 max
; realistically 64*48 would be a good maximum (32x24)
;
; currently demo is 4*52+10 = 218 lines, want 192 lines
; old linear demo had 6 pixel lines, 29 high, 60 across 
;
; each line is 4 pixels high, so 256 cycles = 42 pixels (enough for 168 vertical)
;
; 80 across is #50, 96 across is #60, so #a000 upwards for pixel write code
; have sliding horizontal window - render 0..59 or 36..95 or between
;
; 50*96 = 4800 bytes = #12c0, so about 2.5 pixel-line screens (2048 bytes/16kb)
; alternatively, we have #1780 bytes = 6016 = 62.66 lines of 96 bytes
; maximum for 5 bytes/pixel = 50 high
; maybe 46x4,16x2 -> 216 high
;
; or #f80 = 3968 = 41*1 lines (0080-07ff,4000-47ff) -> 164 pixel lines
; and 21*3 lines (8000-97ff) or 21*4 (8000-9fff) for scroller
;
; 1st visible interrupt, 4*52+13 is roughly centred = 221 lines
; subtract 32 = 189 (47*4)
; or 26 normal lines, shifted up one (reset, r6=26, r7=31) is 208 pixels
; subtract 32 = 176 = 44*4
;
; clears:
; lh (hl),a ; inc h = 3 cycles per pixel
; 9*52*64 = 28800 cycles compared to 19968 per frame = 1.44 frames (468 lines)
; comapred to push / pop / ld (hl),a = 4+3+2 = 9 per pixel
;
; or:
; xor (hl) ; ld (hl),e ; inc h ; ld (#xxxx),a = 2+2+1+4 = 9 cycles per pixel
;
; if we do: xor (hl) ; inc h ; ld (#xxxx),a = 2+1+4 = 7 per pixel but can clear
; we push (4 cycles per pixel again)
;
; timings:
;
; frame 1:
;         quite a bit of stuff, with line doubling code
;         near bottom, start rendering top of next frame
;         vsync = non sync'ed code
; frame 2:
;         middle of frame rendering
;         bottom of frame rendering
;         pops and clears and/or prepare scrolltext stuff
;         vsync = non sync'ed code

; normal hpos=46 for 40 character screen
; max hpos=49, so 3 characters to the left, still have 1 visible
; visible width is 46, 3 either side makes normal 40
; |-3-|-------------------- data --------------------|-3-|


          di
          ld sp,#a000

        call create_render

        ld a,#ff
        ld (render_func+#001),a
        ld (render_func+#006),a
        ld (render_func+#156),a
        ld (render_func+#15b),a
        ld (render_func+#201),a
        ld (render_func+#25b),a
        ld (render_func+#301),a
        ld (render_func+#30b),a
        
        call render_func          


        di
        ld hl,#c3fb			; ei : jp intvec
        ld (#38),hl
        ld hl,int_null
        ld (#3a),hl

        ld bc,#bc00 + 6
        out (c),c
        ld bc,#bd00 + 0		; nothing displayed
        out (c),c
        
        ld bc,#bc00 + 9
        out (c),c
        ld bc,#bd00 + 0
        out (c),c		; screen lines = raster lines
        
        ld bc,#bc00 + 2
        out (c),c
        ld bc,#bd00 + hpos
        out (c),c		; horizontal position
        
        ld bc,#bc00 + 7
        out (c),c
        ld bc,#bd00 + 52-vsyncpos     ; vsync 2 line before the end of the frame 
        out (c),c

        ld bc,#bc00 + 4
        out (c),c
        ld bc,#bd00 + 51
        out (c),c		; screen is 52 lines high
        

         ei
         halt
         halt
         halt

        ld hl,int_initial
        ld (#3a),hl
        
        ld bc,#7f10
        xor a
newmainloop:
        ld de,#4445
        out (c),a

        out (c),e
        out (c),d
        inc e
        
        out (c),e
        out (c),d
        inc e
        
        out (c),e
        out (c),d
        inc e
        
        out (c),e
        out (c),d
        inc e
        
        out (c),e
        out (c),d
        inc e
        
        out (c),e
        out (c),d
        inc e
        
        out (c),e
        out (c),d
        inc e
        
        out (c),e
        out (c),d
        inc e
        
        out (c),c
            
        halt
        jr newmainloop        

int_null:
       ret
       
int_initial:
        push bc
        ld bc,#bc00 + 4
        out (c),c
        ld bc,#bd00 + 52+52-1
        out (c),c		; screen is 52 lines high

        ld bc,int_vsync
        ld (#3a),bc

        ld bc,#7f10            ; select border colour reg as default
        out (c),c

        pop bc
        ei
        ret


int_vsync:
        push bc

        ld bc,#7f54             ; border black
        out (c),c

        ld bc,#bc00 + 12
        out (c),c
        ld bc,#bd00 + screen1_hi
        out (c),c
        
        ld bc,#bc00 + 13
        out (c),c
        ld bc,#bd00 + screen1_lo
        out (c),c               ; display for part 1

        ld bc,#bc00 + 7
        out (c),c
        ld bc,#bd00 + #ff      ; no vysnc 
        out (c),c

        ld bc,int_part1
        ld (#3a),bc
        
        pop bc
        ei
        ret
        
int_part1:
        push bc                  

        ld bc,#7f48
        out (c),c

        push de
        push hl
        push af
        ld (part1_spsave),sp

        ld bc,#bc00 + 6
        out (c),c
        ld bc,#bd00 + 52+52 - blankgaps		; display full amount
        out (c),c

        ld bc,int_mid1
        ld (#3a),bc

        ld bc,#bc00 + 1
        out (c),c
        ld bc,#bd00 + char_width                  ; char 2
        out (c),b		; repeat lines    ; char 6

                                                  ; +66 to here
        ei                                        ; +67 to here  
        
part1_vector equ $+1
        jp empty_part                             ; +70 to here     

int_mid1:
        out (c),c               ; back to normal line

        ld bc,#7f41
        out (c),c

        ld bc,#bc00 + 12
        out (c),c
        ld bc,#bd00 + screen2_hi
        out (c),c
        
        ld bc,#bc00 + 13
        out (c),c
        ld bc,#bd00 + screen2_lo
        out (c),c               ; display for part 2

        ld bc,int_part2
        ld (#3a),bc
                
        ei
        halt
        
int_part2:
        ld bc,#7f42
        out (c),c

        ld bc,int_mid2
        ld (#3a),bc
        
        ei
        halt

int_mid2:
        ld bc,#7f43
        out (c),c

        ld bc,#bc00 + 12
        out (c),c
        ld bc,#bd00 + screen3_hi
        out (c),c
        
        ld bc,#bc00 + 13
        out (c),c
        ld bc,#bd00 + screen3_lo
        out (c),c               ; display for part 3

        ld bc,int_part3
        ld (#3a),bc
        
        ei
        halt
        
int_part3:
        ld bc,#7f4d
        out (c),c

        ld bc,#bc00 + 6
        out (c),c
        ld bc,#bd00 + 13; 2; 32 ;10		; partial display
        out (c),c

        ld bc,#bc00 + 7
        out (c),c
        ld bc,#bd00 + 52-vsyncpos     ; vsync 2 line before the end of the frame 
        out (c),c

        ld bc,int_vsync
        ld (#3a),bc
        
        ld sp,(part1_spsave)
        pop af
        pop hl
        pop de
        
        pop bc
        ei
        ret

empty_part:
        halt

create_render:
        ld hl,render_base_high*256
        ld c,render_width
        ld de,screen_base+render_left_offset
create_render_column:
        ld b,render_height
        push de   
        ld a,#3e                     ; 3E = ld a,x
create_render_row:
        ld (hl),a
        inc hl
        xor a

;        ld a,h
;        sub b

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
        and #8
        jr z,no_overflow
        ld a,#38
        add d
        ld d,a                       ; only use first #800 bytes in every #4000

no_overflow:        
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

              
                            
part1_spsave:
        defs 2                 

                                     
