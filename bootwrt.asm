startwrite:
        push       cs cs
        pop        ds es
        xor        dx,dx
        xor        cx,cx
        mov        dl,80h
        mov        cl,1
        mov        bx,offset bufwrite
        mov        ax,201h
        int        13h
        add        bx,1beh
        mov        si,bx
        mov        cx,4
lbootwrite:
        cmp        byte ptr ds:[si],80h
        je         elwr
        add        si,10h
loop       lbootwrite
        jmp        err_wr
elwr:
        mov        ax,ds:[si]
        mov        word ptr ds:dx_,ax
        mov        ax,ds:[si][2]
        mov        word ptr ds:[cx_],ax
        mov     ax,3d00h
        mov     dx,offset filenn
        int     21h
        mov     bx,ax
        jc      err_wr
        mov     ah,3fh
        mov     cx,200h
        mov     dx,offset bufwrite
        int     21h
        jc      err_wr
        cmp     ax,cx
        jnz    err_wr
        mov     ah,3eh
        int     21h
        jc      err_wr
        mov     cx,word ptr ds:[cx_]
        mov     dx,word ptr ds:[dx_]
        mov     bx,offset bufwrite
        mov     ax,301h
        int     13h
        jc      fatal_wr
        jmp     okwrit_
exitwr:
        ret
err_wr:
;        mov     dx,offset error_write
wr:
;        push    cs
;        pop     ds
;        mov     ah,09h
;        int     21h
        jmp     exitwr
okwrit_:
;        mov     dx,offset ok_write
        jmp     wr
fatal_wr:
;        mov     dx,offset fatal
        jmp     wr
ok_write      db      10,13,'Ok. $'
error_write   db      10,13,'**** Error **** $'
fatal   db      10,13,'***** Warning ! Fatal error. Don^t reboot ! ***** $'
filenn      db      'boot.sec',0
cx_     dw      ?
dx_     dw      ?
bufwrite     db      200h dup (?)
        db      '$'
;end     startwrite
