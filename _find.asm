        .286
        .model  tiny
        .code
        org     100h
Entry:
        mov     ah,3bh
        lea     dx,direct
        int     21h
        jc      Exit
        lea     bp,DTA


        mov     dx,bp
        mov     ah,1ah
        int     21h

        mov     ah,4eh
        lea     dx,file
        mov     cx,37h
        int     21h
        jc      Exit
        mov     al,byte ptr ds:[bp+15h]
        rol     al,4
        jnc     FileFound
;-------====== DIRECTORY ======-------

FileFound:

        

Exit:
        int     20h
MyConvert       proc

;в SI адрес откуда, в DI куда
        push    si
        mov     cx,8
Next:
        lodsb
        cmp     al,'*'
        je      Zorachka
        cmp     al,'.'
        je      ExitLoop
        stosb
loop    MyConvertNext
ExitLoop:
        mov     al,'?'
        rep     stosb
Zorachka:

        ret
MyConvert       endp

        
direct          db      '\',0
file            db      '*.*',0
fname           db      '????????.TXT',0

DTA:
end     Entry
end.