; ModeX library

InitGr          proc
 ; Set 320/200/256
 mov ax, 13h
 int 10h
 ; Put the CHAIN4-mode of Sequencer off
 mov dx, 3c4h
 mov ax, 0604h
 out dx, ax
 ; Turn on the CRTC's BYTE-mode
 mov dx, 3d4h
 mov al, 17h
 out dx, al
 inc dx
 mov al, 0E3h
 out dx, al
 ; Turn off the CRTC's LONG-mode
 dec dx
 mov ax, 0014h
 out dx, ax
 ; Clear all planes
 mov dx, 3c4h
 mov ax, 0F02h
 out dx, ax
 mov ax, 0A000h
 mov es, ax
 xor di, di
 mov cx, 16384
 xor eax, eax
 rep stosd
 ret
InitGr          endp

PutPix          proc
 ; Set Active Current Bit Plane
 mov dx, 3c4h
 mov al, 2
 out dx, al
 inc dx
 mov ax, xp
 and ax, 3
 mov cl, al
 mov ch, 1
 shl ch, cl
 mov al, ch       ; al=1 shl (xp and 3)
 out dx, al
 ; Mem[PageBase:(y shl 6)+(y shl 4)+(x shr 2)]:=c;
 mov ax, PageBase
 mov es, ax
 mov di, yp
 mov dx, di
 shl di, 6
 shl dx, 4
 add di, dx
 mov cx, xp
 shr cx, 2
 add di, cx
 mov al, cp
 mov es:[di], al
 ret
PutPix          endp

GetPix          proc
 ; Set Active Current Bit Plane
 mov dx, 3c4h
 mov al, 2
 out dx, al
 inc dx
 mov ax, xp
 and ax, 3
 mov cl, al
 mov ch, 1
 shl ch, cl
 mov al, ch       ; al=1 shl (xp and 3)
 out dx, al
 ; Mem[PageBase:(y shl 6)+(y shl 4)+(x shr 2)]:=c;
 mov ax, PageBase
 mov es, ax
 mov di, yp
 mov dx, di
 shl di, 6
 shl dx, 4
 add di, dx
 mov cx, xp
 shr cx, 2
 add di, cx
 mov al, byte ptr es:[di]
 mov byte ptr cp, al
 ret
GetPix          endp

SetActPage      proc
 mov ax, _Page
 shl ax, 10
 add ax, 0A000h
 mov PageBase, ax
 ret
SetActPage      endp

SetVisPage      proc
  ; addr = page shl 14 ( page * 16k )
 mov ax, _Page
 shl ax, 14
 push ax        ; "addr"
  ; While (Port[$3da] and 8)=0 do
 mov dx, 3dah
WS:
 in al, dx
 and al, 8
 jz WS
 ; WriteReg($3d4, $0C, addr shr 8);
 mov dx, 3d4h
 mov al, 0Ch     ; Start address high
 out dx, al
 inc dx
 pop ax          ; ax = "addr"
 push ax
 shr ax, 8
 out dx, al
 ; WriteReg($3d4, $DC, addr and $0F);
 dec dx
 mov al, 0DCh    ; Start address low
 out dx, al
 inc dx
 pop ax          ; ax = "addr"
 and ax, 0Fh
 out dx, al
 ret
SetVisPage      endp

CLS             proc
 ; Set Active ALL Bit Planes
 mov dx, 3c4h
 mov ax, 0F02h
 out dx, ax
 mov ax, 0A000h
 mov es, ax
 mov di, _Page
 shl di, 14
 mov cx, 4096
 xor eax, eax
 rep stosd
 ret
CLS             endp

WaitRetrace     proc
 mov dx, 3dah
WR:
 in al, dx
 and al, 8
 jz WR
 ret
WaitRetrace     endp

PageBase        dw      0A000h
_Page           dw      0
xp              dw      ?
yp              dw      ?
cp              db      ?

