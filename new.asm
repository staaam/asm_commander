PutPath proc
        lea     si,PathLeft
        push    si
        mov     Counter,0
        call    GetLength
        cmp     Counter,32
        jng     Normal
Normal:
        int     3
        mov     al,40
        sub     al,Counter
        mov     ah,0
        mov     cl,2
        div     cl
        add     al,al
        mov     ah,0
        mov     di,ax
        add     di,offset Screen
        pop     si
        mov     cl,Counter
        mov     ch,0
        mov     ax,2100h
        stosw
@123456:
        movsb
        mov     al,21h
        stosb
loop    @123456
        mov     ax,2100h
        stosw
        ret
Counter         db      ?
PutPath endp

GetLength proc
        lodsb
        cmp     al,0
        je      Next
        inc     Counter
        jmp     GetLength
Next:
        ret
GetLength endp
