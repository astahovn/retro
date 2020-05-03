.model tiny
.code
org 100h
main:
 mov ax, 3d02h
 mov dx, offset fname
 int 21h
 xchg ax, bx
 mov ah, 3fh
 mov cx, 27*15
 mov dx, offset _pic
 int 21h
 mov ah, 3eh
 int 21h
 mov ax, 13h
 int 10h
 xor bp, bp
 mov dx, 80
_SY:
 mov cx, 135
_SX:
 mov ax, 0A000h
 mov es, ax
 mov di, dx
 shl di, 6
 mov bx, di
 shl di, 2
 add di, bx
 add di, cx
 mov al, byte ptr [_pic+bp]
 mov es:[di], al
 inc cx
 inc bp
 cmp cx, 158
 jne _SX
 inc dx
 xor cx, cx
 cmp dx, 96
 jne _SY
 xor ah, ah
 int 16h
 mov ax, 3h
 int 10h
ret
fname   db      'asm.spr', 0
_pic:
end main