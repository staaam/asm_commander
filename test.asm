        .model  tiny
        .code
        org     100h
Start:
        jmp    Boot
        db     58 dup ('s')
StackB  dw     'ss'
Boot:
        mov    ax,cs                   ; Set stack before
        mov    ss,ax                   ; shrink memory
        mov    sp,offset StackB        ; block

        lea    bx,@End
        add    bx,16
        mov    cl,4
        shr    bx,cl
        mov    ah,4Ah
        int    21h

        mov    ax,cs
        mov    MYEPB.FCB1_Seg,ax
        mov    MYEPB.FCB2_Seg,ax
        mov    MYEPB.CMD_Seg,ax
        mov    ax,cs:[2Ch]
        mov    MYEPB.Environment,ax
        mov    dx,offset String
        mov    bx,offset MYEPB
        mov    ax,4B00h
        int    21h
        int    20h

EPB             struc
Environment     dw     0
CMD_Offset      dw     80h
CMD_Seg         dw     0
FCB1_Offset     dw     5Ch
FCB1_Seg        dw     0
FCB2_Offset     dw     6Ch
FCB2_Seg        dw     0
EPBLength       db     0Eh
EPB             ends

String          db        'C:\command.com',0
MYEPB           EPB       <>
@End:
end     Start
end.