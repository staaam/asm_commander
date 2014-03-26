GetFileInfo proc
       mov      ah,Column
       push     ax
       mov      Column,0
       lea      dx,Pathleft
       call     SetDfltDir
       call     GetFileInfoMain
       inc      Column
       lea      dx,Pathright
       call     SetDfltDir
       call     GetFileInfoMain
       pop      ax
       mov      Column,ah
       cmp      Column,0
       je       LeftGeted
       ret
LeftGeted:
       lea      dx,Pathleft
       call     SetDfltDir
       ret

GetFileInfoMain:
       mov      TempFree,0
       cmp      Column,0
       je       RightGetFileInfo
       mov      TempFree,80
       mov      ah,0
       mov      al,Pointerright
       call     Place
       add      si,80
       mov      cx,12
       lea      di,FNameG
       jmp      GetFName
RightGetFileInfo:
       mov      ah,0
       mov      al,Pointer
       call     Place
       mov      cx,12
       lea      di,FNameG
GetFName:
       cmp      byte ptr ds:[si],20h
       jne      GetFName1
       cmp      byte ptr ds:[si+2],20h
       je       GetFName2
       cmp      cx,1
       je       GetFName10
       mov      byte ptr es:[di],'.'
       inc      si
       inc      si
       inc      di
loop   GetFName
GetFName2:
       cmp      cx,0
       je       GetFName10
       inc      si
       inc      si
loop   GetFName
GetFName1:
       cmp      cx,0
       je       GetFName10
       movsb
       inc      si
loop   GetFName
GetFName10:
       mov      byte ptr es:[di],0
       lea      si,FNameG
       lea      di,Screen
       add      di,3202
       add      di,TempFree
       mov      ah,8bh
       mov      cx,13
PutFName:
       lodsb
       cmp      al,0
       je       PutFName1
       stosw
loop   PutFName
PutFName1:
       mov      al,0
       rep      stosw
;------------------------------------------------
;------------------------------------------------
       mov      ah,4eh
       lea      dx,FNameG
       mov      cx,03fh
       int      21h
       mov      al,byte ptr ds:[(offset DTA)+15h]
       rol      al,4
       jc       Directory00
       push     di
;       int 3h
       mov      cx,10
       lea      di,FSize
       mov      al,0
       rep      stosb

       mov      ax,word ptr ds:[(offset DTA)+1ah]
       mov      dx,word ptr ds:[(offset DTA)+1ah+2]
       lea      di,Kl
       dec      di
       std
       call     adword
       cld

       pop      di
       lea      si,FSize
       mov      cx,10
       mov      ah,8bh
       jmp      PutDir
Directory00:
       lea      si,SubDir
       mov      cx,10
       mov      ah,8bh
PutDir:
       lodsb
       stosw
loop   PutDir
       add      di,2
       mov      si,(offset DTA)+18h
       lodsw
       mov      bx,ax
       push     di
       lea      di,DateTime
       and      ax,001fh
       mov      cl,10
       div      cl
       add      ax,3030h
       stosb
       xchg     ah,al
       stosb
       mov      al,'.'
       stosb
       mov      ax,bx
       and      ax,01e0h
       ror      ax,5
       mov      cx,10
       div      cl
       add      ax,3030h
       stosb
       xchg     ah,al
       stosb
       mov      al,'.'
       stosb
       mov      ax,bx
       and      ax,0fe00h
       ror      ax,9
       mov      cx,10
       div      cl
       add      ax,3038h
       cmp      al,3ah
       jl       @Norm123
       int      3
       mov      bh,ah
       mov      ah,0
       sub      al,30h
       mov      cl,10
       div      cl
       add      ah,30h
       mov      bl,ah
       mov      ax,bx
@Norm123:
       stosb
       xchg     ah,al
       stosb
       mov      al,0
       stosb

       mov      si,(offset DTA)+16h
       lodsw
       mov      bx,ax
       and      ax,0f800h
       ror      ax,11
       mov      cx,10
       div      cl
       add      ax,3030h
       stosb
       xchg     ah,al
       stosb
       mov      al,':'
       stosb
       mov      ax,bx
       and      ax,07e0h
       ror      ax,5
       mov      cx,10
       div      cl
       add      ax,3030h
       stosb
       xchg     ah,al
       stosb
       pop      di
       lea      si,DateTime
       mov      ah,8bh
       mov      cx,14
PutDate:
       lodsb
       stosw
loop   PutDate
       ret
DateTime        db       14 dup (0)
FNameG          db       13 dup (0)
SubDir          db       ' -= DIR =-'
FSize           db       10 dup (0)
Kl              db       0
;Unknow db       '   Unknown'                    ;;;;
GetFileInfo endp

GetFreeSpace proc
       pusha
       mov      al,Column
       push     ax
       mov      Column,0
       mov      dl,LeftDisk
       sub      dl,41h
       mov      ah,0eh
       int      21h
       call     MainFreeSpace
       mov      Column,1
       mov      dl,RightDisk
       sub      dl,41h
       mov      ah,0eh
       int      21h
       call     MainFreeSpace
       pop      ax
       mov      Column,al
       popa
       ret
MainFreeSpace:
       mov      TempFree,0
       cmp      Column,0
       je       LeftFree
       mov      TempFree,80
LeftFree:
       .386
       mov      ah,36h
       mov      dl,0
       int      21h
       push     ax
       mov      eax,0
       pop      ax
       mov      edx,0
       mul      ecx
       mul      ebx
       cmp      edx,0
       je       NormalFree
NormalFree:
       rol      eax,16
       mov      dx,ax
       rol      eax,16
       lea      di,FreeSpace
       add      di,9
       push     ax dx
       mov      eax,0
       mov      edx,eax
       pop      dx ax
       std
       call     adword
       cld
       inc      di
       mov      ah,19h
       int      21h
       add      al,41h
       mov      byte ptr ds:[(offset StringFree)+24],al
       lea      si,Screen
       add      si,3364
       add      si,TempFree
       xchg     si,di
       lea      cx,MMMFree
       sub      cx,si
       inc      cx
@1234567890:
       movsb
       cmp      si,offset StringFree
       jg       NextFree
       mov      byte ptr es:[di],8fh
NextFree:
       inc      di
loop   @1234567890
       ret
TempFree        dw      0
FreeSpace       db      10 dup (0)
StringFree      db      ' байт свободно на диске '
                db      0
MMMFree         db      ':'
GetFreeSpace endp