.model tiny
.code
org 100h
Main:
      xor ah, ah
      int 1ah
      mov [Seed], dx
      mov ax, 13h
      int 10h
      mov ax, 0A000h
      mov es, ax
      call InitPal
      call InitPix
      call ShowText
M:
      call ShowPix
      call WaitRt
      call MovePix
      in al, 60h
      cmp al, 1
      jne M
      mov ax, 3h
      int 10h
ret

InitPal Proc
      mov bl, 101
      mov bh, 1
_IPal:
      mov dx, 3c8h
      mov al, bl
      out dx, al
      mov dx, 3c9h
      mov al, bh
      out dx, al
      mov al, bh
      out dx, al
      mov al, 60
      sub al, bh
      out dx, al
      inc bl
      inc bh
      cmp bl, 160
      jne _IPal
      ret
InitPal EndP

WaitRt  Proc
      mov dx, 3dah
Rt:
      in al, dx
      test al, 8
      jz Rt
Rt2:
      in al, dx
      test al, 8
      jnz Rt2
      ret
WaitRt  EndP

InitPix Proc
      xor bp, bp
_IP:
      mov cx, 320
      call Random
      mov word ptr [Pix+bp], dx
      mov cx, 200
      call Random
      mov word ptr [Pix+2+bp], dx
      add bp, 4
      cmp bp, N
      jne _IP
      ret
InitPix EndP

ShowPix Proc
      xor bp, bp
_SP:
      mov dx, 0
      push word ptr [Pix+bp]
      push word ptr [Pix+2+bp]
      call PutPix
      add sp, 4
      add bp, 4
      cmp bp, N
      jne _SP
      ret
ShowPix EndP

MovePix Proc
      xor bp, bp
_MP:
      cmp word ptr [Pix+2+bp], 199
      je _C8
      inc word ptr [Pix+2+bp]
      push word ptr [Pix+bp]
      push word ptr [Pix+2+bp]
      call GetPix
      add sp, 4
      dec word ptr [Pix+2+bp]
      cmp al, 0
      jne _C2
      mov dx, 1
      push word ptr [Pix+bp]
      push word ptr [Pix+2+bp]
      call PutPix
      add sp, 4
      inc word ptr [Pix+2+bp]
      jmp _CC
_C2:
      inc word ptr [Pix+2+bp]
      inc word ptr [Pix+bp]
      push word ptr [Pix+bp]
      push word ptr [Pix+2+bp]
      call GetPix
      add sp, 4
      dec word ptr [Pix+bp]
      dec word ptr [Pix+2+bp]
      cmp al, 0
      jne _C3
      mov dx, 1
      push word ptr [Pix+bp]
      push word ptr [Pix+2+bp]
      call PutPix
      add sp, 4
      inc word ptr [Pix+2+bp]
      inc word ptr [Pix+bp]
      jmp _CC
_MP2:
      jmp _MP
_C8:
      jmp _C
_C3:
      inc word ptr [Pix+2+bp]
      dec word ptr [Pix+bp]
      push word ptr [Pix+bp]
      push word ptr [Pix+2+bp]
      call GetPix
      add sp, 4
      inc word ptr [Pix+bp]
      dec word ptr [Pix+2+bp]
      cmp al, 0
      jne _C
      mov dx, 1
      push word ptr [Pix+bp]
      push word ptr [Pix+2+bp]
      call PutPix
      add sp, 4
      inc word ptr [Pix+2+bp]
      dec word ptr [Pix+bp]
      jmp _CC
_C:
      mov cx, 320
      call Random
      mov word ptr [Pix+bp], dx
      mov word ptr [Pix+2+bp], 0
_CC:
      add bp, 4
      cmp bp, N
      jne _MP2
      ret
MovePix EndP

PutPix  Proc
      push bp
      mov bp, sp
      mov di, [bp+4]
      shl di, 6
      mov bx, di
      shl di, 2
      add di, bx
      add di, [bp+6]
      cmp dx, 0
      jne _PC
      mov al, 100
      jmp _PP
_PC:
      mov al, 0
_PP:
      mov es:[di], al
      pop bp
      ret
PutPix  EndP

GetPix  Proc
      push bp
      mov bp, sp
      mov di, [bp+4]
      shl di, 6
      mov bx, di
      shl di, 2
      add di, bx
      add di, [bp+6]
      mov al, es:[di]
      pop bp
      ret
GetPix  EndP

Random PROC NEAR                   ; Reasonably random (can be improved)
      mov     ax,Seed
      add     ax,1234                ; Add a random number
      xor     al,ah                  ; Shuffle around
      rol     ah,1
      add     ax,4321
      ror     al,1
      xor     ah,al
      mov     Seed,ax
      xor     dx,dx
      div     cx
      ret
Random ENDP

ShowSprite      Proc
      pop ax
      pop bp
      pop bx
      pop cx
      push ax
      ; Save Registers
      push cx
      push bx
      ; ..............
      mov ax, 320
      mul bx
      add ax, cx
      mov di, ax
      xor cl, cl
      xor bl, bl
      mov bh, byte ptr [bp+1]
      mov ch, byte ptr [bp]
      xor dx, dx
      mov dl, ch
SSP:
      mov al, byte ptr [bp+2]
      cmp al, 0
      je SSPC
      mov es:[di], al
SSPC:
      inc di
      inc bp
      inc cl
      cmp cl, ch
      jne SSP
      inc bl
      add di, 320
      sub di, dx
      xor cl, cl
      cmp bl, bh
      jne SSP
      pop bx
      pop cx
      ret
ShowSprite      EndP

ShowText        Proc
      push 115
      push 80
      push offset S
      call ShowSprite
      push 135
      push 80
      push offset _N
      call ShowSprite
      push 155
      push 80
      push offset O
      call ShowSprite
      push 175
      push 80
      push offset W
      call ShowSprite
      ret
ShowText        EndP

Seed    dw      ?
N       equ     800

S       db      07, 12
        db      000, 000, 159, 159, 159, 159, 000
        db      000, 155, 155, 155, 155, 155, 155
        db      150, 150, 000, 000, 000, 000, 150
        db      150, 150, 000, 000, 000, 000, 000
        db      145, 145, 000, 000, 000, 000, 000
        db      000, 140, 140, 140, 140, 000, 000
        db      000, 000, 140, 140, 140, 140, 000
        db      000, 000, 000, 000, 000, 135, 135
        db      000, 000, 000, 000, 000, 130, 130
        db      130, 000, 000, 000, 000, 130, 130
        db      125, 125, 125, 125, 125, 125, 000
        db      000, 120, 120, 120, 120, 000, 000

_N      db      07, 12
        db      159, 159, 000, 000, 000, 159, 159
        db      155, 155, 000, 000, 000, 155, 155
        db      150, 150, 150, 000, 000, 150, 150
        db      150, 150, 150, 000, 000, 150, 150
        db      145, 145, 145, 000, 000, 145, 145
        db      140, 140, 140, 140, 000, 140, 140
        db      140, 140, 000, 140, 000, 140, 140
        db      135, 135, 000, 135, 000, 135, 135
        db      130, 130, 000, 130, 130, 130, 130
        db      130, 130, 000, 000, 130, 130, 130
        db      125, 125, 000, 000, 125, 125, 125
        db      120, 120, 000, 000, 120, 120, 120

O       db      07, 12
        db      000, 000, 159, 159, 159, 000, 000
        db      000, 155, 155, 155, 155, 155, 000
        db      150, 150, 150, 150, 150, 150, 150
        db      150, 150, 000, 000, 000, 150, 150
        db      145, 145, 000, 000, 000, 145, 145
        db      140, 140, 000, 000, 000, 140, 140
        db      140, 140, 000, 000, 000, 140, 140
        db      135, 135, 000, 000, 000, 135, 135
        db      130, 130, 000, 000, 000, 130, 130
        db      130, 130, 130, 130, 130, 130, 130
        db      000, 125, 125, 125, 125, 125, 000
        db      000, 000, 120, 120, 120, 000, 000

W       db      07, 12
        db      159, 159, 000, 000, 000, 159, 159
        db      155, 155, 000, 000, 000, 155, 155
        db      150, 150, 000, 000, 000, 150, 150
        db      150, 150, 000, 000, 000, 150, 150
        db      145, 145, 000, 000, 000, 145, 145
        db      140, 140, 000, 140, 000, 140, 140
        db      140, 140, 000, 140, 000, 140, 140
        db      135, 135, 000, 135, 000, 135, 135
        db      130, 130, 000, 130, 000, 130, 130
        db      000, 130, 130, 130, 130, 130, 000
        db      000, 125, 125, 125, 125, 125, 000
        db      000, 000, 120, 120, 120, 000, 000

Pix:
End Main