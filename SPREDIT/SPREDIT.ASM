.model tiny
.code
org 100h
main:
 mov ax, ds
 mov es, ax
 mov di, offset _pic
 mov cx, 27*15
 xor ax, ax
 rep stosb    ; Очистка буфера редактируемой картинки
 mov ax, 13h  ; Графический режим 320/200/256
 int 10h
 mov c, 32
 xor dx, dx
_VK:
 xor cx, cx
_HK:
 mov xr1, cx
 mov yr1, dx
 add cx, 7
 mov xr2, cx
 mov bx, dx
 add bx, 7
 mov yr2, bx
 push cx
 push dx
 call Rect
 pop dx
 pop cx
 cmp cx, 160
 jb _HK
 add dx, 7
 cmp dx, 100
 jb _VK
 mov xr1, 230
 mov yr1, 44
 mov xr2, 254
 mov yr2, 60
 mov c, 32
 call Rect
 ; Показ текущего цвета
 mov xr1, 1
 mov yr1, 185
 mov xr2, 300
 mov yr2, 195
 mov c, 30
 call Bar
 ; --------------------
 xor bl, bl
 xor bh, bh
 mov xr1, 0
 mov yr1, 150
 mov xr2, 5
 mov yr2, 155
_Clrs:
 push bx
 mov c, bl
 call Bar
 pop bx
 add word ptr xr1, 6
 add word ptr xr2, 6
 inc bl
 inc bh
 cmp bl, 255
 je _ExC
 cmp bh, 50
 jne _Clrs
 xor bh, bh
 mov xr1, 0
 mov xr2, 5
 add word ptr yr1, 6
 add word ptr yr2, 6
 jmp _Clrs
_ExC:

 mov ax, 1
 int 33h
_kbd:
 mov ax, 3
 int 33h
 cmp bx, 1
 je _Press
 cmp bx, 2
 je _Press
 in al, 60h
 cmp al, 1
 jne _kbd
 jmp _Exit
_Press:
 mov word ptr _prs, bx
 cmp dx, 150
 jb _Ncmp
 cmp dx, 180
 ja _Ncmp
 call GetColor
 jmp _kbd
_Ncmp:
 cmp cx, 320
 ja _kbd
 dec dx
 cmp dx, 104
 ja _kbd
 push dx
 xor dx, dx
 mov ax, cx
 mov cx, 2
 div cx
 xor dx, dx
 mov cx, 7
 div cx
 mov word ptr xpic, ax
 xor dx, dx
 mul cx
 xchg cx, ax
 pop dx
 push cx
 xchg ax, dx
 xor dx, dx
 mov cx, 7
 div cx
 mov word ptr ypic, ax
 xor dx, dx
 mul cx
 xchg dx, ax
 pop cx
 mov xr1, cx
 mov yr1, dx
 jmp _Z
_kbdh:
 jmp _kbd
_Z:
 push cx
 push dx
 mov ax, 23
 mov cx, word ptr ypic
 mul cx
 add ax, word ptr xpic
 xchg ax, bp
 cmp _prs, 1
 jne _Pr2
 mov al, byte ptr gc
 mov byte ptr [_pic+bp], al
 jmp _ZZ
_Pr2:
 mov byte ptr [_pic+bp], 0
_ZZ:
 pop dx
 pop cx

 push cx
 push dx
 inc cx
 inc dx
 mov xp, cx
 mov yp, dx
 call GetPix
 cmp _prs, 1
 jne _Nxt
 cmp al, 0
 pop dx
 pop cx
 jne _kbdh
 jmp _Nxt2
_Nxt:
 cmp al, 0
 pop dx
 pop cx
 je _kbdh
_Nxt2:

 add dx, 7
 add cx, 7
 mov xr2, cx
 mov yr2, dx
 mov ax, 2
 int 33h
 call WaitRetrace
 cmp _prs, 2
 je _R
 mov al, byte ptr gc
 mov byte ptr c, al
 inc word ptr xr1
 inc word ptr yr1
 call Bar
 jmp _Ex
_R:
 mov c, 0
 call Bar
 mov c, 32
 call Rect
_Ex:
 call Mini
 mov ax, 1
 int 33h
 jmp _kbd
_Exit:
 mov ax, 3
 int 10h
 mov ah, 3ch
 mov dx, offset fname
 mov cx, 20h
 int 21h
 mov ax, 3d02h
 mov dx, offset fname
 int 21h
 xchg bx, ax
 mov ah, 40h
 mov cx, 27*15
 mov dx, offset _pic
 int 21h
 mov ah, 3eh
 int 21h
ret

Mini          proc
 xor bp, bp
 mov dx, 44
_MY:
 inc dx
 mov cx, 230
_MX:
 inc cx
 mov xp, cx
 mov yp, dx
 mov al, byte ptr [_pic+bp]
 mov c, al
 push cx
 push dx
 push bp
 call PutPix
 pop bp
 pop dx
 pop cx
 inc bp
 cmp cx, 253
 jne _MX
 cmp dx, 59
 jne _MY
 ret
Mini          endp

GetColor      proc
 sub dx, 150
 mov ax, dx
 xor dx, dx
 mov bx, 6
 div bx
 push ax
 xor dx, dx
 mov ax, cx
 mov bx, 12
 div bx
 pop bx
 push ax
 mov ax, 50
 mul bx
 pop bx
 add bx, ax
 mov byte ptr gc, bl

 ; Показ текущего цвета
 call WaitRetrace
 mov ax, 02h
 int 33h
 mov xr1, 1
 mov yr1, 185
 mov xr2, 300
 mov yr2, 195
 mov c, bl
 call Bar
 mov ax, 01h
 int 33h
 ; --------------------

 ret
GetColor      endp

include interf.inc

_prs       dw        0
xpic       dw        0
ypic       dw        0
gc         db        30
fname      db        'test.spr', 0

_pic:
end main