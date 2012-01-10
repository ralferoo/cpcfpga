        org #4000

; transfer 16K of data from #7c000 on memory chip to #c000 and jump to it

        ld bc,#fade
        ld a,ixl
        inc ix
        out (c),a

        ld a,'~'
        ld c,#dc
        out (c),a

        ld de,#0307                             ; D=READ
        ld hl,#c000                             ; EHL = transfer address

        ld bc,#feff
        out (c),c                               ; ensure SPI bus is idle

        out (c),b                               ; turn on flash rom CE
        inc b                                   ; change to SPI data port
        out (c),d                               ; READ data bytes
        out (c),e                               ; addr 1
        out (c),h                               ; addr 2
        out (c),l                               ; addr 3

        dec hl  ;       in a,(c)                ; dummy read
xferloop:
        in a,(c)
        ld (hl),a
        inc hl

        ld a,h
        or l
        jr nz,xferloop

        dec b
        out (c),c                               ; finish with SPI bus

        jp #c000

