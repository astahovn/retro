; Effects&Demo library

FadeOut          proc
 xor ch, ch
FadeOutLoop:
 xor cl, cl
ColorsLoop:
 ; Считывание интенсивности составляющих цвета
 mov dx, 3c7h
 mov al, cl
 out dx, al
 mov dx, 3c9h
 in al, dx
 mov r, al
 in al, dx
 mov g, al
 in al, dx
 mov b, al
 ; Изменение интенсивности составляющих цвета
 cmp r, 63
 je _G
 inc r
_G:
 cmp g, 63
 je _B
 inc g
_B:
 cmp b, 63
 je _EndChange
 inc b
_EndChange:
 ; Запись интенсивности составляющих цвета
 mov dx, 3c8h
 mov al, cl
 out dx, al
 inc dx
 mov al, r
 out dx, al
 mov al, g
 out dx, al
 mov al, b
 out dx, al
 inc cl
 cmp cl, 255
 jne ColorsLoop
 inc ch
 call WaitRetrace
 cmp ch, 63
 jne FadeOutLoop
 ret
FadeOut          endp

FadeIn           proc
 xor ch, ch
FadeInLoop:
 xor cl, cl
ColorLoop:
 ; Считывание интенсивности составляющих цвета
 mov dx, 3c7h
 mov al, cl
 out dx, al
 mov dx, 3c9h
 in al, dx
 mov r, al
 in al, dx
 mov g, al
 in al, dx
 mov b, al
 ; Изменение интенсивности составляющих цвета
 cmp r, 0
 je _GG
 dec r
_GG:
 cmp g, 0
 je _BB
 dec g
_BB:
 cmp b, 0
 je _EndChanges
 dec b
_EndChanges:
 ; Запись интенсивности составляющих цвета
 mov dx, 3c8h
 mov al, cl
 out dx, al
 inc dx
 mov al, r
 out dx, al
 mov al, g
 out dx, al
 mov al, b
 out dx, al
 inc cl
 cmp cl, 255
 jne ColorLoop
 inc ch
 call WaitRetrace
 cmp ch, 63
 jne FadeInLoop
 ret
FadeIn           endp

ShowSpr                proc
 mov dh, byte ptr ds:[si]       ; xmax
 mov dl, byte ptr ds:[si+1]     ; ymax
 add si, 2
 mov ax, PageBase
 mov es, ax
 xor bx, bx
 mov bh, 00000001b
 push dx
 mov di, yspr
 mov dx, di
 shl di, 6
 shl dx, 4
 add di, dx
 mov cx, xspr
 shr cx, 2
 add di, cx
 pop dx
 push di
 xor cl, cl
_SHowSprX:
 xor ch, ch
 pop di
 push di
 push bx
 xor bh, bh
 add di, bx
 pop bx
 mov bp, si
 push dx
 mov dx, 3c4h
 mov al, 2
 mov ah, bh
 out dx, ax
 pop dx
_ShowSprY:
 mov al, byte ptr ds:[bp]
 mov byte ptr es:[di], al
 push bx
 xor bx, bx
 mov bl, dh
 add bp, bx
 pop bx
 add di, 80
 inc ch
 cmp ch, dl
 jne _ShowSprY
 shl bh, 1
 cmp bh, 16
 jne _ContShowSpr
 mov bh, 00000001b
 inc bl
_ContShowSpr:
 inc si
 inc cl
 cmp cl, dh
 jne _ShowSprX
 pop di
 ret
ShowSpr                endp

InitPal1               proc
 xor al, al
_Pal:
 mov dx, 3c8h
 out dx, al
 inc dx
 out dx, al
 out dx, al
 out dx, al
 inc al
 cmp al, 61
 jne _Pal
 ret
InitPal1               endp

Blur                   proc
 mov dx, 3c4h
 mov ax, 0F02h
 out dx, ax
 mov ax, 0A000h
 mov es, ax
 mov di, _Page
 shl di, 14
 xor dl, dl
_Blur:
 xor bx, bx
 xor cx, cx
 mov cl, byte ptr es:[di-1]
 add bx, cx
 xor cx, cx
 mov cl, byte ptr es:[di+1]
 add bx, cx
 xor cx, cx
 mov cl, byte ptr es:[di+320]
 add bx, cx
 xor cx, cx
 mov cl, byte ptr es:[di-320]
 add bx, cx
 shr bx, 2
 mov byte ptr es:[di], bl
 inc di
 cmp di, 16000
 jne _Blur
 push dx
 call WaitRetrace
 pop dx
 xor di, di
 inc dl
 cmp dl, 30
 jne _Blur
 ret
Blur                   endp

; Инициализация квадрата
InitObj1               proc
 xor bp, bp
 mov word ptr xp, 148
 mov word ptr yp, 88
_IO11:
 fild xp
 fstp qword ptr _Buf[bp]
 fild yp
 fstp qword ptr _Buf[bp+8]
 inc word ptr xp
 add bp, 16
 cmp bp, 400
 jne _IO11
_IO12:
 fild xp
 fstp qword ptr _Buf[bp]
 fild yp
 fstp qword ptr _Buf[bp+8]
 inc word ptr yp
 add bp, 16
 cmp bp, 800
 jne _IO12
_IO13:
 fild xp
 fstp qword ptr _Buf[bp]
 fild yp
 fstp qword ptr _Buf[bp+8]
 dec word ptr xp
 add bp, 16
 cmp bp, 1200
 jne _IO13
_IO14:
 fild xp
 fstp qword ptr _Buf[bp]
 fild yp
 fstp qword ptr _Buf[bp+8]
 dec word ptr yp
 add bp, 16
 cmp bp, 1600
 jne _IO14
 ret
InitObj1               endp

InitSteps              proc
 xor bp, bp
_ISteps:
 ; X - step
 fld qword ptr _Buf[bp]
 fld qword ptr _Buf[1600+bp]
 fsub
 fidiv iStep
 fstp qword ptr _Buf[3200+bp]
 ; Y - step
 fld qword ptr _Buf[bp+8]
 fld qword ptr _Buf[1600+bp+8]
 fsub
 fidiv iStep
 fstp qword ptr _Buf[3200+bp+8]
 add bp, 16
 cmp bp, 1600
 jne _ISteps
 ret
iStep       dw         30
InitSteps              endp

ShowObj          proc
 mov bp, 1600
_Show1:
 fld qword ptr _Buf[bp]
 fistp xp
 fld qword ptr _Buf[bp+8]
 fistp yp
 call PutPix
 add bp, 16
 cmp bp, 3200
 jne _Show1
 ret
ShowObj          endp

MoveObj          proc
 mov bp, 1600
_MoveObj:
 fld qword ptr _Buf[bp]
 fadd qword ptr _Buf[1600+bp]
 fstp qword ptr _Buf[bp]
 fld qword ptr _Buf[bp+8]
 fadd qword ptr _Buf[1600+bp+8]
 fstp qword ptr _Buf[bp+8]
 add bp, 16
 cmp bp, 3200
 jne _MoveObj
 ret
MoveObj          endp

Morph            proc
 xor bp, bp
 mov cp, 60
_Morph:

 call SetVisPage
 cmp _Page, 0
 je _P0
 mov _Page, 0
 jmp _ContMorph
_P0:
 mov _Page, 1
_ContMorph:
 call SetActPage

 push bp
 call ShowFon
 call ShowObj
 call MoveObj
 call WaitRetrace
 pop bp
 inc bp
 cmp bp, 32
 jne _Morph
 ret
Morph            endp

; Инициализация окружности
InitObj2         proc
 xor bp, bp
_IO2:

 fld Angle
 fcos
 fimul Radius
 fiadd i160
 fstp qword ptr _Buf[bp]

 fld Angle
 fsin
 fimul Radius
 fiadd i100
 fstp qword ptr _Buf[bp+8]

 fld Angle
 fadd AngleStep
 fstp Angle

 add bp, 16
 cmp bp, 1600
 jne _IO2
 ret
Angle       dq         0
AngleStep   dq         0.062831853071795865
Radius      dw         16
i160        dw         160
i100        dw         100
InitObj2         endp

InitCircle       proc
 xor bp, bp
_IC:

 fld Angl
 fcos
 fimul Radius
 fstp qword ptr _Buf[bp]

 fld Angl
 fsin
 fimul Radius
 fstp qword ptr _Buf[bp+8]

 fldz
 fstp qword ptr _Buf[bp+16]

 fld Angl
 fadd AngleStep
 fstp Angl

 add bp, 24
 cmp bp, 2400
 jne _IC
 ret
angl        dq         0
InitCircle       endp

InitObj3         proc
 mov bp, 1600
_IO3:

 fld Ang
 fcos
 fimul Radius
 fiadd i160
 fstp qword ptr _Buf[bp]

 fld Ang
 fsin
 fimul Radius
 fiadd i100
 fstp qword ptr _Buf[bp+8]

 fld Ang
 fadd AngleStep
 fstp Ang

 add bp, 16
 cmp bp, 3200
 jne _IO3
 ret
Ang         dq         0
InitObj3         endp

InitObj4         proc
 xor bp, bp
_IO4:
 fild i160
 fstp qword ptr _Buf[bp]
 fild i100
 fstp qword ptr _Buf[bp+8]
 add bp, 16
 cmp bp, 1600
 jne _IO4
 ret
InitObj4         endp

InitPal2         proc
 mov rr, 60
 mov gg, 60
 mov bb, 60
 mov cl, 90
_IPLoop1:
 mov dx, 3c8h
 mov al, cl
 out dx, al
 inc dx
 mov al, rr
 out dx, al
 mov al, gg
 out dx, al
 mov al, bb
 out dx, al
 sub bb, 2
 dec cl
 cmp cl, 60
 jne _IPLoop1
_IPLoop2:
 mov dx, 3c8h
 mov al, cl
 out dx, al
 inc dx
 mov al, rr
 out dx, al
 mov al, gg
 out dx, al
 xor al, al
 out dx, al
 sub gg, 2
 dec cl
 cmp cl, 30
 jne _IPLoop2
_IPLoop3:
 mov dx, 3c8h
 mov al, cl
 out dx, al
 inc dx
 mov al, rr
 out dx, al
 mov al, gg
 out dx, al
 xor al, al
 out dx, al
 cmp byte ptr rr, 1
 jb _ContIP
 sub rr, 2
_ContIP:
 dec cl
 cmp cl, 0
 jne _IPLoop3
 ret
rr          db         60
gg          db         60
bb          db         60
InitPal2         endp

MakeFlame        proc
 call InitFrstLine
 mov di, 63680
_MF:

 xor ax, ax
 xor bx, bx
 mov al, byte ptr es:[di+1]
 add bx, ax

 xor ax, ax
 mov al, byte ptr es:[di-1]
 add bx, ax

 xor ax, ax
 mov al, byte ptr es:[di+320]
 add bx, ax

 xor ax, ax
 mov al, byte ptr es:[di+320]
 add bx, ax

 shr bx, 2
 mov byte ptr es:[di], bl
 dec di
 cmp di, 44800
 jne _MF
 ret
MakeFlame        endp

InitFrstLine     proc
 mov di, 63680
IFL:
 mov cx, 90
 call Random
 xchg al, dl
 mov byte ptr es:[di], al
 inc di
 cmp di, 64000
 jne IFL
 ret
InitFrstLine     endp

Random           proc
 mov     ax, Seed
 add     ax, 1234
 xor     al, ah
 rol     ah, 1
 add     ax, 4321
 ror     al, 1
 xor     ah, al
 mov     Seed, ax
 xor     dx, dx
 div     cx
 ret
Random           endp

Flame            proc
_Flame:
 push cx
 call MakeFlame
 pop cx
 loop _Flame
 ret
Flame            endp

ShowText         proc
 mov dh, byte ptr ds:[si+1]
 mov dl, byte ptr ds:[si]
 add si, 2
 push dx
_STLoop:
 pop dx
 inc dl
 push dx
 mov ah, 02h
 xor bx, bx
 int 10h
 mov cx, 30
_STLoop2:
 mov ah, 09h
 mov al, byte ptr ds:[si]
 mov bx, 30
 sub bx, cx
 push cx
 mov cx, 1
 int 10h
 pop cx
 loop _STLoop2
 push dx
 cmp byte ptr FlameB, 0
 jne _PauseSTLoop
 call MakeFlame
 jmp _ContinueSTLoop
_PauseSTLoop:
 mov cx, 20
 call Delay
_ContinueSTLoop:
 pop dx
 inc si
 cmp byte ptr ds:[si], 0
 jne _STLoop
 pop dx
 ret
ShowText         endp

Blur2            proc
_MainBlur2:
 push cx
 mov di, 25600
_1Blur2:

 xor ax, ax
 xor bx, bx
 mov al, byte ptr es:[di-1]
 add bx, ax

 xor ax, ax
 mov al, byte ptr es:[di+1]
 add bx, ax

 shr bx, 1
 mov byte ptr es:[di], bl
 inc di
 cmp di, 28800
 jne _1Blur2
 cmp byte ptr FlameB, 0
 jne _MakePause
 call MakeFlame
 jmp _ContinueMainBlur2
_MakePause:
 mov cx, 20
 call Delay
_ContinueMainBlur2:
 pop cx
 loop _MainBlur2
 ret
Blur2            endp

Text        db         17, 10, 'BIT', 0
            db         16, 10, 'BYTE', 0
            db         16, 10, 'WORD', 0
            db         13, 10, 'DOUBLE WORD', 0
            db         16, 10, 'CODER', 0
            db         10, 10, 'Intro by EVOLVER', 0
FlameB      db         0

InitPal3         proc
 xor cx, cx
 mov cl, 100
_IP3L:
 mov dx, 3c8h
 mov al, cl
 out dx, al
 inc dx
 mov al, ch
 out dx, al
 mov al, 60
 sub al, ch
 out dx, al
 mov al, 60
 out dx, al
 inc cl
 inc ch
 cmp cl, 160
 jne _IP3L
 ret
InitPal3         endp

ShowFon          proc
 mov dx, 3c4h
 mov ax, 0F02h
 out dx, ax
 push di
 push ax
 push cx
 push es
 mov ax, 0A000h
 mov es, ax
 mov di, _Page
 shl di, 14
 add di, 800
 mov al, 100
_SFL:
 mov ah, al
 mov cx, 120
 rep stosw
 inc al
 cmp al, 160
 jne _SFL
 pop es
 pop cx
 pop ax
 pop di
 ret
ShowFon          endp

Lazer            proc
 cli
_LazerLoop:
 mov dx, 3dah
W11:
 in al, dx
 and al, 8
 jz W11
W22:
 in al, dx
 and al, 8
 jnz W22
 mov cx, 135
_SetLazer:
 mov dx, 3dah
_PW1:
 in al, dx
 and al, 1
 jz _PW1
_PW2:
 in al, dx
 and al, 1
 jnz _PW2
 loop _SetLazer
 xor cx, cx
_SP1:
 mov dx, 3dah
_W11:
 in al, dx
 and al, 1
 jz _W11
 inc cl
 mov dx, 3c8h
 xor al, al
 out dx, al
 inc dx
 xor al, al
 out dx, al
 mov al, cl
 out dx, al
 xor al, al
 out dx, al
 mov dx, 3dah
_W22:
 in al, dx
 and al, 1
 jnz _W22
 cmp cl, 63
 jne _SP1
_SP2:
 mov dx, 3dah
_W1:
 in al, dx
 and al, 1
 jz _W1
 dec cl
 mov dx, 3c8h
 xor al, al
 out dx, al
 inc dx
 xor al, al
 out dx, al
 mov al, cl
 out dx, al
 xor al, al
 out dx, al
 mov dx, 3dah
_W2:
 in al, dx
 and al, 1
 jnz _W2
 cmp cl, 0
 jne _SP2
 in al, 60h
 cmp al, 1
 je _EndLazer
 jmp _LazerLoop
_EndLazer:
 sti
 ret
Lazer            endp
