;        .286
;        .286
;        .model  Tiny
;        .code
;        org     100h
;Start:
jmp     poisk_Boot

                fnd db ?
                handle dw ?
pathemm dw ?
boroda1 dw 0
razmer dw 0
addrpathframe dw ?
nul db 0
ne_otkryvat db ?
Buffer  db      512 dup(?)
SizeT   dw      5
oldpath db 64 dup  (0)
DIR DB 5 DUP (0)
old1path db 64 dup  (0)
;namef   db      '*.*',0
old_dir db      '..',0
new_st  db      10,13,0
st_dir  db      '  <DIR>',0
lab_dir db      0
buf db 16H dup (0)
tchk db ?
a1 db ?
net db ?
xxx dw ?
LENG DW ?
esh db ?
f dw ?
handleemm dw ?


ATTRIBUT DB ?



emmpath proc
        mov ah,40h
        int 67h

        mov     ah,43h
        mov     bx,4
        int     67h

        mov     cs:[pathEMM],dx

        mov     ah,41h
        int     67h
        add bx,1
        mov     cs:[addrpathframe],bx

        mov     cx,cs:[addrpathframe]
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
emmpath endp

vyvod_kol_vo proc
       mov      ax,cs:[total]
       lea      di,total
       dec      di
       std
       call     aword
       cld

             push ax
             push bx
             push cx
             mov dx,word ptr cs:[total]
;             call perevod
             pop cx bx ax

        push    ds
        push    es
        push    cs
        pop     ds
        push    0B800h
        pop     es
        lea si,vyvod
        mov di,19*160+2*12
        mov     ah,40h ;2Fh
net_ch:
        lodsb
        stosw
        cmp     al,0
        jne     net_ch
        dec di
        dec di
        mov al,40h
        mov ah,ds:[si]
        mov es:[di],ah
        inc di
        mov es:[di],al
        inc di
        inc si
        mov ah,ds:[si]
        mov es:[di],ah
        inc di
        mov es:[di],al
        inc di
        inc si
        mov ah,ds:[si]
        mov es:[di],ah
        inc di
        mov es:[di],al
        inc di
        inc si
        mov ah,ds:[si]
        mov es:[di],ah
        inc di
        mov es:[di],al

        pop     es
        pop     ds

        ret
vyvod_kol_vo endp


putfile proc
      push bx
      mov cx,0
      mov bp,0
      mov di,160+2*5
      push 0b800h
      pop es
      ;xor bx,bx
djnext:
      mov ah,byte ptr dta[bx]        ;'''''
      cmp ah,0
      je @ndrey
      cmp ah,20
      je djendproc
      inc bp
      mov  byte ptr es:[di],ah
      jmp @1
@ndrey:
;      inc bx                ;for 14-zero michael's suxx code system
;      mov ah,ffile[bx]      ;
;      cmp ah,0              ;
;      jne nc                ;
;      jmp @ndrey            ;

nc:   inc cx
      cmp cx,9
      je djendproc
      add di,158
      add bp,bp
      sub di,bp
      mov bp,0
@1:
      inc di
      inc di
      inc bx
      jmp djnext
djendproc:
      pop bx
      ret
putfile endp

;=-=-=-=-----------=-==-+_++



putcursor proc
      mov di,(160*1)+2*5
      mov bp,1
      mov cx,14
tpp:
      push 0b800h
      pop es
      mov  byte ptr es:[di+bp],0fh
      add bp,2
      loop tpp
      ret
putcursor endp
;--=-=-=-=
putcat proc
      push es
      push bx
      push cx
      push dx
      push ax
      mov di,(160*12+2*14)
      push 0b800h
      pop es
      mov cx,tekfile
      dec cx
      cmp cx,0
      je  hren           ;listcat
      mov bx,0
      mov dx,0
listcat:
      inc bx
      push es
      push cs:[addrpathframe]    ;
      pop es                     ;
      mov ah,byte ptr es:[bx-1]
      pop es
      cmp ah,0
      jne listcat
      loop listcat
      inc bx
hren:
      push es
      push cs:[addrpathframe]    ;
      pop es ;
      push bx
      push dx
       call cart1
       pop dx
       pop bx
      mov ah,byte ptr es:[bx-1]    ;-1
      pop es
      cmp ah,0
      je  endcat
      mov es:[di],ah
      inc di
      inc di
      inc bx                  ;ya
      jmp hren
endcat:
      call cart1
      pop ax
      pop dx
      pop cx
      pop bx
      pop es

      ret
putcat endp

;==-=-=-=-=-=-=-

putcursord proc

      mov di,10

      mov cx,dx
add1:
      add di,160
      loop add1

      mov bp,1
      mov cx,14
tpp1:
      push 0b800h
      pop es
      mov  byte ptr es:[di+bp],62     ;;;;;;;;!!!!
      add bp,2
      loop tpp1


      inc dx

;      mov di,(160*bx)+2*5
      add di,160
      mov bp,1
      mov cx,14
tpp2:
      push 0b800h
      pop es
      mov  byte ptr es:[di+bp],0fh     ;;0015h
      add bp,2
      loop tpp2
      ret
putcursord endp
;=-0=-=-0=-0=-0=-0=-0
putcursoru proc

      mov di,10

      mov cx,dx
add2:
      add  di,160
      loop add2

      mov bp,1
      mov cx,14
tpp3:
      push 0b800h
      pop es
      mov  byte ptr es:[di+bp],62
      add bp,2
      loop tpp3


      dec dx

;     mov di,(160*bx)+2*5
      sub di,160
      mov bp,1
      mov cx,14
tpp4:
      push 0b800h
      pop es
      mov  byte ptr es:[di+bp],0fh
      add bp,2
      loop tpp4
      ret
endp  putcursoru




fromemmtodta proc
        push    word ptr cs:[addrframe]
        pop     ds
        push cs
        pop es
        xor     Si,si
        lea di,dta
        mov     cx,cs:[total]
        mov al,15
        imul cx
        xchg cx,ax
        cld
        rep     movsb
        mov byte ptr es:[di],20
ret
endp fromemmtodta

oldPUTH PROC
     PUSH AX
     PUSH BX
     PUSH CX
     PUSH DX
        mov     ah, 19h         ;Get Current Drive
        int     21h
        add     al, 65
        mov     byte ptr ds:[oldPath], al
        mov     word ptr ds:[oldPath+1], '\:'
        mov     ah, 47h
        mov     si,offset ds:[oldPath]
        add     si, 3
        mov     dl, 0
        int     21h
        mov     bx, 3
        lea si,oldpath
        xor cx,cx
@l11:
        lodsb
        inc cx
        cmp al,0
        je @x11
        jmp @l11
@x11:
        cmp cx,4
        je n11
        mov bx,cx
        mov byte ptr oldpath[bx],'\'
n11:
   POP DX CX BX AX
   RET
ENDP oldPUTH





FIGNA PROC
      PUSH AX SI
      LEA SI,BUF
BLA:
     LODSB
     CMP AL,0
     JE EP
     INT 29H
     JMP BLA
EP:
    POP SI AX
    RET
    FIGNA ENDP
Clear   Proc
        push    Bx
        push    Cx
        mov     cx, 100
@Cls:
        mov     bx, cx
        mov     byte ptr ds:[BUF+bx], 0
        loop    @cls

        pop     Cx
        pop     Bx
        ret
Clear   EndP

DIRECTORY PROC
     PUSH AX
     PUSH BX
     PUSH CX
     PUSH DX
        mov     ah, 19h         ;Get Current Drive
        int     21h
        add     al, 65
        MOV DS:[DIR],AL
        mov     word ptr ds:[DIR+1], '\:'
POP DX CX BX AX
RET
ENDP DIRECTORY



PUTH PROC
     PUSH AX
     PUSH BX
     PUSH CX
     PUSH DX
        mov     ah, 19h         ;Get Current Drive
        int     21h
        add     al, 65
        mov     byte ptr ds:[old1Path], al
       mov     word ptr ds:[old1Path+1], '\:'
        mov     ah, 47h
        mov     si,offset ds:[old1Path]
        add     si, 3
        mov     dl, 0
        int     21h
        mov     bx, 3
        lea si,old1path
        xor cx,cx
@l:
        lodsb
        inc cx
        cmp al,0
        je @x
        jmp @l
@x:
        cmp cx,4
        je n
        mov bx,cx
        dec bx
        mov byte ptr old1path[bx],'\'
n:

        lea si,old1path
        xor cx,cx
@@@:
        inc cx
        lodsb
        cmp al,0
        je @@
        jmp @@@
@@:
        dec cx
        mov cs:[razmer],cx
   POP DX CX BX AX
   RET
ENDP PUTH



Open    Proc
        push    ax
        push    bx
        mov ne_otkryvat,0
        mov al,attribut
        cmp al,0h
        jne otkryt
        mov ne_otkryvat,1
        pop bx
        pop ax
        ret
otkryt:
        cmp al,10h
        jne otkryt1
        mov ne_otkryvat,1
        pop bx
        pop ax
        ret
otkryt1:
        cmp al,28h
        jne otkryt2
        mov ne_otkryvat,1
        pop bx
        pop ax
        ret
otkryt2:
        cmp al,16h
        jne otkryt3
        mov ne_otkryvat,1
        pop bx
        pop ax
        ret
otkryt3:
        cmp al,11h
        jne otkryt4
        mov ne_otkryvat,1
        pop bx
        pop ax
        ret
otkryt4:
        pusha
        popa
        mov     ax, 3D00h
        push ds
        push cs
        pop ds
        mov     dx, Offset buf
        int     21h
        pop ds
        JC OSHIBKA
        mov     CS:[Handle], ax
        pop     bx
        pop     ax
        ret
OSHIBKA:
        mov ne_otkryvat,1
        pop bx
        pop ax
        ret


Open    EndP

Close   Proc
        push    ax
        push    bx

        mov     ah, 3Eh
        mov     bx,CS:[ Handle ]
        int     21h
        pop     bx
        pop     ax
        ret
Close   EndP

Search  Proc
        push    ax
        push    bx
        push    cx
        push    dx
        mov ax,sizet
        xor     si, si
Read:
        mov     ah, 3Fh
        mov     bx, Handle
        mov     cx, 512
        lea     dx, Buffer
        int     21h
        cmp     ax, 00
        je      endfile
        xor     bx, bx
Cycle:
        cmp     ax, bx
        je      Read
        mov     cl, byte ptr ds:[Buffer+bx]
        cmp     cl, byte ptr ds:[Text+si+2]
        jne     nxt1
        inc     si
        cmp     si, SizeT
        je      nxt2

        inc     bx
        jmp     cycle
nxt2:
       MOV FND,1
       jmp     endfile
nxt1:
        cmp     si, 0
        je      nxt3
        inc     bx
        mov     si, 0
        jmp     cycle
nxt3:
        inc     bx
        jmp     cycle
endfile:
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret
Search  EndP

obmen proc
;           PUSH BX
           CALL CLEAR
;           POP BX
           pusha
           push ds
           push es
           pushf
           mov di,offset BUF
           mov cx,16H
er:
           movsb
        loop er
        push bx
        ADD BX,15H
        MOV AL,CS:[bx]
        MOV ATTRIBUT,AL
        pop bx
        MOV CX,0
        mov si,offset buf
ext_ch:
        inc cx
        lodsb
        cmp     al,0
        je      h_pass
        cmp al,2eh
        je h_pass
        jmp     ext_ch
h_pass:
         add cx,3
         mov cs:[f],cx
           popf
           pop es
           pop ds
           popa
           ret
endp obmen
tochka proc
       PUSH BX
       PUSH CX
        mov tchk,0
        lea si,buf
        xor bx,bx
        m:
        inc bx
       lodsb
        cmp al,'.'
        je l
        jmp m
l:
        mov si,(offset buf1)+2
        xor cx,cx
        m1:
        inc cx
        lodsb
        cmp al,'.'
        je ll1
        jmp m1
ll1:
        mov al,buf[bx]
        push bx
        mov  bx,cx
        mov dl,buf1[bx+2]
        pop bx
        cmp dl,'*'
        jne pt
        mov tchk,1
        jmp pots
pt:
        cmp dl,al
        jne pots
        inc cx
        inc bx
        mov al,buf[bx]
        push bx
        mov  bx,cx
        mov dl,buf1[bx+2]
        pop bx
        cmp dl,'*'
        jne pt1
        mov tchk,1
        jmp pots
pt1:
        cmp dl,al
        jne pots
        inc cx
        inc bx
        mov al,buf[bx]
        push bx
        mov  bx,cx
        mov dl,buf1[bx+2]
        pop bx
        cmp dl,'*'
        jne pt2
        mov tchk,1
        jmp pots
pt2:
        cmp dl,al
        jne pots
        mov tchk,1
pots:
      POP CX
      POP BX
      ret
endp tochka

sravn proc
           push cs:[f]
           pop leng
           push ax
           push bx
           push dx
           mov bx,0
           mov cx,LENG
           mov esh,0
eee:
           mov xxx,bx
           mov al,buf[bx]
           mov dl,buf1[bx+2]
           cmp dl,'*'
           jne n1
           mov esh,1
n1:
           cmp esh,1
           jne n2
           cmp dl,'.'
           jne n3
           call tochka
           cmp tchk,1
           jne paas
           mov net,1
           jmp paas
n2:
           cmp al,dl
           jne paas
n3:        mov bx,xxx
           add bx,1
           loop eee
           cmp bx,leng
           jne paas
           mov net,1
paas:
        pop dx
        pop bx
        pop ax

        ret
endp sravn

                                  putch proc
        mov net,0
        call obmen
        call sravn
        cmp net,1
        jne ch11_pass
        mov al,byte ptr Text[1]
        cmp al,0
        je fack
        MOV FND,0

 ;       CALL PUTH

        CALL OPEN
        cmp ne_otkryvat,1
        je ch11_pass
        CALL SEARCH
        CALL CLOSE

        CMP FND,1
        JNE CH11_PASS
fack:
      jmp ch11ok_pass
ch11_pass:
        Jmp CH1_PASS
ch11ok_pass:
        call puth

        PUSH AX
        PUSH BX
        PUSH CX
        PUSH ES
        PUSH DS
        PUSH DI
        PUSH SI
;        CALL FIGNA

        mov ax,3d00h
        lea dx,buf
        int 21h
        jc all1_shit

        mov bx,ax
        mov ah,3eh
        int 21h
        cmp cs:[total],8
        jne @123
@123:
        cmp cs:[total],9
        jne @1234
@1234:
call save_path_in_emm

        mov cx,cs:[addrframe]
        MOV AL,0
        push    word ptr cs:[addrframe]
        pop     es
        MOV DI,CS:[BORODA]
        call cart2
        MOV BYTE PTR ES:[DI],AL
        ADD CS:[BORODA],1
        jmp @all1_shit
all1_shit:
           jmp all_shit
@all1_shit:
        mov cx,cs:[addrframe]
        push    word ptr cs:[addrframe]
        pop     es
        MOV     Si,OFFSET buf
        MOV     Di,CS:[BORODA]
        mov     cx,f
        push cx
        cld
        rep     movsb
        pop cx
        ADD CS:[BORODA],cx
        push cx
        mov bx,14
        sub bx,cx
        mov cx,bx
        mov di,cs:[boroda]
        @nex:
        mov byte ptr es:[di],0ffh
        inc di
        loop @nex

        pop cx
        add cs:[boroda],bx
        ADD CS:[TOTAL],1
        call cart2

        cmp cs:[total],800
        jne all_shit
        POP SI
        POP DI
        POP DS
        POP ES
        POP CX
        POP BX
        POP AX
        pop ax
        jmp end_p



all_shit:
        POP SI
        POP DI
        POP DS
        POP ES
        POP CX
        POP BX
        POP AX

@oshibka:
Ch1_pass:
       ret
Putch   endp






Puts    proc

Fk:
        push es
        push    0b800h
        pop     es
        mov     di, bx                  ;stroka ln
        mov     cx, 51                  ; kol-vo simbols
Kk:
        mov     ah, ds:[si]
        mov     es:[di], ah
        inc     si
        inc     di
        mov     byte ptr es:[di], 62
        inc     di
        loop    Kk

        add     bx, 160                 ;jmp to new line
        pop es
        ret

Puts    endp

Clearpimp proc
push    cx
push es
Clfkk:
        mov     si, offset Cdrop
Clp1:
        mov     bx, (160*16)+18
        push    0b800h
        pop     es
        mov     di, bx                  ;stroka ln
        mov     cx, 80                  ; kol-vo simbols

        mov     ah, ds:[si]
        mov     es:[di], ah
                                        ;inc si
        inc     di
        mov     byte ptr es:[di], 63

Clp2:
        mov     bx, (160*17)+18
        push    0b800h
        pop     es
        mov     di, bx                  ;stroka ln
        mov     cx, 80                  ; kol-vo simbols

        mov     ah, ds:[si]
        mov     es:[di], ah
                                        ;inc si
        inc     di
        mov     byte ptr es:[di], 63

        pop es
        pop     cx
        ret
Clearpimp endp

Putsdrop proc
push    cx
call    Clearpimp
Fkk:
        mov     si, offset Drop
        cmp     Pimpa, 2
        je      P2

P1:
        mov     bx, (160*16)+18
        jmp     Ris
P2:
        mov     bx, (160*17)+18
        jmp     Ris

Ris:
        push es
        push 0b800h
        pop     es
        mov     di, bx                  ;stroka ln
        mov     cx, 80                  ; kol-vo simbols

Kkk:
        mov     ah, ds:[si]
        mov     es:[di], ah
                                        ;inc si
        inc     di
        mov     byte ptr es:[di], 60
        pop es
        pop     cx
        ret

Putsdrop endp

wind     proc
        push    ds
        push    es
        push    cs
        pop     ds
        push    0B800h
        pop     es
        mov     ah,62;2Fh
        push    di
next_ch:
        lodsb
        stosw
        cmp     al,0
        jne     next_ch
        pop     di
        add     di,160
        push    di
        loop    next_ch
        pop     di
        pop     es
        pop     ds
        ret
wind    endp


 wind1     proc
        push    ds
        push    es
        push    cs
        pop     ds
        push    0B800h
        pop     es
        MOV DI,(160*6 + 2*8)
        mov     ah,1fh ;2Fh
        push    di
nxt_ch:
        lodsb
        stosw
        cmp     al,0
        jne     nxt_ch
        pop     di
        add     di,160
        push    di
        loop    nxt_ch
        pop     di
        pop     es
        pop     ds
        ret
wind1    endp



poisk_Boot:

        push    ax
        push    bx
        push    cx
        push    dx
        push    si
        push    di
        push    ds
        push    es

        ; save old path
        call oldputh
        mov     si,offset pan_st
        mov     di,2*3
        mov     cx,24
        call    wind

;        call    Wind                    ; draw window

     ;   xor     ax, ax
     ;   int     33h
     ;   mov     ax, 01h
     ;   int     33h

        mov     Pimpa, 1
        call    Putsdrop

        mov     ah, 02h                 ;put cursor (fn)
        mov     bh, 0
        mov     dh, 11
        mov     dl, 20
        int     10h


        mov     ah, 0ah                 ; input file name
        mov     dx, offset Buf1
        push    dx
        pop     bx
        mov     byte ptr ds:[bx], 13
        int     21h


        xor bx,bx
        mov si,offset buf1
repet:

        lodsb
        cmp al,00h
        je next_zapis
        cmp al,97
        jl zapis
        jmp bla1
        cmp al,122
        jb zapis
bla1:        sub al,32
zapis:
        mov cs:[buf1+bx],al
        add bx,1
        jmp repet

Next_zapis:

        mov     ah, 02h                 ;put cursor (str)
        mov     bh, 0
        mov     dh, 13
        mov     dl, 20
        int     10h






        mov     ah, 0ah                 ; input string
        mov     dx, offset Text
        push    dx
        pop     bx
        mov     byte ptr ds:[bx], 20
        int     21h

        mov ax,word ptr Text[1]
        mov byte ptr sizet,al





        mov     ah, 01h
        mov     ch, 20h
;        mov     cl, 0
        int     10h
Cycling:                                ;begin of loop keyboard at search plase

        xor     ax, ax
        int     16h
        cmp     ah, 1ch                 ;it was entr?
        je      So_What
        cmp     ah, 50h                 ;it was down??
        je      Pdown
        cmp     ah, 48h                 ;it was up???
        je      Pup
        jmp     Cycling

Pdown:
        cmp     Pimpa, 2
        je      Pdownok
        add     Pimpa, 1
Pdownok:
        call    Putsdrop
        jmp     Cycling

Pup:
        cmp     Pimpa, 1
        je      Popok
        dec     Pimpa
Popok:
        call    Putsdrop
        jmp     Cycling

So_What:
        jmp endpr
Endpr:
        pop     es
        pop     ds
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     cx
        cmp cs:[pimpa],1
        JNE NO_ALL_DISK
        CALL DIRECTORY
        MOV AH,3BH
        LEA DX,DIR
        INT 21H
NO_ALL_DISK:
       MOV CS:[TOTAL],0
       MOV CS:[BORODA],0
       mov cs:[boroda1],0
       MOV ax,4000h
       int 67h
       CMP AH,00H
       JE ALL_OK

       mov     ah,45h
       mov     dx,HandleEMM
       int     67h
;;
      INT 20H
;
ALL_OK:
        mov     ah,43h
        mov     bx,4
        int     67h
       CMP AH,00H
        JE OK
       mov     ah,45h
       mov     dx,HandleEMM
       int     67h

        INT 20H

OK:
        mov     cs:[HandleEMM],dx

        mov     ah,41h
        int     67h

       CMP AH,00H
       JE AL_OK

       mov     ah,45h
       mov     dx,HandleEMM
       int     67h

       INT 20H

AL_OK:
        mov     cs:[addrframe],bx

        mov cx,cs:[addrframe]
        mov     ax,4400h
        mov     bx,0
        mov     dx,HandleEMM
        int     67h
        CMP AH,00H
        JE _0OK
       mov     ah,45h
       mov     dx,HandleEMM
       int     67h

        INT 20H

_0OK:

        mov     ax,4400h
        mov     bx,0
        mov     dx,HandleEMM
        int     67h
        CMP AH,00H
        JE _1OK
       mov     ah,45h
      mov     dx,HandleEMM
       int     67h

        INT 20H

_1OK:
        mov     ax,4400h
        mov     bx,0
        mov     dx,HandleEMM
        int     67h
        CMP AH,00H
        JE _2OK
       mov     ah,45h
       mov     dx,HandleEMM
       int     67h

       INT 20H
_2OK:
        mov     ax,4400h
        mov     bx,0
        mov     dx,HandleEMM
        int     67h
        CMP AH,00H
        JE _3OK
       mov     ah,45h
       mov     dx,HandleEMM
       int     67h
        INT 20H
_3OK:
       call emmpath
       mov     bx,offset DTA
setDTA:
       mov     ah,1Ah
        mov     dx,bx
        int     21h
;find first file
        mov     ah,4Eh
        mov     dx,offset namef
        mov     cx,3Fh
        int     21h
        jc      pass
print:
        mov     si,bx
        add     si,1Eh
        call putch
        mov     si,bx
        add     si,15h
        and     byte ptr cs:[si],10h
        cmp     byte ptr cs:[si],0
        je      print_pass
        add     si,9
        cmp     byte ptr cs:[si],'.'
        je      print_pass
        mov     si,offset st_dir
        call    putch
        mov     lab_dir,1
print_pass:
        mov     si,offset new_st
        call    putch
;new_DIR
        cmp     lab_dir,0
        je      next_find
        mov     lab_dir,0
        mov     ah,3Bh
        mov     dx,bx
        add     dx,1Eh
        int     21h
        add     bx,30h
        jmp     setDTA
next_find:
;find next file
        mov     ah,4Fh
        mov     dx,offset namef
        int     21h
        jc      pass
        jmp     print
pass:
        cmp     bx,offset DTA
        je      end_p
        mov     ah,3Bh
        mov     dx,offset old_dir
        int     21h
        sub     bx,30h
        mov     dx,bx
        mov     ah,1Ah
        int     21h
        jmp     next_find
end_p:
       push ds
       push es
       call fromemmtodta
       pop es ds
       mov cx,cs:[total]
       CALL VYVOD_KOL_VO
        cmp cs:[total],0
        jne no_zero

        mov     si,offset @WRITE
        mov     cx,8
        call    wind1
        xor ax,ax
        int 16h

                     ;skdhgfjsdhfgsdnmhf
        jmp pass_pr
no_zero:
         push es
      push cs:[addrpathframe]    ;
      pop es                     ;
      call cart1
      xor di,di
      pop es
        mov     bx,1
        call    putfile
        call    putcursor

        mov dx,1   ;tururru

        mov cs:[djmax],9
        cmp total,8              ;if 9 or more
        jg  djcircle

        push bx
        mov bx,word ptr cs:[total]
        mov word ptr cs:[djmax],bx
       ;mov cs:[djmax],total     ;anihilation
        pop bx
       ; 2-i eraz total not

djcircle:
          call putcat
   ;     int 3h
 ;       mov cs:[tekfile],2
 ;       call putcat
        xor ax,ax
        int 16h
        cmp ah,80
        je  djdown
        cmp ah,72
        je  djup

        cmp ah,28
        je pass_pr


        jmp djcircle

djdown:                      ;;;
      push ax                   ;;;;
      mov ah,byte ptr cs:[tekfile]  ;
      mov al,byte ptr cs:[total]    ;
      cmp ah,al                     ;
      pop ax                        ;
      je lockdn           ;;;       ;
      inc tekfile
      call putcat
lockdn:
      cmp dx,word ptr cs:[djmax]                         ;jefferson=9
      je scrolld
      call putcursord
      jmp  djcircle
scrolld:
      cmp cs:[total],10  ;yyaa
      jl djcircle        ;yyaa

        push ax
;       cmp bx, ((total - 9)*15)+1
        mov     ax,cs:[total]
        sub     ax,9
        shl     ax,4
        sub     ax,cs:[total]
        add     ax,10
        int     3
      cmp bx, ax
        pop ax
      je djcircle                        ;
 ;     pop cx

      add bx,15                           ;
      call putfile                         ;
      jmp djcircle                          ;

djup:
      cmp tekfile,1
      je lockup
      dec tekfile
      call putcat;
lockup:
      cmp dx,1                                ;
      je  scrollu                              ;
      call putcursoru                           ;
      jmp djcircle                               ;
scrollu:                                          ;
      cmp bx,1                                     ;
      je djcircle                                   ;
      sub bx,15
      call putfile
      jmp djcircle         ;tatataatat

;       int 3h

;batoncircle:
;        mov     tekfile,1
;        call    putcat
;        mov     si,offset baton1
;        mov     cx,1
;        mov di,(160*22+6*2)
;        call    drbaton




pass_pr:
        MOV AH,3BH
        LEA DX,oldpath
        INT 21H
     mov cx,cs:[total]
       mov     ah,45h
       mov     dx,HandleEMM
       int     67h

       mov     ah,45h
       mov     dx,pathEMM
       int     67h

       mov ax,0100h
       mov ch,07h
       mov cl,08h
       int 10h
;      int     20h
       push cs
       pop es
       int 3
       ret
        Drop    db ''                  ;data objects
        Cdrop   db ' '
BORODA DW ?
        Handl   dw ?
        Text    db 22 dup (?)
        buf1 db 14 dup (?)
        Pimpa   db ?
        Onesim  db ?
        Count   db ?
;        total DW ?
        djmax dw 0
        addrframe dw ?
        tekfile dw 1
;Dta:
;end     Start
;End.
