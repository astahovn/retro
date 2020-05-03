; Demo "First"

.586
.model use16 tiny
.code
org 100h
main:
 xor ah,ah
 int 1ah
 mov [Seed], dx
 call ReadSpr    ; Чтение картинки с диска
 ; ...
 call Intro
 ; Название демки
 call InitGr     ; 320/200/256/4
 call InitPal1   ; Установка палитры для Blur'а
 mov xspr, 50
 mov yspr, 20
 mov si, offset _Buf
 call ShowSpr    ; Отображение картинки
 mov cx, 700h    ; 700h
 call Delay      ; Пауза
 call Blur       ; Blur
 ; Графические примитивы
 finit
 call InitPal3
 call Morphings
 ; Вращение окружности
 call MoveCircle
 ; Пламя
 mov ax, 13h
 int 10h
 mov ax, 0A000h
 mov es, ax
 call InitPal2

 xor bx, bx
 mov si, offset Text
_MainFlameLoop:
 push bx
 mov cx, 100
 call Flame
 mov cx, 30
 call Blur2
 call ShowText
 inc si
 pop bx
 inc bx
 cmp bx, 5
 jne _MainFlameLoop

 mov cx, 100
 call Flame
 mov cx, 30
 call Blur2
 call FadeOut
 call FadeIn
 ; The End.
 xor di, di
 xor ax, ax
 mov cx, 32000
 rep stosw
 call InitPal2
 mov byte ptr FlameB, 1
 call ShowText
 mov cx, 900h
 call Delay
 mov cx, 60
 call Blur2
 mov ax, 3
 int 10h
ret

CLSTXT           proc
 mov ax, 0B800h
 mov es, ax
 xor di, di
 mov ax, 0700h
 mov cx, 2000
 rep stosw
 ret
CLSTXT           endp

Delay            proc
_DDelay:
 push cx
 mov cx, 0ffffh
_DD:
 loop _DD
 pop cx
 loop _DDelay
 ret
Delay            endp

Intro            proc
 call CLSTXT
 mov ah, 02h
 mov dx, 0C20h
 xor bx, bx
 int 10h
 mov ah, 1
 mov cx, 2000h
 int 10h
 mov ah, 09h
 mov dx, offset _Message1
 int 21h
 call Lazer
 call CLSTXT
 mov ah, 1
 mov cx, 001fh
 int 10h

 mov si, offset _Proga
 mov bp, offset _Delay
 xor dx, dx
_Loop:

 mov cl, byte ptr ds:[bp]
_DelayLoop:
 mov ah, 02h
 xor bx, bx
 int 10h
 push cx
 mov ah, 09h
 mov al, byte ptr ds:[si]
 mov bx, 0007h
 mov cx, 1
 int 10h
 pop cx
 push dx
 call WaitRetrace
 pop dx
 dec cl
 cmp cl, 0
 jne _DelayLoop

 inc bp
 mov ax, offset _Delay
 add ax, 7
 cmp bp, ax
 jne _Nxt
 mov bp, offset _Delay
_Nxt:
 inc si
 inc dl
 cmp byte ptr ds:[si], 1
 je _EndLoop
 cmp byte ptr ds:[si], 0
 jne _Loop
 xor dl, dl
 inc dh
 inc si
 jmp _Loop
_EndLoop:
 mov ah, 02h
 xor bx, bx
 int 10h
 mov cx, 700h
 call Delay
 call FadeOut
 call FadeIn
 ret
_Message1         db       'press "Esc" key...', '$'
_Delay            db       15, 100, 40, 50, 100, 20, 50
_Proga            db       '.model tiny', 0
                  db       '.code', 0
                  db       'org 100h', 0
                  db       'main:', 0
                  db       ' mov ah, 09h', 0
                  db       ' mov dx, offset _Message', 0
                  db       ' int 21h', 0
                  db       ' mov ah, 0', 0
                  db       ' int 16h', 0
                  db       'ret', 0
                  db       '_Message  db  "Hello World!!!", "$"', 0
                  db       'end main', 1
Intro            endp

ReadSpr          proc
 mov ax, 3d00h
 mov dx, offset _FirstSpr
 int 21h
 mov bx, ax
 mov ah, 3fh
 mov cx, 2
 mov dx, offset _Buf
 int 21h
 mov ax, ds
 mov es, ax
 mov di, offset _Buf
 add di, 2
 xor dx, dx
_MainLoop:
 push dx
 mov ah, 3fh
 mov cx, 3
 mov dx, offset _W
 int 21h
 mov cx, word ptr _W
 mov al, byte ptr _By
 rep stosb
 pop dx
 inc dx
 cmp dx, 1639
 jne _MainLoop
 mov ah, 3eh
 int 21h
 ret
_FirstSpr         db       'first.dat', 0
ReadSpr          endp

Morphings        proc
 call ShowFon
 mov word ptr xp, 110
 mov word ptr yp, 100
 mov byte ptr cp, 60
 call PutPix
 mov cx, 500h
 call Delay
 mov cx, 110
 mov bp, 1600
_ShowLine:
 mov word ptr xp, cx
 push cx
 call PutPix
 mov cx, 10h
 fild xp
 fstp qword ptr _Buf[bp]
 fild yp
 fstp qword ptr _Buf[bp+8]
 add bp, 16
 call Delay
 pop cx
 inc cx
 cmp cx, 210
 jne _ShowLine
 call InitObj1
 call InitSteps
 mov cx, 500h
 call Delay
 call Morph
 mov cx, 500h
 call Delay
 call InitObj2
 call InitSteps
 call Morph
 mov cx, 500h
 call Delay
 ret
Morphings        endp

MoveCircle       proc
 ; Инициализация окружности
 call InitCircle
 ; Вращение окружности
 xor bp, bp
_MoveLoop:

 call SetVisPage
 cmp _Page, 0
 je _Page0
 mov _Page, 0
 jmp _ContMoveCircle
_Page0:
 mov _Page, 1
_ContMoveCircle:
 call SetActPage

 push bp
 call ShowFon
 call ShowCircle
 call MoveCircl
 pop bp
 inc bp
 cmp bp, 630
 jne _MoveLoop
 mov cx, 100h
 call Delay
 call InitObj3
 call InitObj4
 call InitSteps
 call Morph
 mov cx, 300h
 call Delay
 call FadeOut
 call FadeIn
 ret
MoveCircle       endp

ShowCircle       proc
 xor bp, bp
_ShowCircl:
 fld qword ptr _Buf[bp]
 fiadd i160
 fistp xp
 fld qword ptr _Buf[bp+8]
 fiadd i100
 fistp yp
 call PutPix
 add bp, 24
 cmp bp, 2400
 jne _ShowCircl
 ret
ShowCircle       endp

MoveCircl        proc
 xor bp, bp
_MoveCircl:

 ; x=cos*x-sin*z
 ; st(1)=Cos(angle)*x
 fld anglcos
 fmul qword ptr _Buf[bp]
 ; st(0)=Sin(angle)*z
 fld anglsin
 fmul qword ptr _Buf[bp+16]
 ; st(0)=st(1)-st(0)
 fsub
 fstp x

 ; z=sin*x+cos*z
 ; st(1)=Cos(angle)*z
 fld anglcos
 fmul qword ptr _Buf[bp+16]
 ; st(0)=Sin(angle)*x
 fld anglsin
 fmul qword ptr _Buf[bp]
 ; st(0)=st(1)+st(0)
 fadd
 fstp z

 fld x
 fstp qword ptr _Buf[bp]
 fld z
 fstp qword ptr _Buf[bp+16]

 ; y=cos*y-sin*x
 ; st(1)=Cos(angle)*y
 fld anglcos
 fmul qword ptr _Buf[bp+8]
 ; st(0)=Sin(angle)*x
 fld anglsin
 fmul qword ptr _Buf[bp]
 ; st(0)=st(1)-st(0)
 fsub
 fstp y

 ; x=sin*y+cos*x
 ; st(1)=Cos(angle)*x
 fld anglcos
 fmul qword ptr _Buf[bp]
 ; st(0)=Sin(angle)*y
 fld anglsin
 fmul qword ptr _Buf[bp+8]
 ; st(0)=st(1)+st(0)
 fadd
 fstp x

 fld x
 fstp qword ptr _Buf[bp]
 fld y
 fstp qword ptr _Buf[bp+8]

 ; y=cos*y-sin*z
 ; st(1)=Cos(angle)*y
 fld anglcos
 fmul qword ptr _Buf[bp+8]
 ; st(0)=Sin(angle)*z
 fld anglsin
 fmul qword ptr _Buf[bp+16]
 ; st(0)=st(1)-st(0)
 fsub
 fstp y

 ; z=sin*y+cos*z
 ; st(1)=Cos(angle)*x
 fld anglcos
 fmul qword ptr _Buf[bp+16]
 ; st(0)=Sin(angle)*y
 fld anglsin
 fmul qword ptr _Buf[bp+8]
 ; st(0)=st(1)+st(0)
 fadd
 fstp z

 fld z
 fstp qword ptr _Buf[bp+16]
 fld y
 fstp qword ptr _Buf[bp+8]

 add bp, 24
 cmp bp, 2400
 jne _MoveCircl
 ret
anglsin           dq       0.017452406437283513  ; Sin(angl)
anglcos           dq       0.999847695156391239  ; Cos(angl)
x                 dq       0
y                 dq       0
z                 dq       0
MoveCircl        endp

include effects.inc
include modex.inc

xspr              dw       ?
yspr              dw       ?
r                 db       ?
g                 db       ?
b                 db       ?
_W                dw       ?
_By               db       ?
Seed              dw       ?
_Buf:
end main