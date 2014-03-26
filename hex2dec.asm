adword  proc
        .386
        cmp     dx,0
        je      aword
        xchg    eax,edx
        mov     ecx,10000h
        push    edx
        mul     ecx
        pop     edx
        add     eax,edx
NextDword:
        mov     edx,0
        mov     ecx,10
        div     ecx
        xchg    eax,edx
        add     al,30h
        stosb
        xchg    eax,edx
        mov     ecx,0
        mov     cx,ax
        cmp     ecx,eax
        jne     NextDword
        .286
        call    aword
        ret
adword  endp

aword    proc
        mov     dx,0
        mov     cx,10
        div     cx
        xchg    ax,dx
        add     al,30h
        stosb
        xchg    ax,dx
        cmp     ah,0
        jne     aword
        call    abyte
        ret
aword    endp

abyte    proc
        cmp     ax,0
        je      ByteExit
        mov     cx,10
        div     cl
        xchg    ah,al
        add     al,30h
        stosb
        mov     al,0
        cmp     ax,0
        je      ByteExit
        xchg    ah,al
        div     cl
        xchg    ah,al
        add     ax,3030h
        stosb
        cmp     ah,30h
        je      ByteExit
        xchg    ah,al
        stosb
ByteExit:
        ret
abyte    endp