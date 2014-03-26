;        .model tiny
;        .code
;        org 100h
perevod:
      jmp startp
      ahh db 0
      sum db 0
startp:
       mov ax,cs:[total]
       mov bl,10
       div bl
       mov bl,al
       mov bh,ah
       xchg al,ah
;       push ax
;       xor ax,ax
;       mov al,bl
;       mov bl,16
;;       mul bl
;       mov word ptr sum,ax
;       add sum,bh
;       mov cx,word ptr sum
;       pop ax
;       xor ax,ax
;       mov ax,word ptr sum
       mov cx,2
;       mov bl,10
;       div bl
;       mov bl,al
;       mov bh,ah
               xor bx,bx
aa:
    cmp ah,0h
    jne @22
    mov ahh,48
@22:    cmp ah,1h
    jne @@22
    mov ahh,49
@@22:    cmp ah,2h
    jne @@@22
    mov ahh,50
@@@22:    cmp ah,3
    jne @@@@
    mov ahh,51
@@@@:    cmp ah,04h
    jne @@@@@
    mov ahh,52
@@@@@:    cmp ah,05h
    jne @@1
    mov ahh,53
@@1:    cmp ah,6h
    jne @@@1
    mov ahh,54
@@@1:    cmp ah,7
    jne @@@@1
    mov ahh,55
@@@@1:    cmp ah,08h
    jne @@@@@1
    mov ahh,56
@@@@@1:    cmp ah,09h
    jne b
    mov ahh,57

b:
       xchg al,cs:[ahh]
       mov ah,cs:[ahh]

       mov byte ptr cs:[total+bx],al
       add bx,2
;       int 29h
       loop aa
       ret
;       int 20h
;       end boot
