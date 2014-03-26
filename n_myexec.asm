;        .286
;        .Model  Tiny
;        .Code
;        Org     100h
;m5_Entry:
;       Jmp     m5_Start
;       FileToExec          Db 'commandr.com', 0
m5_P500    Proc Near
        Push    Ax
        Mov     Ah, 9
        Int     21h
        Pop     Ax
        Ret
m5_P500    Endp
        m5_Baddos          Db 'DOS 2.00 or later required', 07, '$'
        m5_Nocomm          Db 'No file entered', 07, '$'
        m5_Badmem          Db 'Unable to release memory.  Error: '
        m5_Memerr          Dw 0
                        Db 7, '$'
        m5_Badcal1         Db 'Unable to execute program $'
        m5_Badcal2         Db '  Error: '
        m5_Callerr         Dw 0
                        Db 7, '$'
        m5_Prog            Db 80 Dup(0)
        m5_Comm1           Db 80 Dup(0)
        m5_Fcb1            Db 40 Dup(0)
        m5_Fcb2            Db 40 Dup(0)
        m5_Stak            Dw 0
                        Dw 0
        m5_Signature       Dw 01237h
        m5_Another         Dw 0
        m5_Prog1           Db 80 Dup(0)
        m5_Prog2           Db 80 Dup(0)
        m5_Prog3           Db 80 Dup(0)
        m5_Prog4           Db 80 Dup(0)
        m5_Parm1           Dw 0
        m5_Parm2           Dd 0
        m5_Parm3           Dd 0
        m5_Parm4           Dd 0
        m5_Endprog         Db 0
m5_Start:
          pusha
          push es
          push ds
m5_P000:
        Mov     Ah, 30h
        Int     21h
        Cmp     Al, 0
        Jnz     m5_P005
        Mov     Dx, Offset m5_Baddos
        Call    m5_P500
        Jmp     m5_P099
m5_P005:
        Push    Ds
        Xor     Ax, Ax
        Mov     Ds, Ax
        Mov     Si, 4F0h
        Mov     Ax, Offset m5_Another
        Mov     [Si], Ax
        Add     Si, 2
        Mov     Ax, Es
        Mov     [Si], Ax
        Pop     Ds
m5_P010:
        Mov     Si, 80h
m5_P015:
        Mov     Al, [Si]
        Cmp     Al, 0
        Jmp     m5_Main
        Mov     Dx, Offset m5_Nocomm
        Call    m5_P500
        Jmp     m5_P099
m5_P020:
        Mov     Ch, 0
        Mov     Cl, Al
        Inc     Si
        Mov     Al, [Si]
        Cmp     Al, ' '
        Jnz     m5_P021
        Inc     Si
        Dec     Cl
m5_P021:
        Push    Cx
        Mov     Al, 0
        Mov     Cx, Offset m5_Stak
        Mov     Di, Offset m5_Prog
        Sub     Cx, Di
        Repnz   Stosb
        Pop     Cx
        Mov     Di, Offset m5_Prog
m5_P022:
        Mov     Al, [Si]
        Cmp     Al, ' '
        Jz      m5_P025
        Cmp     Al, '/'
        Jz      m5_P025
        Mov     [Di], Al
        Inc     Si
        Inc     Di
        Loop    m5_P022
m5_Main:
        Push    Si
        Push    Di
        Push    Ax
        Mov     Si, Offset FileToExec
        Mov     Di, Offset m5_Prog
m5_@D:
        Mov     Ah, [Si]
        Cmp     Ah, 0
        Je      m5_@Ms
        Mov     [Di], Ah
        Inc     Si
        Inc     Di
        Jmp     m5_@D
m5_@Ms:
        Mov     Byte Ptr [Di], 0
        Pop     Ax
        Pop     Di
        Pop     Si
m5_P025:
        Push    Si
        Mov     Di, Offset m5_Comm1
        Mov     [Di], Cl
        Inc     Di
        Repnz   Movsb
        Mov     Al, 0Dh
        Mov     [Di], Al
        Pop     Si
        Mov     Di, Offset m5_Fcb1
        Mov     Ah, 29h
        Mov     Al, 1
        Int     21h
        Mov     Di, Offset m5_Fcb2
        Mov     Ah, 29h
        Mov     Al, 1
        Int     21h
m5_P040:
        Mov     Bx, 4096
        Mov     Ah, 4Ah
        Int     21h
        Jnc     m5_P050
        Aam
        Add     Ax, 3030h
        Xchg    Ah, Al
        Mov     Si, Offset m5_Memerr
        Mov     [Si], Ax
        Mov     Dx, Offset m5_Badmem
        Call    m5_P500
        Jmp     m5_P099
m5_P050:
        Mov     Si, Offset m5_Parm2
        Mov     Dx, Offset m5_Comm1
        Mov     [Si], Dx
        Mov     Ax, Ds
        Mov     [Si+2], Ax
m5_P060:
        Mov     Si, Offset m5_Parm3
        Mov     Dx, Offset m5_Fcb1
        Mov     [Si], Dx
        Mov     Ax, Ds
        Mov     [Si+2], Ax
        Mov     Si, Offset m5_Parm4
        Mov     Dx, Offset m5_Fcb2
        Mov     [Si], Dx
        Mov     Ax, Ds
        Mov     [Si+2], Ax
m5_P070:
        Mov     Si, Offset m5_Stak
        Mov     [Si], Sp
        Mov     [Si+2], Ss
        Mov     Ah, 4Bh
        Mov     Al, 0
        Mov     Dx, Offset m5_Prog
        Mov     Bx, Offset m5_Parm1
        Int     21h
        Mov     Bx, Cs
        Mov     Ds, Bx
        Mov     Es, Bx
        Mov     Si, Offset m5_Stak
        Cli
        Mov     Sp, [Si]
        Mov     Ss, [Si+2]
        Sti
        Jnc     m5_P080
        Aam
        Add     Ax, 3030h
        Xchg    Ah, Al
        Mov     Si, Offset m5_Callerr
        Mov     [Si], Ax
        Mov     Dx, Offset m5_Badcal1
        Call    m5_P500
        Mov     Si, Offset m5_Comm1
        Mov     Al, '$'
        Mov     [Si], Al
        Mov     Dx, Offset m5_Prog
        Call    m5_P500
        Mov     Dx, Offset m5_Badcal2
        Call    m5_P500
        Jmp     m5_P099
m5_P080:
        Mov     Si, Offset m5_Another
        Mov     Cx, [Si]
        Jcxz    m5_P099
        Dec     Cx
        Mov     [Si], Cx
        Mov     Si, Offset m5_Prog1
        Mov     Ax, 80
        Mul     Cx
        Add     Si, Ax
        Jmp     m5_P015
m5_P099:
        Push    Ds
        Xor     Ax, Ax
        Mov     Ds, Ax
        Mov     Si, 4F0h
        Mov     [Si], Ax
        Add     Si, 2
        Mov     [Si], Ax
        Pop     Ds

          pop ds
          pop es
          popa

        ret
;        Int     20h
;End     m5_Entry
;End.
