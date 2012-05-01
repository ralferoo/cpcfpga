        org #4000
        
        ld hl, noise
        ld bc,13*256
regloop:        
        ld a,(hl)
        inc hl
        push bc
        call write_to_psg
        pop bc
        inc c
        djnz regloop
        
;        ret

         ld c,7
         ld a,#37
         call write_to_psg

       ld a,#f         
toggle:
       ld c,8
       call write_to_psg
;       xor #f
       halt
;       halt
;       halt
       jr toggle
       
         ret

noise:
      defb #0c,#00
      defb #cc,#02
      defb #0d,#00
      defb #12
      defb #20
      defb #00,#00,#00
;      defb #0c,#10,#0c
      defb #5a,#00
      defb #08

write_to_psg:
             ld b,&f4            ; setup PSG register number on PPI port A
             out (c),c           ;

             ld bc,&f6c0         ; Tell PSG to select register from data on PPI port A
             out (c),c           ;

             ld bc,&f600         ; Put PSG into inactive state.
             out (c),c           ;

             ld b,&f4            ; setup register data on PPI port A
             out (c),a           ;

             ld bc,&f680         ; Tell PSG to write data on PPI port A into selected register
             out (c),c           ;

             ld bc,&f600         ; Put PSG into inactive state
             out (c),c           ;
             ret
             