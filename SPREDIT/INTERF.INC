c       db        0

PutPix         proc
 mov ax, 0A000h
 mov es, ax
 mov di, word ptr yp
 shl di, 6
 mov bx, di
 shl di, 2
 add di, bx
 add di, word ptr xp
 mov al, byte ptr c
 mov es:[di], al
 ret
PutPix         endp

GetPix         proc
 mov ax, 0A000h
 mov es, ax
 mov di, word ptr yp
 shl di, 6
 mov bx, di
 shl di, 2
 add di, bx
 add di, word ptr xp
 mov al, byte ptr es:[di]
 ret
GetPix         endp

xp      dw        0
yp      dw        0

Bar            proc
 mov dx, word ptr yr1
_RY:
 mov cx, word ptr xr1
_RX:
 mov xp, cx
 mov yp, dx
 call PutPix
 inc cx
 cmp cx, word ptr xr2
 jne _RX
 inc dx
 cmp dx, word ptr yr2
 jne _RY
 ret
Bar            endp

Rect           proc
 mov cx, word ptr xr1
 mov xl, cx
 mov cx, word ptr yr1
 mov yl, cx
 mov cx, word ptr xr2
 mov xy, cx
 call HLine
 mov cx, word ptr xr1
 mov xl, cx
 mov cx, word ptr yr2
 mov yl, cx
 mov cx, word ptr xr2
 mov xy, cx
 call HLine
 mov cx, word ptr xr1
 mov xl, cx
 mov cx, word ptr yr1
 mov yl, cx
 mov cx, word ptr yr2
 mov xy, cx
 call VLine
 mov cx, word ptr xr2
 mov xl, cx
 mov cx, word ptr yr1
 mov yl, cx
 mov cx, word ptr yr2
 mov xy, cx
 call VLine
 mov cx, word ptr xr2
 mov xp, cx
 mov cx, word ptr yr2
 mov yp, cx
 call PutPix
 ret
Rect           endp

xr1     dw        0
yr1     dw        0
xr2     dw        0
yr2     dw        0

HLine          proc
 mov cx, word ptr xl
 mov dx, word ptr yl
 mov yp, dx
_HL:
 mov xp, cx
 call PutPix
 inc cx
 cmp cx, word ptr xy
 jne _HL
 ret
HLine          endp

VLine          proc
 mov cx, word ptr xl
 mov xp, cx
 mov dx, word ptr yl
_VL:
 mov yp, dx
 call PutPix
 inc dx
 cmp dx, word ptr xy
 jne _VL
 ret
VLine          endp

xl      dw        0
yl      dw        0
xy      dw        0

WaitRetrace    proc
 mov dx, 3dah
_Rt:
 in al, dx
 test al, 8
 je _Rt
 ret
WaitRetrace    endp

