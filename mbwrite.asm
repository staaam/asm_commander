;cseg    segment byte
;assume  cs:cseg,ds:cseg
;        org     100h
startmbrwrite:
        push    cs cs
        pop     ds es
        mov     ax,3d00h
        mov     DX,OFFSET fNmbr
        int     21h
        jc      err_mbr
        mov     bx,ax
        mov     ah,3fh
        mov     cx,200h
        mov     dx,offset bufmbr
        int     21h
        jc      err_mbr
        cmp     ax,cx
        jnz     err_mbr
        mov     ah,3eh
        int     21h


        mov     ax,301h
        xor     dx,dx
        xor     cx,cx
        push    cs
        pop     es
        mov     bx,offset bufmbr
        mov     dl,80h
        mov     cl,1
        int     13h
        jc      fat_mbr

;        mov     ah,09h
;        mov     dx,offset mesmbr
;        int     21h


exitmbr:
        ret
err_mbr:
;        mov     dx,offset errormbr

pointmbr:
;        mov     ah,09h
;        push    cs
;        pop     ds
;        int     21h
        jmp     exitmbr
fat_mbr:
;        mov     dx,offset fatalmbr
        jmp     pointmbr

fnmbr      DB      'mbr.sec',0
bufmbr     db      200h dup (?)
mesmbr     db      10,13,'Ok. $'
errormbr   db      10,13,'*** Error *** $'
fatalmbr   db      10,13,'**** Warning ! Fatal error.Don^t reboot! **** $'
;cseg    ends
;        end start


