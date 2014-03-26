

        jmp     r8_start
r8_str_copy1    db      '╔════════════════════════ Копирование файлов ════════════════════════╗',0
                db      '║                                                                    ║',0
                db      '║ Копировать: "autoexec.bat" в                                       ║',0
                db      '║ [C:\·····························································] ║',0
                db      '╟────────────────────────────────────────────────────────────────────╢',0
                db      '║   [ ] Включая подкаталоги     [ ] Копировать только новые          ║',0
                db      '║   [ ] Использовать фильтр     [ ] Проверить свободное место        ║',0
                db      '╟────────────────────────────────────────────────────────────────────╢',0
                db      '║        Выполнить  ▄    F10-Дерево ▄     Фильтр  ▄    Отмена ▄      ║',0
                db      '║       ▀▀▀▀▀▀▀▀▀▀▀▀▀   ▀▀▀▀▀▀▀▀▀▀▀▀▀   ▀▀▀▀▀▀▀▀▀▀▀   ▀▀▀▀▀▀▀▀▀      ║',0
                db      '╚════════════════════════════════════════════════════════════════════╝',0

r8_str_copy             db      '╔═══════════ Копирование файлов ═══════════╗',0
                        db      '║                                          ║',0
                        db      '║         Копирую файл или каталог         ║',0
                        db      '║                                          ║',0
                        db      '║                     в                    ║',0
                        db      '║                                          ║',0
                        db      '║    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░   ║',0
                        db      '║                                          ║',0
                        db      '╚══════════════════════════════════════════╝',0


r8_strEMM               db      "EMMXXXX0",0
r8_er_find_emm  db      'Error! No EMM in memory.$'
r8_str_no_open  db      'No open file!$'
r8_hf1          dw      ?
r8_hf2          dw      ?
r8_frame_emm    dw      ?
r8_handle               dw      ?
r8_l_file               dd      ?
r8_main_st              db      70 dup (0)
;CopySour              db      't.asm',0
;CopyDest                db      'd:\gr99-08\t.asm',0

r8_first        dw      ?

r8_ten  proc
        inc     di
        push    es
        push    0B800h
        pop     es
        push    cx
r8_t1:
        mov     es:[di],ah
        add     di,2
        loop    r8_t1
        pop     cx
        sub     di,160+2
        mov     es:[di],ah
        sub     di,2
r8_t2:
        mov     es:[di],al
        sub     di,2
        loop    r8_t2
        pop     es
        ret
r8_ten  endp

r8_ten_big      proc
        inc     di
        push    es
        push    0B800h
        pop     es
r8_t3:
        mov     es:[di],ah
        add     di,2
        loop    r8_t3

        mov     cx,bx
        sub     di,160+2
        mov     es:[di],ah
        sub     di,2
r8_t4:
        mov     es:[di],ah
        sub     di,160
        loop    r8_t4

        mov     cx,bx
        add     di,2+160
        mov     es:[di],ah
r8_t5:
        mov     es:[di],ah
        add     di,160
        loop    r8_t5

        pop     es
        ret
r8_ten_big      endp

r8_print        proc
         push    di
r8_nchar:
         lodsb
         stosw
         cmp     al,0
         jne     r8_nchar
         pop     di
         add     di,160
         push    di
         loop   r8_nchar
         pop    di
         ret
r8_print        endp

r8_start:
        push    ds
        push    es
        pusha



         push    0B800h
         pop     es
         push    cs
         pop     ds
         mov     cx,11
         mov     di,160*7+2*4
         mov     si,offset r8_str_copy1
         mov     ah,7fh
         call    r8_print

        mov     si,offset PathRight
        cmp     byte ptr cs:[column],1
        jne     r8_go_pr
        mov     si,offset PathLeft
r8_go_pr:
        mov     cx,1
         mov     di,160*10+2*7
        mov     ah,7fh
        call    r8_print

        mov     ax,70F7h
        mov     cx,13
        mov     di,160*16+2*12
        call    r8_ten

        mov     ax,70f7h
        mov     cx,13
        mov     di,160*16+2*28
        call    r8_ten

        mov     ax,70f7h
        mov     cx,11
        mov     di,160*16+2*44
        call    r8_ten

        mov     ax,70F7h
        mov     cx,9
        mov     di,160*16+2*58
        call    r8_ten

        mov     ah,07h
        mov     cx,71
        mov     bx,10
        mov     di,160*18+2*6
        call    r8_ten_big

r8_nbeg:


        xor     ax,ax
        int     16h
        cmp     al,0Dh
        je      r8_beg
        cmp     al,1Bh
        jne     r8_nbeg
        jmp     r8_end_p
r8_beg:
;пр. файла
        int     3
        cmp     word ptr cs:[insornot],0
        je      r8_copyw
        call    CopyFiles
r8_copyw:
        call    ScrChg

        mov      cx,9
         mov     di,160*8+2*17
         mov     si,offset r8_str_copy
         mov     ah,7Fh
        call     r8_print
;print name file
        mov     si,offset CopySour
        xor     di,di
r8_next_n:
        inc     si
        dec     di
        cmp     byte ptr ds:[si],0
        je      r8_pass_n
        jmp     r8_next_n
r8_pass_n:
        add     di,160*11+2*40
        mov     cx,di
        and     cx,1
        cmp     cx,1
        jne     r8_go1
        dec     di
r8_go1:
        mov     si,offset CopySour
        mov     cx,1
        mov     ah,7Fh
        call    r8_print

        mov     si,offset CopyDest
        xor     di,di
r8_next_t:
        inc     si
        dec     di
        cmp     byte ptr ds:[si],0
        je      r8_pass_t
        jmp     r8_next_t
r8_pass_t:
        add     di,160*13+2*40
        mov     cx,di
        and     cx,1
        cmp     cx,1
        jne     r8_go2
        dec     di
r8_go2:
        mov     si,offset CopyDest
        mov     cx,1
        mov     ah,7fh
        call    r8_print
;find emm in memory
r8_pass:
        cld
        push    ds
        xor     ax,ax
        mov     ds,ax
        mov     ax,ds:[67h*4+2]
        mov     ds,ax
        push    cs
        pop     es
        mov     si,0Ah
        mov     di,offset r8_strEMM
        mov     cx,8
        rep     cmpsb
        pop     ds
        je      r8_next1
        mov     ah,09h
        mov     dx,offset r8_er_find_emm
        int     21h
        int     20h
r8_next1:
;get_free_emm_memory
        mov     ah,43h
        mov     bx,4
        int     67h
        mov     cs:[r8_handle],dx
;get frame emm
        mov     ah,41h
        int     67h
        mov     cs:[r8_frame_emm],bx

;raspred. memory in emm
        mov     ah,44h
        mov     al,0
        mov     bx,0
        int     67h

        mov     ah,44h
        mov     al,0
        mov     bx,1
        int     67h

        mov     ah,44h
        mov     al,0
        mov     bx,2
        int     67h

        mov     ah,44h
        mov     al,0
        mov     bx,3
        int     67h

;open file (t.asm)
        int     3
        mov     ah,3dh
        mov     dx,offset CopySour
        mov     al,0
        int     21h
        jnc     r8_next2
        mov     ah,09h
        mov     dx,offset r8_str_no_open
        int     21h
        int     20h
r8_next2:
        mov     cs:[r8_hf1],ax
        mov     bx,ax

;size open file
        mov     ax,4202h
        xor     cx,cx
        xor     dx,dx
        int     21h
        mov     word ptr cs:[r8_l_file],ax
        shl     dx,1
        mov     word ptr cs:[r8_l_file+2],dx
        mov     word ptr cs:[r8_first],dx

;seek start file
        mov     ax,4200h
        xor     cx,cx
        xor     dx,dx
        int     21h


;creat file (d:\gr99-08\t.asm)
        mov     ah,3ch
        push    cs
        pop     ds
        mov     dx,offset CopyDest
        mov     cx,0
        int     21h
        int     3
        mov     cs:[r8_hf2],ax



;set adr frame
        mov     dx,cs:[r8_frame_emm]
        mov     ds,dx
        xor     dx,dx
        mov     cx,word ptr cs:[r8_l_file]
r8_next4:
;read file (t.asm)
        mov     ah,3fh
        mov     bx,cs:[r8_hf1]
        int     21h

;write data in file (d:\gr99-08\t.asm)
        mov     ah,40h
        mov     bx,cs:[r8_hf2]
        int     21h
;stroka
        mov     ax,35
        mov     bp,cs:[r8_first]
        sub     bp,word ptr cs:[r8_l_file+2]
        mul     bp
        mov     bp,10
        cmp     cs:[r8_first],0
        je      r8_pass1
        div     cs:[r8_first]
r8_pass1:
        mov     cx,ax
        mov     ah,7Fh
        mov     al,'█'
        push    es
        push    di
        mov     di,0B800h
        mov     es,di
        mov     di,160*14+2*22
        rep     stosw
        pop     di
        pop     es

        cmp     word ptr cs:[r8_l_file+2],0
        je      r8_next3
        dec     word ptr cs:[r8_l_file+2]

        mov     cx,8000h
        jmp     r8_next4
r8_next3:

;close file (t.asm)
        mov     bx,cs:[r8_hf1]
        mov     ah,3eh
        int     21h


;close file (d:\gr99-08\t.asm)
        mov     bx,cs:[r8_hf2]
        mov     ah,3eh
        int     21h

;osvob. memory in emm
        mov     ah,45h
        mov     dx,cs:[r8_handle]
        int     67h
r8_end_p:

        popa
        pop     es
        pop     ds

        ret