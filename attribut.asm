       .286
       .model  tiny
       .code
       org     100h
Entry:
       jmp     Boot
FName  db      'mbr.sec',0
Boot:
       mov     ah,1ah
       lea     dx,DTA
       int     21h
       mov     ah,4eh
       lea     dx,FName
       mov     cx,3fh
       int     21h
       int     20h
DTA:
end    Entry
end.