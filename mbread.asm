startmbrread:
        push    cs cs
        pop     ds es
        mov     bx,offset bufmbrread
        mov     dl,80h
        mov     ax,201h
        xor     dh,dh
        xor     cx,cx
        mov     cl,1
        int     13h

        mov     ah,3ch
        mov     dx,offset fnmbrread
        mov     cx,0
        int     21h
        jc      err_
        mov     bx,ax
        mov     ah,40h
        mov     cx,200h
        mov     dx,offset bufmbrread
        int     21h
        jc      err_
        mov     ah,3eh
        int     21h

;        mov     ah,09h
;        mov     dx,offset mes
;        int     21h


exit:
            ret
err_:
;        mov     ah,09h
;        push    cs
;        pop     ds
;        mov     dx,offset errormbrread
;        int     21h
        ret
fnmbrread      DB      'mbr.sec',0
bufmbrread     db      200h dup (?)
mes     db      10,13,'Ok. $'
errormbrread   db      10,13,'*** Error *** $'
;cseg    ends
;        end startmbrread


