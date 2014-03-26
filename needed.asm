SetDfltDir proc
;Устанавливает текущий диск и каталог
;  DS:DX <- полный путь и каталог
;           ^^^^^^
        push    ax si dx dx
        pop     si
        lodsb
        sub     al,41h
        mov     dl,al
        mov     ah,0eh
        int     21h
        mov     ah,3bh
        pop     dx
        int     21h
        pop     si ax
        ret
SetDfltDir endp