        .286
        .model  Tiny
        .code
        org     100h
Entry:
        jmp     Boot
vyvod db 'КОЛИЧЕСТВО НАЙДЕННЫХ ФАЙЛОВ--'
      dw 2 dup  (0)
total dw 0
kil db 0
InsOrNot        dw 0
ExeExtent       db 'EXE'
BatExtent       db 'BAT'
ComExtent       db 'COM'
RightDisk       db ?
LeftDisk        db ?
Column          db 0                    ;0=LEFT   1=RIGHT
ChgDisk1        db '┌────────┐'
ChgDisk2        db '│      │'
ChgDisk3        db '└────────┘'
DiskInfo        db 27 dup('$')
Filetoexec      db 13 dup (0)
;Dta             db 2Ch dup(0)
Olddir          db 14 dup(0)
_Temp_          dw 0
_Temp_1         dw 0
_Temp_2         dw 0
Extoff          dw 0
Extoffright     dw 0
Filecount       dw -1
Filecountright  dw -1
Frameaddr1      dw ?
Frameaddr2      dw ?
Handleemm1      dw ?
Handleemm2      dw ?
Addreg          db ?
Pathb           db 64 dup (0)
Namef           db '*.*', 0
Poscount        db -1
Poscountright   db -1
NumDisk         dw 0
Ramka           db 2 dup ('╔════════════╤════════════╤════════════╗')
                db 2 dup ('║    Name    │    Name    │    Name    ║')
                db 34 dup ('║            │            │            ║')
                db 2 dup ('╟────────────┴────────────┴────────────╢')
                db 4 dup ('║                                      ║')
                db 2 dup ('╚══════════════════════════════════════╝')
                db 160 dup (' ')
Screen          db 4000 dup (0)
Attr            db ?
Pointer         db 0
Pointerright    db 0
Pathright       db 67 dup (0)
Pathleft        db 67 dup (0)
pan_st  db      '╔══════════════════════════════ Поиск файла ═══════════════════════════════╗',0
        db      '║                                                                          ║',0
        db      '║                                                                          ║',0
        db      '║                                                                          ║',0
        db      '║                                                                          ║',0
        db      '║                                                                          ║',0
        db      '║                                                                          ║',0
        db      '║                                                                          ║',0
        db      '║                                                                          ║',0
        db      '║                                                                          ║',0
        db      '╟──────────────────────────────────────────────────────────────────────────╢',0
        db      '║ Найти файл(ы) [························································] ║',0
        db      '║ Каталог:                                                                 ║',0
        db      '║ Содержащие    [·································]                        ║',0
        db      '╟──────────────────────────────────────────────────────────────────────────╢',0
        db      '║  ┌ Место поиска ──────────────┐   ┌ Опции поиска ────────┐               ║',0
        db      '║  │ ( ) Весь диск              │   │ [ ] Поиск повторов   │               ║',0
        db      '║  │ ( ) Каталог(и) и ниже      │   │ [ ] Только текст     │               ║',0
        db      '║  └────────────────────────────┘   └──────────────────────┘               ║',0
        db      '║                                                                          ║',0
        db      '╟──────────────────────────────────────────────────────────────────────────╢',0
        db      '║       Cтарт  ▄   Диск  ▄   F10-Дерево  ▄   Расшиpенный  ▄   Выход  ▄     ║',0
        db      '║      ▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀     ║',0
        db      '╚══════════════════════════════════════════════════════════════════════════╝',0
@write   db      '╔═══════════════════════════════════════════════════════════════╗',0
         db      '║ ███╗   ██╗  ██████╗    ███████╗ ██╗ ██╗      ███████╗ ███████╗║',0
         db      '║ ████╗  ██║ ██╔═══██╗   ██╔════╝ ██║ ██║      ██╔════╝ ██╔════╝║',0
         db      '║ ██╔██╗ ██║ ██║   ██║   █████╗   ██║ ██║      █████╗   ███████╗║',0
         db      '║ ██║╚██╗██║ ██║   ██║   ██╔══╝   ██║ ██║      ██╔══╝   ╚════██║║',0
         db      '║ ██║ ╚████║ ╚██████╔╝   ██║      ██║ ███████╗ ███████╗ ███████║║',0
         db      '║ ╚═╝  ╚═══╝  ╚═════╝    ╚═╝      ╚═╝ ╚══════╝ ╚══════╝ ╚══════╝║',0
         db      '╚═══════════════════════════════════════════════════════════════╝',0
cart1 proc
        mov     ax,4400h
        mov     bx,0
        mov     dx,pathemm
        int     67h

        mov     ax,4400h
        mov     bx,0
        mov     dx,pathemm
        int     67h

        mov     ax,4400h
        mov     bx,0
        mov     dx,pathemm
        int     67h

        mov     ax,4400h
        mov     bx,0
        mov     dx,pathemm
        int     67h
        ret
cart1 endp

cart2 proc
        mov     ax,4400h
        mov     bx,2
        mov     dx,PathEMM
        int     67h

        mov     ax,4400h
        mov     bx,2
        mov     dx,pathEMM
        int     67h

        mov     ax,4400h
        mov     bx,2
        mov     dx,pathEMM
        int     67h

        mov     ax,4400h
        mov     bx,2
        mov     dx,pathEMM
        int     67h
        ret
cart2 endp

save_path_in_emm proc
;     int 3h
     push ds
     push es
     push cs:[addrpathframe]
     pop es
     mov di,cs:[boroda1]
                 call cart1
     mov bx,cs:[razmer]
     inc bx
     add cs:[boroda1],bx
     lea si,old1path
     dec bx
     mov cx,bx
     rep movsb
     mov bx,cs:[razmer]
     mov cx,64
     sub cx,bx
     @@@a:
          mov byte ptr es:[di],0ffh
          inc di
          loop @@@a
     mov byte ptr es:[di],0
     inc di
     mov cs:[boroda1],di
     pop es ds
     call cart1
     call clear_old
     ret
save_path_in_emm endp

clear_old proc
     push ds
     push es
     lea si,old1path
     cld
     mov cx,64
@clea:
       mov byte ptr ds:[si],0
       inc si
       loop @clea
       pop es
       pop ds
ret
clear_old endp


Copy    proc
        cmp     Column,0
        jne     CopyRight
        lea     si,PathLeft
        lea     di,CopySour
CopyLeftRep:
        movsb
        cmp     byte ptr ds:[si],0
        jne     CopyLeftRep
        cmp     byte ptr ds:[di-1],'\'
        je      SlashIs
        mov     byte ptr ds:[di],'\'
        inc     di
SlashIs:
        mov     al,pointer
        mov     ah,0
        add     ax,extoff
        mov     cx,14
        mul     cx
        inc     ax
        mov     si,ax
        call    CartLeft
        mov     cx,13
        push    ds
        push    word ptr cs:[Frameaddr1]
        pop     ds
        rep     movsb
        pop     ds
;        int     3
        lea     si,PathRight
        lea     di,CopyDest
CopyRightRep:
        movsb
        cmp     byte ptr ds:[si],0
        jne     CopyRightRep
        cmp     byte ptr ds:[di-1],'\'
        je      SlashIs1
        mov     byte ptr ds:[di],'\'
        inc     di
SlashIs1:
        mov     al,pointer
        mov     ah,0
        add     ax,extoff
        mov     cx,14
        mul     cx
        inc     ax
        mov     si,ax
        call    Cartleft
        mov     cx,13
        push    ds
        push    Frameaddr1
        pop     ds
        rep     movsb
        pop     ds
        jmp     MainCopyProc
CopyRight:
        lea     si,PathLeft
        lea     di,CopyDest
CopyLeftRep11:
        movsb
        cmp     byte ptr ds:[si],0
        jne     CopyLeftRep11
        cmp     byte ptr ds:[di-1],'\'
        je      SlashIs2
        mov     byte ptr ds:[di],'\'
        inc     di
SlashIs2:
        mov     al,pointerright
        mov     ah,0
        add     ax,extoffright
        mov     cx,14
        mul     cx
        inc     ax
        mov     si,ax
        call    Cartright
        mov     cx,13
        push    ds
        push    Frameaddr2
        pop     ds
        rep     movsb
        pop     ds
        lea     si,PathRight
        lea     di,CopySour
CopyLeftRep__1:
        movsb
        cmp     byte ptr ds:[si],0
        jne     CopyLeftRep__1
        cmp     byte ptr ds:[di-1],'\'
        je      SlashIs__09
        mov     byte ptr ds:[di],'\'
        inc     di
SlashIs__09:
        mov     al,pointerright
        mov     ah,0
        add     ax,extoffright
        mov     cx,14
        mul     cx
        inc     ax
        mov     si,ax
        call    CartRight
        mov     cx,13
        push    ds
        push    Frameaddr2
        pop     ds
        rep     movsb
        pop     ds
        jmp     MainCopyProc
MainCopyProc:
        call  r8_start
        call    ScrChg
        ret
CopyDest db 81 dup(0)
CopySour db 81 dup(0)
Copy    endp

BeforeCopy proc
        int     3
        cmp     Column,0
        jne     CopyRight__
        lea     si,PathLeft
        lea     di,CopySour
CopyLeftRep__1__:
        movsb
        cmp     byte ptr ds:[si],0
        jne     CopyLeftRep__1__
        cmp     byte ptr ds:[di-1],'\'
        je      SlashIs__1__
        mov     byte ptr ds:[di],'\'
        inc     di
SlashIs__1__:
        mov     _Temp_1,di
        lea     si,PathRight
        lea     di,CopyDest
CopyRightRep__1__:
        movsb
        cmp     byte ptr ds:[si],0
        jne     CopyRightRep__1__
        cmp     byte ptr ds:[di-1],'\'
        je      SlashIs1__1__
        mov     byte ptr ds:[di],'\'
        inc     di
SlashIs1__1__:
        mov  _temp_2,di
       mov     _Temp_,-1
       ret

CopyRight__:
        lea     si,PathLeft
        lea     di,CopyDest
CopyLeftRep__1_:
        movsb
        cmp     byte ptr ds:[si],0
        jne     CopyLeftRep__1_
        cmp     byte ptr ds:[di-1],'\'
        je      SlashIs__1_
        mov     byte ptr ds:[di],'\'
        inc     di
SlashIs__1_:
        mov     _Temp_1,di
        lea     si,PathRight
        lea     di,CopySour
CopyRightRep__1_:
        movsb
        cmp     byte ptr ds:[si],0
        jne     CopyRightRep__1_
        cmp     byte ptr ds:[di-1],'\'
        je      SlashIs1__1_
        mov     byte ptr ds:[di],'\'
        inc     di
SlashIs1__1_:
        mov     _temp_2,di
       mov     _Temp_,-1
       ret
BeforeCopy endp

BeforeCopy1 proc

       ret
BeforeCopy1 endp

CopyfileS proc
       push    es
       push    ds
       pusha
       push    cs
       pop     es
       push    frameaddr1
       pop     ds
       mov     ax,_Temp_
LLOOPP:
       inc     ax
       mov     bx,14
       mul     bx
       mov     si,ax
       lodsb
       cmp     byte ptr ds:[si],0
       jne     PPPOOOO
       mov     byte ptr cs:[CopyDest],0
       mov     byte ptr cs:[CopySour],0
       ret
PPPOOOO:
       rol     al,1
       jnc     LLOOPP
       mov     di,cs:[_Temp_2]
       mov     cs:[_Temp_],ax
       push    si
       mov     cx,13
       rep     movsb
       pop     si
       mov     di,cs:[_Temp_1]
       mov     cx,13
       rep     movsb
       ret
CopyfileS endp

GetDisk proc
       mov     al,14h
       out     70h,al
       jmp     $+2
       in      al,71h
       ror     al,1
       jnc     ExitNonDisk
       rol     al,2
       jc      ThreeFour
       rol     al,1
       jc      TwoFDDj
;One
       lea     di,DiskInfo
       mov     al,'A'
       stosb
       mov     dl,2
       jmp     CD_ROM
;One
TwoFDDj:
;Two
       lea     di,DiskInfo
       mov     al,'A'
       stosb
       mov     al,'B'
       stosb
       mov     dl,2
       jmp     CD_ROM
;Two
ThreeFour:
       mov     dl,3
       jmp     CD_ROM
ExitNonDisk:
;No disk
        lea     di,DiskInfo
        mov     dl,2
        jmp     CD_ROM
;No disk
CD_ROM:
       mov     ax,1500h
       mov     bx,0
       int     2fh
       cmp     bx,0
       jne     NextCDR
       mov     bx,offset Filetoexec
       dec     bx
       jmp     HardDisk
NextCDR:
       mov     cx,bx
       mov     bx,offset filetoexec
       dec     bx
       sub     bx,cx
       mov     ax,150dh
       int     2fh
       mov     si,bx
       push    di
       mov     di,bx
cd_rom_l:
       lodsb
       add     al,65
       stosb
loop   cd_rom_l
       pop     di
HardDisk:
       mov     ah,19h
       int     21h
       push    ax
       mov     cx,24
Boot_1:
       mov     si,bx
AAA234:
       lodsb
       sub     al,65
       cmp     dl,al
       je      NextDisk
       cmp     byte ptr ds:[si-1],'$'
       jne     AAA234
       mov     ah,0eh
       int     21h
       mov     ah,19h
       int     21h
       cmp     al,dl
       jne     NextDisk
       add     al,65
       stosb
NextDisk:
       inc     dl
loop   Boot_1
       pop     dx
       mov     ah,0eh
       int     21h
       mov     si,bx
P0009:
       lodsb
       cmp     al,'$'
       je      Return_Disks
       stosb
       jmp     P0009
Return_Disks:
       ret
GetDisk endp

ChgDrive proc
        mov     NumDisk,0
        lea     si,ChgDisk1
        mov     di,512
        mov     al,Addreg
        mov     ah,0
        add     di,ax
        push    es
        push    0b800h
        pop     es
        mov     cx,10
        mov     ah,70h
BBN:
        lodsb
        stosw
loop    BBN
dASD:
        lea     si,ChgDisk2
        add     di,140
        mov     cx,4
aASD:
        lodsb
        stosw
loop    aASD
        push    si
        lea     si,DiskInfo
        add     si,NumDisk
        lodsb
        pop     si
        stosw
        mov     bl,al
        mov     al,':'
        stosw
        mov     cx,4
bASD:
        lodsb
        stosw
loop    bASD
        inc     NumDisk
        lea     si,DiskInfo
        add     si,NumDisk
        lodsb
        cmp     al,'$'
        jne     dASD
        lea     si,ChgDisk3
        add     di,140
        mov     cx,10
cASD:
        lodsb
        stosw
loop    cASD
        pop     es
;-----------------------------------
;        mov     ah,19h
;        int     21h
;        lea     di,DiskInfo
;        mov     si,di
;        add     al,41h
;        mov     ah,al
;-----------------------------------

        cmp     Addreg,0
        je      @LeftDiskChg
        mov     al,RightDisk
        mov     ah,al
        jmp     KKILI
@LeftDiskChg:
        mov     al,LeftDisk
        mov     ah,al
KKILI:
        lodsb
        cmp     ah,al
        jne     KKILI
        mov     di,si
        dec     di
        mov     si,di
        jmp     ChgColorDrv
RetDrv:
        mov     ah,0
        int     16h
        cmp     ah,72                           ;Up
        je      ChgDrvUp
        cmp     ah,80                           ;Down
        je      ChgDrvDown
        cmp     ah,28                           ;Enter
        je      ChgDrvEnter
        cmp     ah,1                            ;Esc
        je      EscapePress
        jmp     RetDrv
EscapePress:
        call    ScrChg
        mov     AddReg,1
        ret
ChgDrvEnter:
;        int     3
;        cmp     Column,0
        cmp     Addreg,0
        je      LeftDrvChange
        mov     al,byte ptr ds:[RightDisk]
        cmp     al,byte ptr ds:[di]
        je      EscapePress

        mov     al,byte ptr ds:[di]
        mov     RightDisk,al
        mov     ah,0eh
        mov     dl,byte ptr ds:[di]
        sub     dl,41h
        int     21h
        mov     Addreg,0
        mov     byte ptr ds:[olddir],0
        mov     _temp_,1
        ret

LeftDrvChange:
        mov     al,byte ptr ds:[LeftDisk]
        cmp     al,byte ptr ds:[di]
        je      EscapePress
        mov     al,byte ptr ds:[di]
        mov     LeftDisk,al
        mov     ah,0eh
        mov     dl,byte ptr ds:[di]
        sub     dl,41h
        int     21h
;        mov     ah,19h
;        int     21h
        mov     Addreg,0
        mov     byte ptr ds:[olddir],0
        mov     _temp_,0
        ret
ChgDrvUp:
        mov     si,di
        cmp     di,offset DiskInfo
        je      MostUp
        dec     di
        jmp     ChgColorDrv
MostUp:
        cmp     byte ptr es:[di+1],'$'
        je      ChgColorDrv
        inc     di
        jmp     MostUp
ChgDrvDown:
        mov     si,di
        cmp     byte ptr ds:[di+1],'$'
        je      MostDown
        inc     di
        jmp     ChgColorDrv
MostDown:
        lea     di,DiskInfo
ChgColorDrv:
        mov     ax,si
        sub     ax,offset DiskInfo
        inc     ax
        mov     cx,160
        mul     cl
        push    di
        mov     di,ax
        add     di,515
        mov     al,Addreg
        mov     ah,0
        add     di,ax
        mov     cx,8
        mov     al,70h
        push    es
        push    0b800h
        pop     es
ChgColorDrvL:
        stosb
        inc     di
loop    ChgColorDrvL
        pop     es
        pop     di
        mov     ax,di
        sub     ax,offset DiskInfo
        inc     ax
        mov     cx,160
        mul     cl
        mov     si,di
        mov     di,ax
        add     di,515
        mov     al,Addreg
        mov     ah,0
        add     di,ax
        mov     cx,8
        mov     al,0a0h
        push    es
        push    0b800h
        pop     es
ChgColorDrvR:
        stosb
        inc     di
loop    ChgColorDrvR
        pop     es
        mov     di,si
        jmp     RetDrv
;        cmp     ah,1
;        jne     NextDrive
;        call    ScrChg
;        mov     Addreg,1
;        ret
;NextDrive:
;        cmp     al,'A'
;        jl      RetDrv
;        cmp     al,'Z'
;        jle     NextDrv
;        cmp     al,'a'
;        jl      RetDrv
;        cmp     al,'z'
;        jg      RetDrv
;        sub     al,'a'
;        add     al,'A'
;NextDrv:
;        mov     bl,al
;        mov     ah,19h
;        int     21h
;        add     al,'A'
;        cmp     al,bl
;        jne     ChgDrv
;        call    ScrChg
;        mov     Addreg,1
;        ret
;ChgDrv:
;        mov     ah,0eh
;        mov     dl,bl
;        sub     dl,'A'
;        int     21h
;        mov     Addreg,2
;        ret
;        pop     es
;        ret
ChgDrive endp

Freememory proc
        mov     AX, 4500h
        mov     DX, Handleemm1
        int     67h
        mov     AX, 4500h
        mov     DX, Handleemm2
        int     67h
        mov     di,0
        push    0b800h
        pop     es
        mov     cx,2000
        mov     ax,0f00h
        rep     stosw

        pop     AX
        mov     ax,4c00h
        int     21h
Freememory endp

Cmppath proc
        cmp     Column, 0
        jne     Nextcmppath
        mov     AH, 19h
        int     21h
        add     AL, 65
        mov     byte ptr DS:[offset Pathleft], AL
        mov     byte ptr DS:[(offset Pathleft)+1], ':'
        mov     byte ptr DS:[(offset Pathleft)+2], '\'
        mov     AH, 47h
        mov     DL, 0
        lea     SI, Pathleft
        add     SI, 3
        int     21h
        ret
Nextcmppath:
        mov     AH, 19h
        int     21h
        add     AL, 65
        mov     byte ptr DS:[offset Pathright], AL
        mov     byte ptr DS:[(offset Pathright)+1], ':'
        mov     byte ptr DS:[(offset Pathright)+2], '\'
        mov     AH, 47h
        mov     DL, 0
        lea     SI, Pathright
        add     SI, 3
        int     21h
        ret
Cmppath endp

Getcurdir proc
        mov     AH, 19h
        int     21h
        add     AL, 65
        mov     byte ptr ds:[RightDisk],al
        mov     byte ptr ds:[LeftDisk],al
        mov     byte ptr DS:[offset Pathright], AL
        mov     byte ptr DS:[(offset Pathright)+1], ':'
        mov     byte ptr DS:[(offset Pathright)+2], '\'
        mov     AH, 47h
        mov     DL, 0
        lea     SI, Pathright
        add     SI, 3
        int     21h
        lea     SI, Pathright
        lea     DI, Pathleft
        mov     CX, 67
        rep     movsb
        ret
Getcurdir endp

Findleft proc
        cmp     Column, 0
        jne     Nextfindleft
        mov     AH, 4Eh
        lea     DX, Namef
        mov     CX, 3Fh
        int     21h
        lea     SI, Dta
        add     SI, 1Eh
        cmp     byte ptr DS:[SI], '.'
        je      Nextleft___1
;        int     3
        lea     SI,DTA
        add     si,15h
        lodsb
        ror     al,4
        jc      NextLeft___1
        call    Putemm
Nextleft___1:
        mov     AH, 4Fh
        lea     DX, Namef
        mov     CX, 10h
        int     21h
        jc      Passleft1
        lea     si,dta
        add     si,15h
        lodsb
        ror     al,4
        jc      NextLeft___1
        call    Putemm
        jmp     Nextleft___1
Passleft1:
        ret
Nextfindleft:
        mov     AH, 19h
        int     21h
        add     AL, 65
        mov     byte ptr DS:[offset Pathb], AL
        mov     byte ptr DS:[(offset Pathb)+1], ':'
        mov     byte ptr DS:[(offset Pathb)+2], '\'
        mov     AH, 47h
        mov     DL, 0
        lea     SI, Pathb
        add     SI, 3
        int     21h

        mov     ah,0eh
        mov     dl,byte ptr ds:[LeftDisk]
        sub     dl,65
        int     21h

        mov     AH, 3Bh
        lea     DX, Pathleft
        int     21h
        mov     AH, 4Eh
        lea     DX, Namef
        mov     CX, 3Fh
        int     21h
        lea     SI, Dta
        add     SI, 1Eh
        cmp     byte ptr DS:[SI], '.'
        je      Nextleft_
        lea     SI,DTA
        add     si,15h
        lodsb
        ror     al,4
        jc      NextLeft_
        call    Putemm
Nextleft_:
        mov     AH, 4Fh
        lea     DX, Namef
        mov     CX, 10h
        int     21h
        jc      Passleft
        lea     SI,DTA
        add     si,15h
        lodsb
        ror     al,4
        jc      NextLeft_
        call    Putemm
        jmp     Nextleft_
Passleft:
        mov     ah,0eh
        mov     dl,byte ptr ds:[RightDisk]
        sub     dl,65
        int     21h
        mov     AH, 3Bh
        lea     DX, Pathb
        int     21h
        ret
Findleft endp

Findright proc
        cmp     Column, 1
        jne     Nextfindright
        mov     AH, 4Eh
        lea     DX, Namef
        mov     CX, 3Fh
        int     21h
        lea     SI, Dta
        add     SI, 1Eh
        cmp     byte ptr DS:[SI], '.'
        je      Next_Right1
        lea     SI,DTA
        add     si,15h
        lodsb
        ror     al,4
        jc      Next_Right1
        call    Putemmright
Next_Right1:
        mov     AH, 4Fh
        lea     DX, Namef
        mov     CX, 10h
        int     21h
        jc      Passa1
        lea     si,DTA
        add     si,15h
        lodsb
        ror     al,4
        jc      Next_Right1
        call    Putemmright
        jmp     Next_Right1
Passa1:
        ret
Nextfindright:
        mov     AH, 19h
        int     21h
        add     AL, 65
;        mov     al,byte ptr ds:[RightDisk]
        mov     byte ptr DS:[offset Pathb], AL
        mov     byte ptr DS:[(offset Pathb)+1], ':'
        mov     byte ptr DS:[(offset Pathb)+2], '\'
        mov     AH, 47h
        mov     DL, 0
        lea     SI, Pathb
        add     SI, 3
        int     21h

        mov     ah,0eh
        mov     dl,byte ptr ds:[RightDisk]
        sub     dl,65
        int     21h
        mov     AH, 3Bh
        lea     DX, Pathright
        int     21h
        mov     AH, 4Eh
        lea     DX, Namef
        mov     CX, 3Fh
        int     21h
        lea     SI, Dta
        add     SI, 1Eh
        cmp     byte ptr DS:[SI], '.'
        je      Next_Right
        lea     SI,DTA
        add     si,15h
        lodsb
        ror     al,4
        jc      Next_Right
        call    Putemmright
Next_Right:
        mov     AH, 4Fh
        lea     DX, Namef
        mov     CX, 10h
        int     21h
        jc      Passa
        lea     SI,DTA
        add     si,15h
        lodsb
        ror     al,4
        jc      Next_Right
        call    Putemmright
        jmp     Next_Right
Passa:
        mov     Ah,0eh
        mov     dl,byte ptr ds:[LeftDisk]
        sub     dl,65
        int     21h
        mov     AH, 3Bh
        lea     DX, Pathb
        int     21h
        ret
Findright endp

;Not mine \/
;         \/
Runanyprogram proc
        call    m5_start
        mov     ah,1ah
        lea     dx,DTA
        int     21h
        call    Path
        call    ScrChg
        ret
Runanyprogram endp

Help    proc
        ret
Help    endp

Menu    proc
        ret
Menu    endp

View    proc
        ret
View    endp

Edit    proc
        ret
Edit    endp


Renmov  proc
        ret
Renmov  endp

Mkdir   proc
        ret
Mkdir   endp

Delete  proc
        ret
Delete  endp

Pulldown proc
        ret
Pulldown endp

ProcOfFind proc
        ret
ProcOfFind endp
;         /\
;Not mine /\

Insert  proc
        cmp     Column,0
        je      LeftInsert
        jmp     RightInsert
LeftInsert:
        call    Cartleft
        push    frameaddr1
        pop     ds
        mov     al,cs:[Pointer]
        mov     ah,0
        add     ax,cs:[Extoff]
        mov     cx,14
        mul     cx
        mov     si,ax
        cmp     byte ptr ds:[si+1],'.'
        jne     ContIns
        push    cs
        pop     ds
        call    MovDown
        call    ScrChg
        ret
ContIns:
;        int     3
        lodsb
        push    ax
        rol     al,1
        jc      WasInserted
        pop     ax
        inc     cs:[InsOrNot]
        add     al,80h
        mov     di,si
        dec     di
        push    ds
        pop     es
        stosb
        push    cs cs
        pop     es ds
        mov     al,Pointer
        mov     ah,0
        call    Place
        mov     di,si
        inc     di
        mov     cx,12
        mov     al,1eh
        cmp     byte ptr ds:[di],30h
        jne     QWERTY
        mov     al,3eh
QWERTY:
        stosb
        inc     di
loop    QWERTY
        call    MovDown
        call    ScrChg
        ret
WasInserted:
        pop     ax
        sub     al,80h
        dec     cs:[InsOrNot]
        mov     di,si
        dec     di
        push    ds
        pop     es
        stosb
        push    cs cs
        pop     es ds
        mov     al,Pointer
        mov     ah,0
        call    Place
        mov     di,si
        inc     di
        mov     cx,12
        mov     al,1Fh
        cmp     byte ptr ds:[di],3eh
        jne     QWERTYT
        mov     al,30h
QWERTYT:
        stosb
        inc     di
loop    QWERTYT
        call    MovDown
        call    ScrChg
        ret
RightInsert:
        call    Cartright
        push    frameaddr2
        pop     ds
        mov     al,cs:[Pointerright]
        mov     ah,0
        add     ax,cs:[Extoffright]
        mov     cx,14
        mul     cx
        mov     si,ax
        cmp     byte ptr ds:[si+1],'.'
        jne     ContInsR
        push    cs
        pop     ds
        call    MovDown
        call    ScrChg
        ret
ContInsR:
        lodsb
        push    ax
        rol     al,1
        jc      WasInsertedR
        pop     ax
        add     al,80h
        inc     cs:[InsOrNot]
        mov     di,si
        dec     di
        push    ds
        pop     es
        stosb
        push    cs cs
        pop     es ds
        mov     al,Pointerright
        mov     ah,0
        call    Place
        mov     di,si
        inc     di
        mov     al,1eh
        mov     cx,12
        add     di,80
        cmp     byte ptr ds:[di],30h
        jne     QWERTYR
        mov     al,3eh
QWERTYR:
        stosb
        inc     di
loop    QWERTYR
        call    MovDown
        call    ScrChg
        ret
WasInsertedR:
        pop     ax
        sub     al,80h
        dec     cs:[InsOrNot]
        mov     di,si
        dec     di
        push    ds
        pop     es
        stosb
        push    cs cs
        pop     es ds
        mov     al,PointerRight
        mov     ah,0
        call    Place
        mov     di,si
        add     di,81
        mov     cx,12
        mov     al,1Fh
        cmp     byte ptr ds:[di],3eh
        jne     QWERTYTR
        mov     al,30h
QWERTYTR:
        stosb
        inc     di
loop    QWERTYTR
        call    MovDown
        call    ScrChg
        ret
Insert  endp

Cartright proc
        pusha
        mov     CX, 4
        mov     BX, -1
        mov     AL, -1
Contemmr:
        inc     AL
        inc     BX
        mov     AH, 44h
        mov     DX, Handleemm2
        int     67h
loop    Contemmr
        popa
        ret
Cartright endp

Cartleft proc
        pusha
        mov     CX, 4
        mov     BX, -1
        mov     AL, -1
Contemml:
        inc     AL
        inc     BX
        mov     AH, 44h
        mov     DX, Handleemm1
        int     67h
loop    Contemml
        popa
        ret
Cartleft endp

Backspace proc
        cmp     Column, 0
        je      Nextbackspace
        call    Cartright
        push    DS
        push    Frameaddr2
        pop     DS
        cmp     byte ptr DS:[1], '.'
        je      Exitbackspace
        stc
        pop     DS
        ret
Nextbackspace:
        call    Cartleft
        push    DS
        push    Frameaddr1
        pop     DS
        cmp     byte ptr DS:[1], '.'
        je      Exitbackspace
        stc
        pop     DS
        ret
Exitbackspace:
        clc
        pop     DS
        ret
Backspace endp

Backdirright proc
        call    Cartright
        push    ES
        push    Frameaddr2
        pop     ES
        mov     BX, -1
Nextback_1:
        inc     BX
        mov     AX, BX
        lea     SI, Olddir
        inc     SI
        mov     CX, 14
        mul     CX
        mov     DI, AX
        inc     DI
Continue_Back:
        lodsb
        inc     DI
        cmp     byte ptr ES:[DI-1], AL
        jne     Nextback_1
        cmp     AL, 0
        jne     Continue_Back
        cmp     BL, 50
        jg      Nextback_2
        mov     Pointerright, BL
        mov     Extoffright, 0
        pop     ES
        ret
Nextback_2:
        mov     Pointerright, 50
        sub     BX, 50
        mov     Extoffright, BX
        pop     ES
        ret
Backdirright endp

Findbackdir proc
        cmp     byte ptr DS:[Olddir], 0
        jne     Nextback
        cmp     _temp_,1
        je      RightSS
        mov     Pointer, 0
        ret
RightSS:
        mov     Pointerright, 0
        ret
Nextback:
;        int     3
        cmp     byte ptr DS:[Olddir], 3
        jne     Next__Back
        mov     Pointerright, 0
        ret
Next__Back:
        cmp     byte ptr DS:[Olddir], 1
        jne     Next_Back
        call    Backdirright
        ret
Next_Back:
        call    Cartleft
        push    ES
        push    Frameaddr1
        pop     ES
        mov     BX, -1
Nextback1:
        inc     BX
        mov     AX, BX
        lea     SI, Olddir
        inc     SI
        mov     CX, 14
        mul     CX
        mov     DI, AX
        inc     DI
Continueback:
        lodsb
        inc     DI
        cmp     byte ptr ES:[DI-1], AL
        jne     Nextback1
        cmp     AL, 0
        jne     Continueback
        cmp     BL, 50
        jg      Nextback2
        mov     Pointer, BL
        pop     ES
        ret
Nextback2:
        mov     Pointer, 50
        sub     BX, 50
        mov     Extoff, BX
        pop     ES
        ret
Findbackdir endp

Place   proc
        mov     CL, 17
        div     CL
        push    AX
        xchg    AL, AH
        lea     SI, Screen
        add     SI, 322
        mov     CL, 160
        mul     CL
        add     SI, AX
        pop     AX
        mov     CL, 26
        mul     CL
        add     SI, AX
        ret
Place   endp

Path    proc
        cmp     Column,0
        je      LeftPath
        mov     AH, 0eh
        mov     Dl,RightDisk
        sub     dl,65
        int     21h
        mov     AL, RightDisk
        mov     byte ptr DS:[(offset Screen)+3680], AL
        mov     byte ptr DS:[(offset Screen)+3682], ':'
        mov     byte ptr DS:[(offset Screen)+3684], '\'
        mov     AH, 47h
        mov     DL, 0
        lea     SI, Pathb
        int     21h
        lea     SI, Pathb
        lea     DI, Screen
        add     DI, 3686
        push    DS
        pop     ES
Notpath:
        lodsb
        cmp     AL, 0
        je      Nextpath
        stosb
        inc     DI
        jmp     Notpath
Nextpath:
        mov     AL, '>'
        stosb
        mov     BH, 0
        mov     DH, 23
        mov     CL, 160
        mov     AX, DI
        sub     AX, offset Screen
        div     CL
        mov     CL, 2
        mov     AL, AH
        mov     AH, 0
        div     CL
        mov     DL, AL
        inc     DL
        mov     AH, 2
        int     10h
        ret
LeftPath:
        mov     ah,0eh
        mov     dl,LeftDisk
        sub     dl,65
        int     21h
        mov     al,LeftDisk
        mov     byte ptr DS:[(offset Screen)+3680], AL
        mov     byte ptr DS:[(offset Screen)+3682], ':'
        mov     byte ptr DS:[(offset Screen)+3684], '\'
        mov     AH, 47h
        mov     DL, 0
        lea     SI, Pathb
        int     21h
        lea     SI, Pathb
        lea     DI, Screen
        add     DI, 3686
        push    DS
        pop     ES
NotpathL:
        lodsb
        cmp     AL, 0
        je      Nextpath
        stosb
        inc     DI
        jmp     Notpath
NextpathL:
        mov     AL, '>'
        stosb
        mov     BH, 0
        mov     DH, 23
        mov     CL, 160
        mov     AX, DI
        sub     AX, offset Screen
        div     CL
        mov     CL, 2
        mov     AL, AH
        mov     AH, 0
        div     CL
        mov     DL, AL
        inc     DL
        mov     AH, 2
        int     10h
        ret
Path    endp

Putname proc
        inc     Poscount
        cmp     Poscount, 51
        jl      Continueput
        mov     Addreg, 0
        ret
Continueput:
        mov     AL, Poscount
        mov     AH, 0
        add     AX, Extoff
        cmp     AX, Filecount
        jng     Continueput1
        mov     Addreg, 0
        ret
Continueput1:
        mov     AH, 0
        mov     AL, Poscount
        call    Place

        mov     DI, SI
        call    Cartleft
        push    DS
        push    Frameaddr1
        pop     DS
        mov     AL, CS:[Poscount]
        mov     CL, 14
        mul     CL
        mov     SI, AX
        mov     AX, CS:[Extoff]
        mov     CX, 14
        mul     CX
        add     SI, AX
        lodsb
        mov     CS:[Attr], AL
        mov     CL, 4
        rol     byte ptr CS:[Attr], CL
        jc      Nextrol
        mov     CS:[Addreg], 32
Nextrol:
        push    CS
        pop     ES
Nameb:
        lodsb
        cmp     AL, '.'
        jne     Nextn
        cmp     byte ptr DS:[SI], '.'
        jne     Extent
        stosb
        inc     DI
        movsb
        inc     DI
        jmp     Return
Nextn:
        cmp     AL, 0
        jne     Nextp
        jmp     Return
Nextp:
        cmp     AL, 64
        jng     Nextppp
        cmp     AL, 90
        jg      Nextppp
        add     AL, CS:[Addreg]
Nextppp:
        stosb
        inc     DI
        jmp     Nameb
Extent:
        push    SI
        mov     AH, 0
        mov     AL, CS:[Poscount]
        call    Place
        mov     DI, SI
        pop     SI
        add     DI, 18
Notret:
        lodsb
        cmp     AL, 0
        je      Return
        cmp     AL, 64
        jng     Nextpp
        cmp     AL, 90
        jg      Nextpp
        add     AL, CS:[Addreg]
Nextpp:
        stosb
        inc     DI
        jmp     Notret
Return:
        pop     DS
        mov     CS:[Addreg], 0
        jmp     Putname
        ret
Putname endp

Putnameright proc
        inc     Poscountright
        cmp     Poscountright, 51
        jl      Continueputright
        mov     Addreg, 0
        ret
Continueputright:
        mov     AL, Poscountright
        mov     AH, 0
        add     AX, Extoffright
        cmp     AX, Filecountright
        jng     Continueput1Right
        mov     Addreg, 0
        ret
Continueput1Right:
        mov     AH, 0
        mov     AL, Poscountright
        call    Place
        add     SI, 80

        mov     DI, SI
        call    Cartright
        push    DS
        push    Frameaddr2
        pop     DS
        mov     AL, CS:[Poscountright]
        mov     CL, 14
        mul     CL
        mov     SI, AX
        mov     AX, CS:[Extoffright]
        mov     CX, 14
        mul     CX
        add     SI, AX
        lodsb
        mov     CL, 4
        rol     AL, CL
        jc      Nextrolright
        mov     CS:[Addreg], 32
Nextrolright:
        push    CS
        pop     ES
Namebright:
        lodsb
        cmp     AL, '.'
        jne     Nextnright
        cmp     byte ptr DS:[SI], '.'
        jne     Extentright
        stosb
        inc     DI
        movsb
        inc     DI
        jmp     Returnright
Nextnright:
        cmp     AL, 0
        jne     Nextpright
        jmp     Returnright
Nextpright:
        cmp     AL, 64
        jng     Nextpppright
        cmp     AL, 90
        jg      Nextpppright
        add     AL, CS:[Addreg]
Nextpppright:
        stosb
        inc     DI
        jmp     Namebright
Extentright:
        push    SI
        mov     AH, 0
        mov     AL, CS:[Poscountright]
        call    Place
        add     SI, 80
        mov     DI, SI
        pop     SI
        add     DI, 18
Notretright:
        lodsb
        cmp     AL, 0
        je      Returnright
        cmp     AL, 64
        jng     Nextppright
        cmp     AL, 90
        jg      Nextppright
        add     AL, CS:[Addreg]
Nextppright:
        stosb
        inc     DI
        jmp     Notretright
Returnright:
        pop     DS
        mov     CS:[Addreg], 0
        jmp     Putnameright
        ret
Putnameright endp

Putemm  proc
        call    Cartleft
        push    ES
        push    Frameaddr1
        pop     ES
        inc     Filecount
        mov     AX, Filecount
        mov     CX, 14
        mul     CX
        mov     DI, AX
        lea     SI, Dta
        add     SI, 15h
        movsb
        lea     SI, Dta
        add     SI, 1Eh
        mov     CX, 13
Nextemm:
        movsb
        dec     CX
        cmp     byte ptr DS:[SI], 0
        jne     Nextemm
        mov     AL, 0
        rep     stosb
        pop     ES
        ret
Putemm  endp

Putemmright proc
        call    Cartright
        push    ES
        push    Frameaddr2
        pop     ES
        inc     Filecountright
        mov     AX, Filecountright
        mov     CX, 14
        mul     CX
        mov     DI, AX
        lea     SI, Dta
        add     SI, 15h
        movsb
        lea     SI, Dta
        add     SI, 1Eh
        mov     CX, 13
Nextemmright:
        movsb
        dec     CX
        cmp     byte ptr DS:[SI], 0
        jne     Nextemmright
        mov     AL, 0
        rep     stosb
        pop     ES
        ret
Putemmright endp

Mover   proc
        cmp     Column, 0
        jne     Nextmover
        mov     AH, 0
        mov     AL, Pointer
        call    Place
        inc     SI
        mov     CX, 12
        mov     BL, 30h
        cmp     byte ptr ds:[si],8eh
        jne     Kkl
        mov     BL, 3eh
Kkl:
        mov     byte ptr DS:[SI], bl
        inc     SI
        inc     SI
loop    Kkl
        call    getFileInfo
        ret
Nextmover:
        mov     AH, 0
        mov     AL, Pointerright
        call    Place
        add     SI, 81
        mov     CX, 12
        mov     BL, 30h
        cmp     byte ptr ds:[si],8eh
        jne     Kkl_
        mov     BL, 3eh
Kkl_:
        mov     byte ptr DS:[SI], bl
        inc     SI
        inc     SI
loop    Kkl_
        call    getFileInfo
        ret
Mover   endp

Scrmov  proc
        movsb
        push    DI
        sub     DI, offset Screen
        cmp     DI, 3681
        jge     Nsma
        pop     DI
        cmp     byte ptr DS:[SI-1], 'N'
        je      Nsm
        cmp     byte ptr DS:[SI-1], 'a'
        je      Nsm
        cmp     byte ptr DS:[SI-1], 'm'
        je      Nsm
        cmp     byte ptr DS:[SI-1], 'e'
        je      Nsm
        jmp     Nsm1
Nsm:
        mov     byte ptr ES:[DI], 8ah              ; color of name
        inc     DI
loop    Scrmov
Nsm1:
        mov     byte ptr ES:[DI], 087h
        inc     DI
loop    Scrmov
        ret
Nsma:
        pop     DI
        mov     byte ptr ES:[DI], 15
        inc     DI
loop    Scrmov
        ret
Scrmov  endp

Scrchg  proc
        lea     SI, Screen
        push    ES
        push    0B800h
        pop     ES
        xor     DI, DI
        mov     CX, 2000
        rep     movsw
        pop     ES
        ret
Scrchg  endp

Delmov  proc
        cmp     Column, 0
        jne     Nextdelmov
        call    cartleft
        mov     Al, Pointer
        mov     AH, 0
        add     ax,extoff
        mov     cx,14
        mul     cx
        mov     bx,ax
        push    frameaddr1
        pop     es
        mov     dl,byte ptr es:[bx]
        push    cs
        pop     es
        rol     dl,1
        jc      Yellow
        mov     bl,87h
        jmp     Cont__0
Yellow:
        mov     bl,8eh
Cont__0:
        mov     ah,0
        mov     AL, Pointer
        call    Place
        inc     SI
        mov     CX, 12
Kkm:
        mov     byte ptr DS:[SI], bl
        inc     SI
        inc     SI
loop    Kkm
        ret
Nextdelmov:
        call    cartright
        mov     bl, Pointerright
        mov     bH, 0
        add     bx,extoffright
        mov     ax,bx
        mov     cx,14
        mul     cx
        mov     bx,ax
        push    frameaddr2
        pop     es
        mov     dl,byte ptr es:[bx]
        push    cs
        pop     es
        rol     dl,1
        jc      Yellow_r
        mov     bl,87h
        jmp     Cont__0r
Yellow_r:
        mov     bl,8eh
Cont__0r:
        mov     AH, 0
        mov     AL, Pointerright
        call    Place
        add     SI, 81
        mov     CX, 12
Kkm_:
        mov     byte ptr DS:[SI], bl
        inc     SI
        inc     SI
loop    Kkm_
        ret

Delmov  endp

Movdown proc
        cmp     Column, 0
        jne     Nextmovdown
        mov     AX, Filecount
        sub     AX, Extoff
        cmp     AX, 51
        jge     Nextdown
        mov     AL, Poscount
        dec     AL
        cmp     Pointer, AL
        je      Exitdown
        call    Delmov
        inc     Pointer
        call    Mover
        call    Scrchg
        jmp     Exitdown
Nextdown:
        cmp     Pointer, 50
        jge     Nextdownmov
        call    Delmov
        inc     Pointer
        call    Mover
        call    Scrchg
        jmp     Exitdown
Nextdownmov:
        mov     AL, Pointer
        mov     AH, 0
        add     AX, Extoff
        cmp     Filecount, AX
        jle     Exitdown
        inc     Extoff
        mov     BX, 0
        call    Putext
        call    Scrchg
        jmp     Exitdown
Exitdown:
        ret
Nextmovdown:
        cmp     Poscountright, 51
        jge     Nextdown1
        mov     AL, Poscountright
        dec     AL
        cmp     Pointerright, AL
        je      Exitdown
        call    Delmov
        inc     Pointerright
        call    Mover
        call    Scrchg
        jmp     Exitdown
Nextdown1:
        cmp     Pointerright, 50
        jge     Nextdownmov1
        call    Delmov
        inc     Pointerright
        call    Mover
        call    Scrchg
        jmp     Exitdown
Nextdownmov1:
        mov     AL, Pointerright
        mov     AH, 0
        add     AX, Extoffright
        cmp     Filecountright, AX
        jle     Exitdown
        inc     Extoffright
        mov     BX, 0
        call    Putextright
        call    Scrchg
        jmp     Exitdown
Movdown endp

Movup   proc
        cmp     Column, 0
        jne     Nextmovup

        cmp     Pointer, 0
        jng     Nextup
        call    Delmov
        dec     Pointer
        call    Mover
        call    Scrchg
        jmp     Exitup
Nextup:
        cmp     Extoff, 0
        je      Exitup
        dec     Extoff
        mov     BX, 0
        call    Putext
        call    Scrchg
        jmp     Exitup
Exitup:
        ret
Nextmovup:
        cmp     Pointerright, 0
        jng     Nextup1
        call    Delmov
        dec     Pointerright
        call    Mover
        call    Scrchg
        jmp     Exitup
Nextup1:
        cmp     Extoffright, 0
        je      Exitup
        dec     Extoffright
        mov     BX, 0
        call    Putextright
        call    Scrchg
        jmp     Exitup
Movup   endp

Movleft proc
        cmp     Column, 0
        jne     Nextmovleft

        cmp     Pointer, 16
        jng     Nextleft
        call    Delmov
        sub     Pointer, 17
        call    Mover
        call    Scrchg
        jmp     Exitleft
Nextleft:
        mov     AL, Pointer
        mov     AH, 0
        add     AX, Extoff
        cmp     AX, 16
        jng     Nextleft1
        cmp     AX, 33
        jng     Nextleft2
        sub     Extoff, 17
        mov     BX, 0
        call    Putext
        call    Scrchg
        jmp     Exitleft
Nextleft2:
        cmp     Extoff, 16
        jng     Nextleft1
        sub     Extoff, 17
        mov     BX, 0
        call    Putext
        call    Scrchg
        jmp     Exitleft
Nextleft1:
        call    Delmov
        mov     Pointer, 0
        call    Mover
        mov     Extoff, 0
        mov     BX, 0
        call    Putext
        call    Scrchg
        jmp     Exitleft
Exitleft:
        ret
Nextmovleft:
        cmp     Pointerright, 16
        jng     Nextleft_1
        call    Delmov
        sub     Pointerright, 17
        call    Mover
        call    Scrchg
        jmp     Exitleft
Nextleft_1:
        mov     AL, Pointerright
        mov     AH, 0
        add     AX, Extoffright
        cmp     AX, 16
        jng     Nextleft_11
        cmp     AX, 33
        jng     Nextleft_12
        sub     Extoffright, 17
        mov     BX, 0
        call    Putextright
        call    Scrchg
        jmp     Exitleft
Nextleft_12:
        cmp     Extoffright, 16
        jng     Nextleft_11
        sub     Extoffright, 17
        mov     BX, 0
        call    Putextright
        call    Scrchg
        jmp     Exitleft
Nextleft_11:
        call    Delmov
        mov     Pointerright, 0
        call    Mover
        mov     Extoffright, 0
        mov     BX, 0
        call    Putextright
        call    Scrchg
        jmp     Exitleft
Movleft endp

Movright proc
        cmp     Column, 0
        je      Nextmovright___
        jmp     Nextmovright
Nextmovright___:
        push    word ptr Pointer
        cmp     Pointer, 33
        jg      Nextright1
        add     Pointer, 17
        mov     AL, Poscount
        dec     AL
        cmp     Pointer, AL
        jl      Nextright_111
        jmp     Nextright
Nextright_111:
        pop     word ptr Pointer
        call    Delmov
        add     Pointer, 17
        call    Mover
        call    Scrchg
        jmp     Exitright
Nextright1:
        pop     word ptr Pointer
        mov     AX, Filecount
        sub     AX, Extoff
        mov     BL, Pointer
        mov     BH, 0
        sub     AX, BX
        cmp     AX, 16
        jl      Nextright2
        mov     AX, Filecount
        sub     AX, Extoff
        mov     BL, Poscount
        mov     BH, 0
        sub     AX, BX
        cmp     AX, 16
        jl      Nextright2
        mov     BX, 0
        add     Extoff, 17
        call    Putext
        call    Scrchg
        jmp     Exitright
Nextright2:
        call    Delmov
        cmp     Filecount, 51
        jge     Nextend__11
        mov     AX, Filecount
        mov     Pointer, AL
        call    Mover
        mov     BX, 0
        call    Putext
        call    Scrchg
        jmp     Exitright
Nextend__11:
        mov     Pointer, 50
        call    Mover
        mov     AX, Filecount
        sub     AX, 50
        mov     Poscount, 51
        mov     Extoff, AX
        mov     BX, 0
        call    Putext
        call    Scrchg
        jmp     Exitright
Nextright:
        pop     word ptr Pointer
        call    Delmov
        mov     AL, Poscount
        dec     AL
        mov     Pointer, AL
        call    Mover
        call    Scrchg
Exitright:
        ret
Nextmovright:
        push    word ptr Pointerright
        cmp     Pointerright, 33
        jg      Nextright_11
        add     Pointerright, 17
        mov     AL, Poscountright
        dec     AL
        cmp     Pointerright, AL
        jl      Nextright_1111
        jmp     Nextright_1
Nextright_1111:
        pop     word ptr Pointerright
        call    Delmov
        add     Pointerright, 17
        call    Mover
        call    Scrchg
        jmp     Exitright
Nextright_11:
        pop     word ptr Pointerright
        mov     AX, Filecountright
        sub     AX, Extoffright
        mov     BL, Pointerright
        mov     BH, 0
        sub     AX, BX
        cmp     AX, 16
        jl      Nextright_12
        mov     AX, Filecountright
        sub     AX, Extoffright
        mov     BL, Poscountright
        mov     BH, 0
        sub     AX, BX
        cmp     AX, 16
        jl      Nextright_12
        mov     BX, 0
        add     Extoffright, 17
        call    Putextright
        call    Scrchg
        jmp     Exitright
Nextright_12:
        call    Delmov
        cmp     Filecountright, 51
        jge     Nextend__122
        mov     AX, Filecountright
        mov     Pointerright, AL
        call    Mover
        mov     BX, 0
        call    Putextright
        call    Scrchg
        jmp     Exitright
Nextend__122:
        mov     Pointerright, 50
        call    Mover
        mov     AX, Filecountright
        sub     AX, 50
        mov     Poscountright, 51
        mov     Extoffright, AX
        mov     BX, 0
        call    Putextright
        call    Scrchg
        jmp     Exitright
Nextright_1:
        pop     word ptr Pointerright
        call    Delmov
        mov     AL, Poscountright
        dec     AL
        mov     Pointerright, AL
        call    Mover
        call    Scrchg
        jmp     Exitright
Movright endp

Movend  proc
        cmp     Column, 0
        jne     Nextmovend
        call    Delmov
        cmp     Filecount, 51
        jge     Nextend
        mov     AX, Filecount
        mov     Pointer, AL
        call    Mover
        mov     BX, 0
        call    Putext
        call    Scrchg
        ret
Nextend:
        mov     Pointer, 50
        call    Mover
        mov     AX, Filecount
        sub     AX, 50
        mov     Poscount, 51
        mov     Extoff, AX
        mov     BX, 0
        call    Putext
        call    Scrchg
        ret
Nextmovend:
        call    Delmov
        cmp     Filecountright, 51
        jge     Nextend1
        mov     AX, Filecountright
        mov     Pointerright, AL
        call    Mover
        mov     BX, 0
        call    Putextright
        call    Scrchg
        ret
Nextend1:
        mov     Pointerright, 50
        call    Mover
        mov     AX, Filecountright
        sub     AX, 50
        mov     Poscountright, 51
        mov     Extoffright, AX
        mov     BX, 0
        call    Putextright
        call    Scrchg
        ret
Movend  endp

Movhome proc
        cmp     Column, 0
        jne     Nextmovhome
        call    Delmov
        mov     Pointer, 0
        call    Mover
        mov     Extoff, 0
        mov     BX, 0
        call    Putext
        call    Scrchg
        ret
Nextmovhome:
        call    Delmov
        mov     Pointerright, 0
        call    Mover
        mov     Extoffright, 0
        mov     BX, 0
        call    Putextright
        call    Scrchg
        ret
Movhome endp

Putext  proc
        mov     AX, BX
        call    Place
        push    SI
        push    ES
        push    DS
        pop     ES
        mov     DI, SI
        mov     AL, 20h
        mov     CX, 12
Qqwee:
        stosb
        inc     DI
loop    Qqwee
        pop     ES
        pop     SI
        mov     DI, SI
        call    Cartleft
        push    DS
        push    Frameaddr1
        pop     DS
        mov     AL, BL
        mov     CL, 14
        mul     CL
        mov     SI, AX
        mov     AX, CS:[Extoff]
        mov     CX, 14
        mul     CX
        add     SI, AX
        lodsb
        mov     CS:[Attr], AL
        mov     CL, 4
        rol     byte ptr CS:[Attr], CL
        jc      Nextrol_
        mov     CS:[Addreg], 32
Nextrol_:
        push    CS
        pop     ES
Nameb_:
        lodsb
        cmp     AL, '.'
        jne     Nextn_
        cmp     byte ptr DS:[SI], '.'
        jne     Extent_
        stosb
        inc     DI
        movsb
        inc     DI
        jmp     Return_
Nextn_:
        cmp     AL, 0
        jne     Nextp_
        jmp     Return_
Nextp_:
        cmp     AL, 64
        jng     Nextppp_
        cmp     AL, 90
        jg      Nextppp_
        add     AL, CS:[Addreg]
Nextppp_:
        stosb
        inc     DI
        jmp     Nameb_
Extent_:
        push    SI
        mov     AH, 0
        mov     AL, BL
        call    Place
        mov     DI, SI
        pop     SI
        add     DI, 18
Notret_:
        lodsb
        cmp     AL, 0
        je      Return_
        cmp     AL, 64
        jng     Nextpp_
        cmp     AL, 90
        jg      Nextpp_
        add     AL, CS:[Addreg]
Nextpp_:
        stosb
        inc     DI
        jmp     Notret_
Return_:
        pop     DS
        mov     CS:[Addreg], 0
        inc     BX
        cmp     Filecount, 50
        jge     Next__1
        cmp     BX, Filecount
        je      Exitputext
        jmp     Putext
Next__1:
        cmp     BX, 51
        je      Exitputext
        jmp     Putext
Exitputext:
        call    GetFileInfo
        ret
Putext  endp

Putextright proc
        mov     AX, BX
        call    Place
        add     SI, 80
        push    SI
        push    ES
        push    DS
        pop     ES
        mov     DI, SI
        mov     AL, 20h
        mov     CX, 12
Qqwee1:
        stosb
        inc     DI
loop    Qqwee1
        pop     ES
        pop     SI
        mov     DI, SI
        call    Cartright
        push    DS
        push    Frameaddr2
        pop     DS
        mov     AL, BL
        mov     CL, 14
        mul     CL
        mov     SI, AX
        mov     AX, CS:[Extoffright]
        mov     CX, 14
        mul     CX
        add     SI, AX
        lodsb
        mov     CS:[Attr], AL
        mov     CL, 4
        rol     byte ptr CS:[Attr], CL
        jc      Nextrol_1
        mov     CS:[Addreg], 32
Nextrol_1:
        push    CS
        pop     ES
Nameb_1:
        lodsb
        cmp     AL, '.'
        jne     Nextn_1
        cmp     byte ptr DS:[SI], '.'
        jne     Extent_1
        stosb
        inc     DI
        movsb
        inc     DI
        jmp     Return_1
Nextn_1:
        cmp     AL, 0
        jne     Nextp_1
        jmp     Return_1
Nextp_1:
        cmp     AL, 64
        jng     Nextppp_1
        cmp     AL, 90
        jg      Nextppp_1
        add     AL, CS:[Addreg]
Nextppp_1:
        stosb
        inc     DI
        jmp     Nameb_1
Extent_1:
        push    SI
        mov     AH, 0
        mov     AL, BL
        call    Place
        add     SI, 80
        mov     DI, SI
        pop     SI
        add     DI, 18
Notret_1:
        lodsb
        cmp     AL, 0
        je      Return_1
        cmp     AL, 64
        jng     Nextpp_1
        cmp     AL, 90
        jg      Nextpp_1
        add     AL, CS:[Addreg]
Nextpp_1:
        stosb
        inc     DI
        jmp     Notret_1
Return_1:
        pop     DS
        mov     CS:[Addreg], 0
        inc     BX
        cmp     Filecountright, 50
        jge     Next___1
        cmp     BX, Filecountright
        je      Exitputext1
        jmp     Putextright
Next___1:
        cmp     BX, 51
        je      Exitputext1
        jmp     Putextright
Exitputext1:
        ret
Putextright endp

Sortdir proc
        call    Cartleft
        mov     _Temp_1, 0
        push    ES
        push    DS
        push    Frameaddr1
        pop     DS
Sortdirnext:
        mov     AX, CS:[_Temp_1]
        mov     CS:[_Temp_], AX
        mov     AX, word ptr CS:[_Temp_]
        inc     word ptr CS:[_Temp_]
        dec     AX
        cmp     AX, word ptr CS:[Filecount]
        jge     Exitsortdir
        inc     AX
        mov     CX, 14
        mul     CX
        mov     SI, AX
        lodsb
        rol     AL, 4
        mov     AX, CS:[_Temp_]
        mov     CS:[_Temp_1], AX
        jc      Sortdirnext
        push    CS:[Frameaddr1]
        pop     ES
        mov     DI, SI
        dec     DI
Sortdirnext2:
        mov     AX, word ptr CS:[_Temp_]
        inc     word ptr CS:[_Temp_]
        dec     AX
        cmp     AX, word ptr CS:[Filecount]
        je      Exitsortdir
        inc     AX
        mov     CX, 14
        mul     CX
        mov     SI, AX
        lodsb
        rol     AL, 4
        jnc     Sortdirnext2
        dec     SI
        mov     CX, 14
Xchgname:
        mov     AH, byte ptr ES:[DI]
        movsb
        mov     byte ptr DS:[SI-1], AH
loop    Xchgname
        jmp     Sortdirnext
Exitsortdir:
        pop     DS
        pop     ES
        ret
Sortdir endp

Sortdirright proc
        call    Cartright
        mov     _Temp_1, 0
        push    ES
        push    DS
        push    Frameaddr2
        pop     DS
Sortdirnext_:
        mov     AX, CS:[_Temp_1]
        mov     CS:[_Temp_], AX
        mov     AX, word ptr CS:[_Temp_]
        inc     word ptr CS:[_Temp_]
        dec     AX
        cmp     AX, word ptr CS:[Filecountright]
        jge     Exitsortdir_
        inc     AX
        mov     CX, 14
        mul     CX
        mov     SI, AX
        lodsb
        rol     AL, 4
        mov     AX, CS:[_Temp_]
        mov     CS:[_Temp_1], AX
        jc      Sortdirnext_
        push    CS:[Frameaddr2]
        pop     ES
        mov     DI, SI
        dec     DI
Sortdirnext2_:
        mov     AX, word ptr CS:[_Temp_]
        inc     word ptr CS:[_Temp_]
        dec     AX
        cmp     AX, word ptr CS:[Filecountright]
        je      Exitsortdir_
        inc     AX
        mov     CX, 14
        mul     CX
        mov     SI, AX
        lodsb
        rol     AL, 4
        jnc     Sortdirnext2_
        dec     SI
        mov     CX, 14
Xchgname_:
        mov     AH, byte ptr ES:[DI]
        movsb
        mov     byte ptr DS:[SI-1], AH
loop    Xchgname_
        jmp     Sortdirnext_
Exitsortdir_:
        pop     DS
        pop     ES
        ret
Sortdirright endp

Enterpress proc
        cmp     Column, 0
        je      Nextenterpress_12
        jmp     Nextenterpress
Nextenterpress_12:
        call    Cartleft
        mov     AL, Pointer
        mov     AH, 0
        add     AX, Extoff
        mov     CX, 14
        mul     CX
        mov     SI, AX
        push    DS
        push    Frameaddr1
        pop     DS
        lodsb
        rol     AL, 4
        jnc     Filepress
        cmp     byte ptr DS:[SI], '.'
        jne     Nextenter
        push    SI
        push    DS

        push    CS
        pop     DS
        lea     SI, Dta
        mov     DL, 0
        mov     AH, 47h
        int     21h
        lea     SI, Dta
Findenter:
        lodsb
        cmp     AL, 0
        jne     Findenter
        dec     SI
        std
Findenter1:
        cmp     SI, offset Dta
        je      _Next_
        lodsb
        cmp     AL, '\'
        jne     Findenter1
        inc     SI
        inc     SI
_Next_:
        cld
        lea     DI, Olddir
        mov     AL, 2
        stosb
        mov     CX, 13
Finddir:
        lodsb
        cmp     AL, 0
        je      Exitfinddir
        stosb
        dec     CX
        jmp     Finddir
Exitfinddir:
        mov     AL, 0
        rep     stosb
        pop     DS
        pop     SI
        jmp     Nextenter1
Nextenter:
        mov     byte ptr CS:[Olddir], 0
Nextenter1:
        mov     AH, 3Bh
        mov     DX, SI
        int     21h
        pop     DS
        ret
Filepress:
        lodsb
        cmp     AL, '.'
        je      Pressexten
        cmp     AL, 0
        jne     Filepress
        jmp     Exitenterpress
Pressexten:
        mov     bx,si
        mov     cx,3
        lea     di, ExeExtent
        repe    cmpsb
        cmp     cx,0
        jne     Nextextent
RunPrograms:
        mov     AL, CS:[Pointer]
        mov     AH, 0
        add     AX, CS:[Extoff]
        mov     CX, 14
        mul     CX
        mov     SI, AX
        lodsb
        mov     CX, 13
        lea     DI, Filetoexec
        rep     movsb
        pop     DS
        call    Runanyprogram
        stc
        ret
Nextextent:
        mov     si,bx
        lea     di, ComExtent
        mov     cx,3
        repe    cmpsb
        cmp     cx,0
        je      RunPrograms
        mov     si,bx
        lea     di, BatExtent
        mov     cx,3
        repe    cmpsb
        cmp     cx,0
        je      RunPrograms
        pop     ds
        ret
Exitenterpress:
        stc
        pop     DS
        ret
Nextenterpress:
        call    Cartright
        mov     AL, Pointerright
        mov     AH, 0
        add     AX, Extoffright
        mov     CX, 14
        mul     CX
        mov     SI, AX
        push    DS
        push    Frameaddr2
        pop     DS
        lodsb
        rol     AL, 4
        jnc     Filepress___12
        cmp     byte ptr DS:[SI], '.'
        jne     Nextenter___12
        push    SI
        push    DS

        push    CS
        pop     DS
        lea     SI, Dta
        mov     DL, 0
        mov     AH, 47h
        int     21h
        lea     SI, Dta
Findenter___12:
        lodsb
        cmp     AL, 0
        jne     Findenter___12
        dec     SI
        std
Findenter1___12:
        cmp     SI, offset Dta
        je      _Next____12
        lodsb
        cmp     AL, '\'
        jne     Findenter1___12
        inc     SI
        inc     SI
_Next____12:
        cld
        lea     DI, Olddir
        mov     AL, 1
        stosb
        mov     CX, 13
Finddir___12:
        lodsb
        cmp     AL, 0
        je      Exitfinddir___12
        stosb
        dec     CX
        jmp     Finddir___12
Exitfinddir___12:
        mov     AL, 0
        rep     stosb
        pop     DS
        pop     SI
        jmp     Nextenter1___12
Nextenter___12:
        mov     byte ptr CS:[Olddir], 3
Nextenter1___12:
        mov     AH, 3Bh
        mov     DX, SI
        int     21h
        pop     DS
        ret
Filepress___12:
        lodsb
        cmp     AL, '.'
        je      Pressexten___12
        cmp     AL, 0
        jne     Filepress___12
        jmp     Exitenterpress___12
Pressexten___12:
        mov     bx,si
        mov     cx,3
        lea     di, ExeExtent
        repe    cmpsb
        cmp     cx,0
        jne     Nextextent___12
RunPrograms___12:
        mov     AL, CS:[Pointerright]
        mov     AH, 0
        add     AX, CS:[Extoffright]
        mov     CX, 14
        mul     CX
        mov     SI, AX
        lodsb
        mov     CX, 13
        lea     DI, Filetoexec
        rep     movsb
        pop     DS
        call    Runanyprogram
        stc
        ret
Nextextent___12:
        mov     si,bx
        lea     di, ComExtent
        mov     cx,3
        repe    cmpsb
        cmp     cx,0
        je      RunPrograms___12
        mov     si,bx
        lea     di, BatExtent
        mov     cx,3
        repe    cmpsb
        cmp     cx,0
        je      RunPrograms___12
        pop     ds
        ret
Exitenterpress___12:
        stc
        pop     DS
        ret
Enterpress endp

Tabpress proc
        call    Delmov
        lea     DI, Screen
        add     DI, 3680
        mov     CX, 80
        mov     AH, 0Fh
        mov     AL, 20h
        rep     stosw
        cmp     Column, 0
        je      Nexttab
        mov     dl,byte ptr ds:[LeftDisk]
        sub     dl,65
        mov     ah,0eh
        int     21h
        mov     Column, 0
        lea     DX, Pathleft
        jmp     Nexttab1
Nexttab:
        mov     dl,byte ptr ds:[RightDisk]
        sub     dl,65
        mov     ah,0eh
        int     21h
        mov     Column, 1
        lea     DX, Pathright
Nexttab1:
        mov     AH, 3Bh
        int     21h
        call    Path
        call    Mover
        call    Scrchg
        ret
Tabpress endp

Boot:
        push    0
        pop     ds
        mov     bx,word ptr ds:[019eh]
        mov     ds,bx
        mov     si,0ah
        lea     di,emmtest
        mov     cx,8
        repe    cmpsb
        jz      EmmPresent
        push    cs
        pop     ds
        mov     ah,9
        lea     dx,NoEmm
        int     21h
        mov     ah,0
        int     16h
        int     20h
        mov     ax,4c00h
        int     21h
NoEmm   db      'You have no EMM. This program request EMM to work.',13,10
        db      'Press any key to end program...$'
EmmTest db      'EMMXXXX0'
EmmPresent:
        push    cs
        pop     ds
        call    Getcurdir
        call    Getdisk
        mov     AH, 43h
        mov     BX, 4
        int     67h

        mov     Handleemm1, DX
        mov     AH, 43h
        mov     BX, 4
        int     67h
        mov     Handleemm2, DX
        mov     AH, 41h
        int     67h
        mov     Frameaddr1, BX
        inc     BX
        mov     Frameaddr2, BX
;Set DTA
        mov     AH, 1Ah
        lea     DX, Dta
        int     21h
        mov     Pointer, 0
        jmp     Continuemain
AfterDiskChanged:
;        int      3
        cmp     _Temp_,1
        je      RightChgDrv
        mov     Pointer, 0
        jmp     BeginMain
RightChgDrv:
        mov     Pointerright,0
Beginmain:
        mov     Poscount, -1
        mov     Filecount, -1
        mov     Poscountright, -1
        mov     Filecountright, -1
Continuemain:
        lea     SI, Ramka
        lea     DI, Screen
        mov     CX, 2000
        call    Scrmov
        call    Path
        call    GetFreeSpace

        call    Cmppath
        call    Findright
        call    Sortdirright
        call    Findleft
        call    Sortdir
        call    Putname
        call    Putnameright
        call    Findbackdir
        call    Mover
        call    PutPath
        call    Scrchg
;        call    Scrchg
;        call    Path
        mov     CX, 51
Coolprog:
;        int     3
        mov     AH, 10h
        int     16h

        cmp     AH, 68                  ;F10
        jne     __Next__
        call    Freememory
__Next__:
        cmp     AH, 1                   ;Esc
        jne     ___Next___
        call    Freememory
___Next___:
        cmp     AH, 50h                 ;Down
        jne     Next1
        call    Movdown
        jmp     Coolprog
Next1:
        cmp     AH, 72                  ;Up
        jne     Next2
        call    Movup
        jmp     Coolprog
Next2:
        cmp     AH, 75                  ;Left
        jne     Next3
        call    Movleft
        jmp     Coolprog
Next3:
        cmp     AH, 77                  ;Right
        jne     Next4
        call    Movright
        jmp     Coolprog
Next4:
        cmp     AH, 71                  ;Home
        jne     Next5
        call    Movhome
        jmp     Coolprog
Next5:
        cmp     AH, 79                  ;End
        jne     Next6
        call    Movend
        jmp     Coolprog
Next6:
        cmp     AH, 28                  ;Enter
        jne     Next7
        call    Enterpress
        jc      Coolprog
        call    Scrchg
        call    Path
        jmp     Beginmain
Next7:
        cmp     AH, 14                  ;BackSpace
        jne     Next8
        call    Backspace
        jc      Coolprog
        cmp     Column, 0
        je      Nextnextnext
        mov     Pointerright, 0
        mov     Extoffright, 0
        call    Enterpress
        jc      Coolprog__K
        jmp     Beginmain
Coolprog__K:
        jmp     Coolprog
Nextnextnext:
        mov     Pointer, 0
        mov     Extoff, 0
        call    Enterpress
        jc      Notcoolprog
        jmp     Beginmain
Notcoolprog:
        jmp     Coolprog
Next8:
        cmp     AH, 3Bh                 ;F1
        jne     Next9
        call    Help
        jmp     Coolprog
Next9:
        cmp     AH, 3Ch                 ;F2
        jne     Next10
        call    Menu
        jmp     Coolprog
Next10:
        cmp     AH, 3Dh                 ;F3
        jne     Next11
        call    View
        jmp     Coolprog
Next11:
        cmp     AH, 3Eh                 ;F4
        jne     Next12
        call    Edit
        jmp     Coolprog
Next12:
        cmp     AH, 3Fh                 ;F5
        jne     Next13
        int     3
        cmp     InsOrNot,0
        jne     OOOPPPLL
        call    Copy
        jmp     Coolprog
OOOPPPLL:
        call    BeforeCopy
        call    r8_start
        call    ScrChg
        jmp     Coolprog
Next13:
        cmp     AH, 40h                 ;F6
        jne     Next14
        call    Renmov
        jmp     Coolprog
Next14:
        cmp     AH, 41h                 ;F7
        jne     Next15
        call    Mkdir
        jmp     Coolprog
Next15:
        cmp     AH, 42h                 ;F8
        jne     Next16
        call    Delete
        jmp     Coolprog
Next16:
        cmp     AH, 43h                 ;F9
        jne     Next17
        call    Pulldown
        jmp     Coolprog
Next17:
        cmp     AH, 15                  ;Tab
        jne     Next18
        call    Tabpress
        jmp     Coolprog
Next18:
        cmp     al,0
        jne     Next19
        cmp     ah,68h                  ;Alt+F1
        jne     Next181
        mov     Addreg,0
        call    ChgDrive
        cmp     AddReg,1
        jne     aaa_1
        jmp     Coolprog
aaa_1:
        jmp     AfterDiskChanged
Next181:
        cmp     ah,69h                  ;Alt+F2
        jne     Next182
        mov     Addreg,80
        call    ChgDrive
        cmp     AddReg,1
        jne     aaa_2
        jmp     Coolprog
aaa_2:
        jmp     AfterDiskChanged
Next182:
        cmp     ah,6eh                  ;Alt+F7
        jne     Next19
        call    Poisk_Boot
        mov     ah,1ah
        lea     dx,DTA
        int     21h
        call    Path
        call    ScrChg
        jmp     CoolProg
Next19:
        cmp     ah,52h                  ;Insert
        jne     Next20
;        int     3
        call    Insert
        jmp     Coolprog
Next20:
        cmp     ah,96h                  ;Ctrl *         ;
        jne     Next21                                  ;
        call    MbrAndBr                                ;
        jmp     Coolprog                                ;
Next21:                                                 ;
        jmp     Coolprog
        include          hex2dec.asm
        include          emm1.asm
        include          n_myexec.asm
        include          poisk.asm
        include          bootread.asm
        include          mbread.asm
        include          mbwrite.asm
        include          bootwrt.asm
        include          mbr_bs.asm                     ;
        include          getfinfo.asm
        include          needed.asm
        include          new.asm
DTA:
end     Entry
End.
