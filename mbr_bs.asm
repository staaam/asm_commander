MbrAndBr proc
       mov      ah,2
       mov      bh,3
       mov      dx,2500h
       int      10h
       push     0b800h
       pop      es
       mov      di,50+9*160
       lea      si,Tabl1
       mov      ah,0ah
       mov      cx,30
OOP__1:
       lodsb
       stosw
loop   OOP__1
       add      di,100
       mov      cx,30
       lea      si,Tabl2
OOP__2:
       lodsb
       stosw
loop   OOP__2
       add      di,100
       mov      cx,30
       lea      si,Tabl3
OOP__3:
       lodsb
       stosw
loop   OOP__3
       add      di,100
       mov      cx,30
       lea      si,Tabl4
OOP__4:
       lodsb
       stosw
loop   OOP__4
       add      di,100
       mov      cx,30
       lea      si,Tabl5
OOP__5:
       lodsb
       stosw
loop   OOP__5
       add      di,100
       mov      cx,30
       lea      si,Tabl6
OOP__6:
       lodsb
       stosw
loop   OOP__6
       push     cs
       pop      es
OOOPPP000:
       mov      ah,0
       int      16h
       cmp      ah,2
       jne      OOOPPP001
       call     startmbrread
        mov     Poscount, -1
        mov     Filecount, -1
        mov     Poscountright, -1
        mov     Filecountright, -1
        call    ScrMov
        call    Findright
        call    Sortdirright
        call    Findleft
        call    Sortdir
        call    Putname
        call    Putnameright
        call    Mover
       jmp      OOOPPP004
OOOPPP001:
       cmp      ah,3
       jne      OOOPPP002
       call     start_read
        mov     Poscount, -1
        mov     Filecount, -1
        mov     Poscountright, -1
        mov     Filecountright, -1
        call    ScrMov
        call    Findright
        call    Sortdirright
        call    Findleft
        call    Sortdir
        call    Putname
        call    Putnameright
        call    Mover
       jmp      OOOPPP004
OOOPPP002:
       cmp      ah,4
       jne      OOOPPP003
       call     startmbrwrite
       jmp      OOOPPP004
OOOPPP003:
       cmp      ah,5
       je       OOOPPP005
       jmp      OOOPPP000
OOOPPP005:
       call     startwrite
OOOPPP004:
       call     Path
       call     ScrChg
       ret
Tabl1  db       'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
Tabl2  db       '³1. Read MasterBoot Sector.  ³'
Tabl3  db       '³2. Read Boot Sector.        ³'
Tabl4  db       '³3. Write MasterBoot Sector. ³'
Tabl5  db       '³4. Write Boot Sector.       ³'
Tabl6  db       'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
MbrAndBr endp