start_read:
        push       cs cs
        pop        ds es
        xor        dx,dx
        xor        cx,cx
        mov        dl,80h
        mov        cl,1
        mov        bx,offset bufread
        mov        ax,201h
        int        13h
        add        bx,1beh
        mov        si,bx
        mov        cx,4
bootreadl:
        cmp        byte ptr ds:[si],80h
        je         readel
        add        si,10h
loop    bootreadl
        jmp        err_read
readel:
        mov        dx,ds:[si]
        mov        cx,ds:[si][2]
        mov        ax,201h
        mov        bx,offset bufread
        int        13h
        jc         err_read
        mov        ah,3ch
        mov        cx,0
        mov        dx,offset filen
        int        21h
        mov        bx,ax
        mov        ah,40h
        mov        dx,offset bufread
        mov        cx,200h
        int        21h
        jc         err_read
        cmp        ax,cx
        jnz        err_read
        mov        ah,3eh
        int        21h
        jmp        okread_
exitread:
        ret
err_read:
;        mov     dx,offset errorwrite
wrread:
;        push    cs
;        pop     ds
;        mov     ah,09h
;        int     21h
        jmp     exitread
okread_:
;        mov     dx,offset okwrite
        jmp     wrread
okwrite      db      10,13,'Ok. $'
errorwrite   db      10,13,'**** Error **** $'
filen      db      'boot.sec',0
bufread     db      200h dup (?)
        db      '$'
;end     start_read
