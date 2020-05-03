Type
    _Sc = Array[1..64000] of Byte;
    _Sp = Array[1..5, 1..13] of Integer;
    vector = Array[1..3] of Real;
    projection = Array[1..2] of Vector;
    Point = Record
     x, y, z, c: Integer;
    End;
    Lin = Record
     x1, y1, z1, x2, y2, z2, c: Integer;
    End;
Const
    _GC=255;
    _Exit: _Sp=
    ((030, 030, 030, 000, 030, 000, 030, 000, 030, 000, 030, 030, 030),
     (030, 000, 000, 000, 030, 000, 030, 000, 030, 000, 000, 030, 000),
     (030, 030, 000, 000, 000, 030, 000, 000, 030, 000, 000, 030, 000),
     (030, 000, 000, 000, 030, 000, 030, 000, 030, 000, 000, 030, 000),
     (030, 030, 030, 000, 030, 000, 030, 000, 030, 000, 000, 030, 000));
    _Izom: _Sp=
    ((030, 000, 030, 030, 030, 000, 000, 030, 000, 000, 030, 000, 030),
     (030, 000, 000, 000, 030, 000, 030, 000, 030, 000, 030, 030, 030),
     (030, 000, 000, 030, 000, 000, 030, 000, 030, 000, 030, 000, 030),
     (030, 000, 030, 000, 000, 000, 030, 000, 030, 000, 030, 000, 030),
     (030, 000, 030, 030, 030, 000, 000, 030, 000, 000, 030, 000, 030));
    _Dim: _Sp=
    ((030, 030, 000, 000, 030, 000, 030, 000, 030, 000, 000, 000, 000),
     (030, 000, 030, 000, 030, 000, 030, 030, 030, 000, 000, 000, 000),
     (030, 000, 030, 000, 030, 000, 030, 000, 030, 000, 000, 000, 000),
     (030, 000, 030, 000, 030, 000, 030, 000, 030, 000, 000, 000, 000),
     (030, 030, 000, 000, 030, 000, 030, 000, 030, 000, 000, 000, 000));
    _Obl: _Sp=
    ((000, 030, 000, 000, 030, 030, 000, 000, 030, 000, 000, 000, 000),
     (030, 000, 030, 000, 030, 000, 030, 000, 030, 000, 000, 000, 000),
     (030, 000, 030, 000, 030, 030, 000, 000, 030, 000, 000, 000, 000),
     (030, 000, 030, 000, 030, 000, 030, 000, 030, 000, 000, 000, 000),
     (000, 030, 000, 000, 030, 030, 000, 000, 030, 030, 030, 000, 000));
    _S: _Sp=
    ((000, 030, 030, 000, 030, 030, 030, 000, 000, 030, 030, 000, 000),
     (030, 000, 000, 000, 030, 000, 030, 000, 000, 030, 000, 030, 000),
     (000, 030, 000, 000, 030, 030, 030, 000, 000, 030, 030, 000, 000),
     (000, 000, 030, 000, 000, 000, 030, 000, 000, 030, 000, 030, 000),
     (030, 030, 000, 000, 000, 000, 030, 030, 000, 030, 000, 030, 000));
    _V: _Sp=
    ((000, 030, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000),
     (030, 000, 030, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000),
     (000, 000, 030, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000),
     (000, 030, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000),
     (000, 030, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000));
    _Yes: _Sp=
    ((030, 000, 030, 000, 030, 030, 030, 000, 000, 030, 030, 000, 000),
     (030, 000, 030, 000, 030, 000, 000, 000, 030, 000, 000, 000, 000),
     (000, 030, 000, 000, 030, 030, 000, 000, 000, 030, 000, 000, 000),
     (000, 030, 000, 000, 030, 000, 000, 000, 000, 000, 030, 000, 000),
     (000, 030, 000, 000, 030, 030, 030, 000, 030, 030, 000, 000, 000));
    _No: _Sp=
    ((030, 000, 030, 000, 000, 030, 000, 000, 000, 000, 000, 000, 000),
     (030, 030, 030, 000, 030, 000, 030, 000, 000, 000, 000, 000, 000),
     (030, 030, 030, 000, 030, 000, 030, 000, 000, 000, 000, 000, 000),
     (030, 030, 030, 000, 030, 000, 030, 000, 000, 000, 000, 000, 000),
     (030, 000, 030, 000, 000, 030, 000, 000, 000, 000, 000, 000, 000));
    _Pix: _Sp=
    ((030, 030, 000, 000, 030, 000, 030, 000, 030, 000, 000, 000, 000),
     (030, 000, 030, 000, 030, 000, 030, 000, 030, 000, 000, 000, 000),
     (030, 030, 000, 000, 030, 000, 000, 030, 000, 000, 000, 000, 000),
     (030, 000, 000, 000, 030, 000, 030, 000, 030, 000, 000, 000, 000),
     (030, 000, 000, 000, 030, 000, 030, 000, 030, 000, 000, 000, 000));
    _Ok: _Sp=
    ((000, 030, 000, 000, 030, 000, 030, 000, 000, 000, 000, 000, 000),
     (030, 000, 030, 000, 030, 030, 000, 000, 000, 000, 000, 000, 000),
     (030, 000, 030, 000, 030, 030, 000, 000, 000, 000, 000, 000, 000),
     (030, 000, 030, 000, 030, 030, 000, 000, 000, 000, 000, 000, 000),
     (000, 030, 000, 000, 030, 000, 030, 000, 000, 000, 000, 000, 000));
    _Add: _Sp=
    ((000, 030, 000, 000, 030, 030, 000, 000, 030, 030, 000, 000, 000),
     (030, 000, 030, 000, 030, 000, 030, 000, 030, 000, 030, 000, 000),
     (030, 030, 030, 000, 030, 000, 030, 000, 030, 000, 030, 000, 000),
     (030, 000, 030, 000, 030, 000, 030, 000, 030, 000, 030, 000, 000),
     (030, 000, 030, 000, 030, 030, 000, 000, 030, 030, 000, 000, 000));
    _Del: _Sp=
    ((030, 030, 000, 000, 030, 030, 030, 000, 030, 000, 000, 000, 000),
     (030, 000, 030, 000, 030, 000, 000, 000, 030, 000, 000, 000, 000),
     (030, 000, 030, 000, 030, 030, 000, 000, 030, 000, 000, 000, 000),
     (030, 000, 030, 000, 030, 000, 000, 000, 030, 000, 000, 000, 000),
     (030, 030, 000, 000, 030, 030, 030, 000, 030, 030, 030, 000, 000));
    _Line: _Sp=
    ((030, 000, 000, 000, 030, 000, 030, 000, 030, 000, 030, 030, 030),
     (030, 000, 000, 000, 030, 000, 030, 030, 030, 000, 030, 000, 000),
     (030, 000, 000, 000, 030, 000, 030, 030, 030, 000, 030, 030, 000),
     (030, 000, 000, 000, 030, 000, 030, 030, 030, 000, 030, 000, 000),
     (030, 030, 030, 000, 030, 000, 030, 000, 030, 000, 030, 030, 030));
    _Persp: _Sp=
    ((030, 030, 000, 000, 030, 030, 030, 000, 030, 030, 000, 000, 000),
     (030, 000, 030, 000, 030, 000, 000, 000, 030, 000, 030, 000, 000),
     (030, 030, 000, 000, 030, 030, 000, 000, 030, 030, 000, 000, 000),
     (030, 000, 000, 000, 030, 000, 000, 000, 030, 000, 030, 000, 000),
     (030, 000, 000, 000, 030, 030, 030, 000, 030, 000, 030, 000, 000));
    _XY: _Sp=
    ((030, 000, 030, 000, 000, 000, 030, 000, 030, 000, 000, 000, 000),
     (030, 000, 030, 000, 000, 000, 030, 000, 030, 000, 000, 000, 000),
     (000, 030, 000, 000, 000, 000, 000, 030, 000, 000, 000, 000, 000),
     (030, 000, 030, 000, 000, 000, 000, 030, 000, 000, 000, 000, 000),
     (030, 000, 030, 000, 000, 000, 000, 030, 000, 000, 000, 000, 000));
    _XZ: _Sp=
    ((030, 000, 030, 000, 000, 000, 030, 030, 030, 000, 000, 000, 000),
     (030, 000, 030, 000, 000, 000, 000, 000, 030, 000, 000, 000, 000),
     (000, 030, 000, 000, 000, 000, 000, 030, 000, 000, 000, 000, 000),
     (030, 000, 030, 000, 000, 000, 030, 000, 000, 000, 000, 000, 000),
     (030, 000, 030, 000, 000, 000, 030, 030, 030, 000, 000, 000, 000));
    _YZ: _Sp=
    ((030, 000, 030, 000, 000, 000, 030, 030, 030, 000, 000, 000, 000),
     (030, 000, 030, 000, 000, 000, 000, 000, 030, 000, 000, 000, 000),
     (000, 030, 000, 000, 000, 000, 000, 030, 000, 000, 000, 000, 000),
     (000, 030, 000, 000, 000, 000, 030, 000, 000, 000, 000, 000, 000),
     (000, 030, 000, 000, 000, 000, 030, 030, 030, 000, 000, 000, 000));
    _X: _Sp=
    ((030, 000, 030, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000),
     (030, 000, 030, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000),
     (000, 030, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000),
     (030, 000, 030, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000),
     (030, 000, 030, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000));
    _Y: _Sp=
    ((030, 000, 030, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000),
     (030, 000, 030, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000),
     (000, 030, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000),
     (000, 030, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000),
     (000, 030, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000));
    _Z: _Sp=
    ((030, 030, 030, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000),
     (000, 000, 030, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000),
     (000, 030, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000),
     (030, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000),
     (030, 030, 030, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000));
Var
    P: Projection;
    xm, ym, bm: Word;
    i: Integer;
    pcos, psin: Real;
    x, y, z: Real;
    MP: Array[1..50] of Point;
    ML: Array[1..50] of Lin;
    mpi, mli: Integer;
    Scr: ^_Sc;
    _sqr, _hlt: Boolean;
    _vid: Integer;

Procedure Bar(x1, y1, x2, y2, c: Integer); Forward;
Procedure HideMouse; Forward;
Procedure ShowMouse; Forward;

Procedure GotoXY(x, y: Byte); Assembler;
Asm
 mov ah, 2
 xor bx, bx
 mov dh, y
 mov dl, x
 int 10h
End;

Procedure SetPal(x, r, g, b: Integer);
Begin
 Port[$3c8]:=x;
 Port[$3c9]:=r; Port[$3c9]:=g; Port[$3c9]:=b;
End;

Procedure GetPal(x: Integer; Var r, g, b: Integer);
Begin
 Port[$3c7]:=x;
 r:=Port[$3c9]; g:=Port[$3c9]; b:=Port[$3c9];
End;

Procedure EffectGash;
Var
   r, g, b: Integer;
Begin
 For i:=200 to _GC do
 Begin
  GetPal(i, r, g, b);
  If r>20 Then Dec(r);
  If g>20 Then Dec(g);
  SetPal(i, r, g, b);
 End;
 If _hlt=false Then
 Begin
  If (xm>280) and (xm<319) and (ym>0) and (ym<199) Then SetPal(200, 60, 60, 60);
  If (xm>1) and (xm<278) and (ym>0) and (ym<199) Then SetPal(206, 60, 60, 60);

  If (xm>280) and (xm<319) and (ym>12) and (ym<44) Then SetPal(205, 20, 60, 60);
  If (xm>282) and (xm<317) and (ym>2) and (ym<10) Then SetPal(201, 60, 20, 60);
  If (xm>282) and (xm<317) and (ym>46) and (ym<54) Then SetPal(207, 60, 20, 60);
  If (xm>282) and (xm<317) and (ym>56) and (ym<78) Then SetPal(211, 20, 60, 60);
  If (xm>283) and (xm<316) and (ym>14) and (ym<22) Then SetPal(202, 60, 20, 60);
  If (xm>283) and (xm<316) and (ym>24) and (ym<32) Then SetPal(203, 60, 20, 60);
  If (xm>283) and (xm<316) and (ym>34) and (ym<42) Then SetPal(204, 60, 20, 60);
  If (xm>283) and (xm<316) and (ym>58) and (ym<66) Then SetPal(212, 60, 20, 60);
  If (xm>283) and (xm<316) and (ym>68) and (ym<76) Then SetPal(213, 60, 20, 60);

  If (xm>281) and (xm<318) and (ym>156) and (ym<198) Then SetPal(230, 20, 60, 60);
  If (xm>283) and (xm<316) and (ym>188) and (ym<196) Then SetPal(231, 60, 20, 60);
  If (xm>283) and (xm<316) and (ym>178) and (ym<186) Then SetPal(232, 60, 20, 60);
  If (xm>283) and (xm<316) and (ym>168) and (ym<176) Then SetPal(233, 60, 20, 60);
  If (xm>283) and (xm<316) and (ym>158) and (ym<166) Then SetPal(234, 60, 20, 60);
 End
 Else
 Begin
  If (xm>90) and (xm<190) and (ym>50) and (ym<85) Then SetPal(208, 60, 60, 60);
  If (xm>98) and (xm<133) and (ym>83) and (ym<91) Then SetPal(209, 60, 20, 60);
  If (xm>145) and (xm<180) and (ym>83) and (ym<91) Then SetPal(210, 60, 20, 60);
  If (xm>100) and (xm<180) and (ym>55) and (ym<65) Then SetPal(220, 60, 20, 60);
  If (xm>100) and (xm<180) and (ym>69) and (ym<79) Then SetPal(221, 60, 20, 60);
  If (xm>100) and (xm<180) and (ym>84) and (ym<94) Then SetPal(222, 60, 20, 60);
 End;
End;

Procedure ShowScr;
Begin
 HideMouse;
 Move(Scr^, Mem[$A000:0], 64000);
 ShowMouse;
End;

Function WaitKey: Char; Assembler;
Asm
 xor ah, ah
 int 16h
End;

Procedure PutP(x, y, c: Integer);
Begin
 Scr^[(y shl 8)+(y shl 6)+x]:=c;
End;

Procedure Line(x1, y1, x2, y2, c: Integer);
Var
   dx, dy, i, x, y, d, d1, d2, sx, sy: Integer;
Begin
 dx:=Abs(x2-x1);
 dy:=Abs(y2-y1);
 If x2>=x1 Then sx:=1
 Else sx:=-1;
 If y2>=y1 Then sy:=1
 Else sy:=-1;
 If dy<=dx Then
 Begin
  d:=(dy shl 1)-dx;
  d1:=dy shl 1;
  d2:=(dy-dx) shl 1;
  PutP(x1, y1, c);
  x:=x1+sx;
  y:=y1;
  i:=1;
  While i<=dx do
  Begin
   If d>0 Then
   Begin
    d:=d+d2;
    y:=y+sy;
   End
   Else d:=d+d1;
   PutP(x, y, c);
   Inc(i);
   Inc(x, sx);
  End;
 End
 Else
 Begin
  d:=(dx shl 1)-dy;
  d1:=dx shl 1;
  d2:=(dx-dy) shl 1;
  PutP(x1, y1, c);
  x:=x1;
  y:=y1+sy;
  i:=1;
  While i<=dy do
  Begin
   If d>0 Then
   Begin
    Inc(d, d2);
    Inc(x, sx);
   End
   Else Inc(d, d1);
   PutP(x, y, c);
   Inc(i);
   Inc(y, sy);
  End;
 End;
End;

Procedure ShowT(x, y: Integer; Spr: _Sp);
Var
   i, j: Integer;
Begin
 For j:=y to y+4 do
  For i:=x to x+12 do
    If Spr[j-y+1, i-x+1]<>0 Then PutP(i, j, Spr[j-y+1, i-x+1]);
End;

Procedure ShowMouse; Assembler;
Asm
 mov ax, 1
 int 33h
End;

Procedure HideMouse; Assembler;
Asm
 mov ax, 2
 int 33h
End;

Procedure ReadMouse(var xxm, yym, bbm: Word);
Var
   xm, ym, bm: Word;
Begin
 Asm
  mov ax, 3h
  int 33h
  mov xm, cx
  mov ym, dx
  mov bm, bx
 End;
 xxm:=xm shr 1;
 yym:=ym;
 bbm:=bm;
End;

Procedure WaitRetrace; Assembler;
Asm
 mov dx, 3dah
@Rt:
 in al, dx
 test al, 8
 jz @Rt
End;

Procedure Fade;
Var
   i, j: Integer;
   r, g, b: Integer;
Begin
 For j:=1 to 63 do
 Begin
  For i:=1 to 255 do
  Begin
   GetPal(i, r, g, b);
   If r>0 Then Dec(r);
   If g>0 Then Dec(g);
   If b>0 Then Dec(b);
   SetPal(i, r, g, b);
  End;
  WaitRetrace;
 End;
End;

Procedure Rect(x1, y1, x2, y2, c: Integer);
Var
   u: Integer;
Begin
 For u:=x1 to x2 do
 Begin
  PutP(u, y1, c);
  PutP(u, y2, c);
 End;
 For u:=y1 to y2 do
 Begin
  PutP(x1, u, c);
  PutP(x2, u, c);
 End;
End;

Procedure CLS;
Begin
 FillChar(Scr^, 64000, 0);
End;

Procedure Izometric;
Begin
 P[1, 1]:=-1.0/sqrt(2.0);
 P[1, 2]:=-P[1, 1];
 P[1, 3]:=0.0;
 P[2, 1]:=-1.0/sqrt(6.0);
 P[2, 2]:=P[2, 1];
 P[2, 3]:=-2.0*P[2, 1];
End;

Procedure Dimetric;
Var
   alpha, t: Real;
Begin
 alpha:=pi*15/180;
 P[1, 1]:=-1.0/sqrt(2.0);
 P[1, 2]:=-P[1, 1];
 P[1, 3]:=0.0;
 t:=Sin(alpha)/Cos(alpha);
 P[2, 1]:=t*P[1, 1];
 P[2, 2]:=P[2, 1];
 P[2, 3]:=Sqrt(1-sqr(t));
End;

Procedure Oblique;
Var
   alpha: Real;
Begin
 Alpha:=pi*45/180;
 P[1, 1]:=-sin(alpha);
 P[1, 2]:=1;
 P[1, 3]:=0;
 P[2, 1]:=-Cos(alpha);
 P[2, 2]:=0;
 P[2, 3]:=1;
End;

Procedure Init;
Begin
 Izometric;
 pcos:=Cos(6*2*pi/360);
 psin:=Sin(6*2*pi/360);
 mpi:=0;
 mli:=0;
 For i:=200 to _GC do SetPal(i, 20, 20, 60);
 _sqr:=false;
 _hlt:=false;
 _vid:=1;
End;

Procedure Project(x, y, z: Real; var u, v: Integer);
Begin
 u:=140+Round(P[1, 1]*x+P[1, 2]*y-P[1, 3]*z);
 v:=190+Round(P[2, 1]*x+P[2, 2]*y-P[2, 3]*z);
End;

Procedure Pix3d(x, y, z: Real; c: Integer);
Var
   u, v: Integer;
Begin
 Project(x, y, z, u, v);
 PutP(u, v, c);
End;

Procedure Line3d(x, y, z, x1, y1, z1: Real; c: Integer);
Var
   u, v, u1, v1: Integer;

Procedure Project(x, y, z: Real; var u, v: Integer);
Begin
 u:=140+Round(P[1, 1]*x+P[1, 2]*y-P[1, 3]*z);
 v:=190+Round(P[2, 1]*x+P[2, 2]*y-P[2, 3]*z);
End;

Begin
 Project(x, y, z, u, v);
 Project(x1, y1, z1, u1, v1);
 Line(u, v, u1, v1, c);
End;

{---------------------INTERFACE--------------------------}

Procedure InterF;
Begin
 { Perspective }
 If _vid=1 Then
 Begin
  Line3d(1, 1, 1, 100, 1, 1, 30);
  Line3d(1, 1, 1, 1, 100, 1, 40);
  Line3d(1, 1, 1, 1, 1, 100, 45);
  ShowT(70, 192, _X);
  ShowT(140, 192, _Z);
  ShowT(210, 192, _Y);
  If _sqr=true Then
  Begin
   Line3d(1, 100, 100, 100, 100, 100, 30);
   Line3d(1, 1, 100, 100, 1, 100, 30);
   Line3d(1, 100, 1, 100, 100, 1, 30);

   Line3d(100, 1, 1, 100, 1, 100, 45);
   Line3d(1, 100, 1, 1, 100, 100, 45);
   Line3d(100, 100, 1, 100, 100, 100, 45);

   Line3d(100, 1, 1, 100, 100, 1, 40);
   Line3d(1, 1, 100, 1, 100, 100, 40);
   Line3d(100, 1, 100, 100, 100, 100, 40);
  End;
 End;
 { x/y }
 If _vid=2 Then
 Begin
  Line(100, 190, 100, 90, 40);
  Line(100, 190, 210, 190, 30);
  ShowT(90, 90, _Y);
  ShowT(200, 192, _X);
 End;
 { x/z }
 If _vid=3 Then
 Begin
  Line(100, 190, 100, 90, 45);
  Line(100, 190, 210, 190, 30);
  ShowT(90, 90, _Z);
  ShowT(200, 192, _X);
 End;
 { y/z }
 If _vid=4 Then
 Begin
  Line(100, 190, 100, 90, 45);
  Line(100, 190, 210, 190, 40);
  ShowT(90, 90, _Z);
  ShowT(200, 192, _Y);
 End;

 Rect(1, 0, 278, 199, 206);
 Rect(280, 0, 319, 199, 200);
 Bar(282, 2, 317, 10, 201);   { Exit }
 Bar(282, 46, 317, 54, 207);  { Sqr  }

 Rect(281, 12, 318, 44, 205);
 Bar(283, 14, 316, 22, 202); { Izometric }
 Bar(283, 24, 316, 32, 203); { Dimetric  }
 Bar(283, 34, 316, 42, 204); { Oblique   }
 ShowT(292, 4, _Exit);
 ShowT(292, 16, _Izom);
 ShowT(294, 26, _Dim);
 ShowT(294, 36, _Obl);
 ShowT(294, 48, _S);
 Rect(281, 56, 318, 78, 211);
 Bar(283, 58, 316, 66, 212); { Pixel }
 Bar(283, 68, 316, 76, 213); { Line  }
 ShowT(294, 60, _Pix);
 ShowT(293, 70, _Line);

 Rect(281, 156, 318, 198, 230);
 Bar(283, 188, 316, 196, 231); { Perspective }
 Bar(283, 178, 316, 186, 232); { x/y         }
 Bar(283, 168, 316, 176, 233); { x/z         }
 Bar(283, 158, 316, 166, 234); { y/z         }
 ShowT(294, 190, _Persp);
 ShowT(294, 180, _xy);
 ShowT(294, 170, _xz);
 ShowT(294, 160, _yz);
End;

Procedure ShowObjects;
Begin
 If _vid=1 Then
 Begin
  For i:=1 to mpi do Pix3d(MP[i].x, MP[i].y, MP[i].z, MP[i].c);
  For i:=1 to mli do Line3d(ML[i].x1, ML[i].y1, ML[i].z1,
      ML[i].x2, ML[i].y2, ML[i].z2, ML[i].c);
 End;
 If _vid=2 Then
 Begin
  For i:=1 to mpi do PutP(100+MP[i].x, 190-MP[i].y, MP[i].c);
  For i:=1 to mli do Line(100+ML[i].x1, 190-ML[i].y1,
      100+ML[i].x2, 190-ML[i].y2, ML[i].c);
 End;
 If _vid=3 Then
 Begin
  For i:=1 to mpi do PutP(100+MP[i].x, 190-MP[i].z, MP[i].c);
  For i:=1 to mli do Line(100+ML[i].x1, 190-ML[i].z1,
      100+ML[i].x2, 190-ML[i].z2, ML[i].c);
 End;
 If _vid=4 Then
 Begin
  For i:=1 to mpi do PutP(100+MP[i].y, 190-MP[i].z, MP[i].c);
  For i:=1 to mli do Line(100+ML[i].y1, 190-ML[i].z1,
      100+ML[i].y2, 190-ML[i].z2, ML[i].c);
 End;
End;

Procedure ChangePr;
Begin
 WaitRetrace;
 CLS;
 InterF;
 ShowObjects;
 HideMouse;
 ShowScr;
 ShowMouse;
End;

Procedure ResetMouse;
Begin
 For i:=1 to 100 do
 Begin
  WaitRetrace;
  ReadMouse(xm, ym, bm);
 End;
 bm:=2;
End;

Procedure SetMouse(x, y: Integer); Assembler;
Asm
 mov ax, 4
 mov cx, word ptr x
 mov dx, word ptr y
 int 33h
End;

Procedure Bar(x1, y1, x2, y2, c: Integer);
Var
   i, j: Integer;
Begin
  For i:=x1 to x2 do
    For j:=y1 to y2 do PutP(i, j, c);
End;

Procedure Morph(x, y, xx, yy, x1, y1, x2, y2: Real);
Var
   n, ii, i, j: Integer;
   sx1, sx2, sy1, sy2: Real;
Begin
 HideMouse;
 SetMouse(Round((x+(xx-x)/2)*2), Round(y+(yy-y)/2));
 n:=20;
 sx1:=(x-x1)/n;
 sx2:=(xx-x2)/n;
 sy1:=(y-y1)/n;
 sy2:=(yy-y2)/n;
 For ii:=1 to n do
 Begin
  CLS;
  InterF;
  ShowObjects;
  Bar(Round(x1)+1, Round(y1)+1, Round(x2)-1, Round(y2)-1, 0);
  Rect(Round(x1), Round(y1), Round(x2), Round(y2), 208);
  x1:=x1+sx1;
  x2:=x2+sx2;
  y1:=y1+sy1;
  y2:=y2+sy2;
  ShowScr;
  WaitRetrace;
 End;
 ShowMouse;
End;

{---------------------EXIT----------------------------}

Procedure _Halt;
Var
   ii, i, j, n: Integer;
   r, g, b: Integer;
Begin
 Morph(90, 50, 190, 100, 282, 2, 317, 10);
 CLS;
 InterF;
 ShowObjects;
 Bar(90, 50, 190, 100, 0);
 Rect(90, 50, 190, 100, 208);
 ShowT(129, 60, _Exit);
 ShowT(144, 59, _V);
 PutP(145, 65, 208);
 Bar(98, 83, 133, 91, 209);
 Bar(145, 83, 180, 91, 210);
 ShowT(110, 85, _Yes);
 ShowT(160, 85, _No);
 HideMouse;
 ShowScr;
 ShowMouse;
 ResetMouse;
 _hlt:=true;
 Repeat
  Repeat
   ReadMouse(xm, ym, bm);
   For i:=1 to 50 do WaitRetrace;
   EffectGash;
  Until (bm=1);
  If (xm>98) and (xm<133) and (ym>83) and (ym<91) Then
  Begin
   Fade;
   Asm
    mov ax, 3
    int 10h
   End;
   FreeMem(Scr, 64000);
   Halt;
  End;
  If (xm>145) and (xm<180) and (ym>83) and (ym<91) Then Break;
 Until (bm=2);
 Morph(282, 2, 317, 10, 90, 50, 190, 100);
 _hlt:=false;
 ChangePr;
End;

{---------------------PIXEL---------------------------}

Procedure _Pixel;
Var
   _E: Boolean;
   Key: Char;

Procedure _MakeP;
Var
   z: Integer;
Begin
 Morph(283, 58, 316, 64, 90, 50, 190, 85);
 Morph(1, 0, 60, 45, 283, 58, 316, 64);
 CLS;
 InterF;
 ShowObjects;
 Bar(1, 0, 60, 45, 0);
 Rect(1, 0, 60, 45, 208);
 ShowScr;
 Inc(mpi);
 HideMouse;
 GotoXY(1, 1);
 Write('X: ');
 ReadLn(MP[mpi].x);
 GotoXY(1, 2);
 Write('Y: ');
 ReadLn(MP[mpi].y);
 GotoXY(1, 3);
 Write('Z: ');
 ReadLn(MP[mpi].z);
 GotoXY(1, 4);
 Write('C: ');
 ReadLn(MP[mpi].c);
 ShowMouse;
 _E:=true;
 Morph(283, 58, 316, 64, 1, 0, 60, 45);
End;

Begin
 _E:=false;
 Morph(90, 50, 190, 85, 283, 58, 316, 64);
 CLS;
 InterF;
 ShowObjects;
 Bar(90, 50, 190, 85, 0);
 Rect(90, 50, 190, 85, 208);
 Bar(100, 55, 180, 65, 220);
 Bar(100, 69, 180, 79, 221);
 ShowT(137, 71, _Ok);
 ShowT(137, 57, _Add);
 HideMouse;
 ShowScr;
 ShowMouse;
 ResetMouse;
 _hlt:=true;
 Repeat
  Repeat
   ReadMouse(xm, ym, bm);
   For i:=1 to 50 do WaitRetrace;
   EffectGash;
  Until bm=1;
  If (xm>100) and (xm<180) and (ym>69) and (ym<79) Then Break;
  If (mpi<50) and (xm>100) and (xm<180) and (ym>55) and (ym<65) Then _MakeP;
  If _E=true Then Break;
 Until bm=2;
 If _E=false Then Morph(283, 58, 316, 64, 90, 50, 190, 85);
 _hlt:=false;
 ChangePr;
End;

{---------------------LINE---------------------------}

Procedure _Lin;
Var
   _E: Boolean;

Procedure _MakeL;
Var
   z: Integer;
Begin
 Morph(283, 68, 316, 76, 90, 50, 190, 85);
 Morph(1, 0, 70, 70, 283, 68, 316, 76);
 CLS;
 InterF;
 ShowObjects;
 Bar(1, 0, 70, 70, 0);
 Rect(1, 0, 70, 70, 208);
 ShowScr;
 Inc(mli);
 HideMouse;
 GotoXY(1, 1);
 Write('X1: ');
 ReadLn(ML[mli].x1);
 GotoXY(1, 2);
 Write('Y1: ');
 ReadLn(ML[mli].y1);
 GotoXY(1, 3);
 Write('Z1: ');
 ReadLn(ML[mli].z1);
 GotoXY(1, 4);
 Write('X2: ');
 ReadLn(ML[mli].x2);
 GotoXY(1, 5);
 Write('Y2: ');
 ReadLn(ML[mli].y2);
 GotoXY(1, 6);
 Write('Z2: ');
 ReadLn(ML[mli].z2);
 GotoXY(1, 7);
 Write('C: ');
 ReadLn(ML[mli].c);
 ShowMouse;
 _E:=true;
 Morph(283, 68, 316, 76, 1, 0, 70, 70);
End;

Begin
 _E:=false;
 Morph(90, 50, 190, 85, 283, 68, 316, 76);
 CLS;
 InterF;
 ShowObjects;
 Bar(90, 50, 190, 100, 0);
 Rect(90, 50, 190, 85, 208);
 Bar(100, 55, 180, 65, 220);
 Bar(100, 69, 180, 79, 221);
 ShowT(137, 57, _Add);
 ShowT(137, 71, _Ok);
 HideMouse;
 ShowScr;
 ShowMouse;
 ResetMouse;
 _hlt:=true;
 Repeat
  Repeat
   ReadMouse(xm, ym, bm);
   For i:=1 to 50 do WaitRetrace;
   EffectGash;
  Until bm=1;
  If (xm>100) and (xm<180) and (ym>69) and (ym<79) Then Break;
  If (mli<50) and (xm>100) and (xm<180) and (ym>55) and (ym<65) Then _MakeL;
  If _E=true Then Break;
 Until bm=2;
 If _E=false Then Morph(283, 68, 316, 76, 90, 50, 190, 85);
 _hlt:=false;
 ChangePr;
End;

{----------------------FindObject-------------------------}

Procedure FindObject;
Var
   u, v, q, w, i: Integer;
   Z: Point;

Procedure ChangePix(n: Integer);
Begin
 HideMouse;
 CLS;
 InterF;
 ShowObjects;
 Bar(1, 0, 120, 45, 0);
 Rect(1, 0, 120, 45, 208);
 ShowScr;
 GotoXY(1, 1);
 Write('X (', MP[n].x,') : ');
 ReadLn(MP[n].x);
 GotoXY(1, 2);
 Write('Y (', MP[n].y,') : ');
 ReadLn(MP[n].y);
 GotoXY(1, 3);
 Write('Z (', MP[n].z,') : ');
 ReadLn(MP[n].z);
 GotoXY(1, 4);
 Write('C (', MP[n].c,') : ');
 ReadLn(MP[n].c);
 If MP[n].c=0 Then
 Begin
  i:=1;
  Repeat
   If MP[i].c<MP[i+1].c Then
   Begin
    Z.x:=MP[i].x;
    Z.y:=MP[i].y;
    Z.z:=MP[i].z;
    Z.c:=MP[i].c;
    MP[i].x:=MP[i+1].x;
    MP[i].y:=MP[i+1].y;
    MP[i].z:=MP[i+1].z;
    MP[i].c:=MP[i+1].c;
    MP[i+1].x:=Z.x;
    MP[i+1].y:=Z.y;
    MP[i+1].z:=Z.z;
    MP[i+1].c:=Z.c;
    i:=0;
   End;
   Inc(i);
  Until i>=mpi;
  Dec(mpi);
 End;
 CLS;
 InterF;
 ShowObjects;
 ShowScr;
 ShowMouse;
End;

Procedure ChangeLine(n: Integer);
Var
   Z: Lin;
Begin
 HideMouse;
 CLS;
 InterF;
 ShowObjects;
 Bar(1, 0, 120, 70, 0);
 Rect(1, 0, 120, 70, 208);
 ShowScr;
 GotoXY(1, 1);
 Write('X1 (', ML[n].x1,') : ');
 ReadLn(ML[n].x1);
 GotoXY(1, 2);
 Write('Y1 (', ML[n].y1,') : ');
 ReadLn(ML[n].y1);
 GotoXY(1, 3);
 Write('Z1 (', ML[n].z1,') : ');
 ReadLn(ML[n].z1);
 GotoXY(1, 4);
 Write('X2 (', ML[n].x2,') : ');
 ReadLn(ML[n].x2);
 GotoXY(1, 5);
 Write('Y2 (', ML[n].y2,') : ');
 ReadLn(ML[n].y2);
 GotoXY(1, 6);
 Write('Z2 (', ML[n].z2,') : ');
 ReadLn(ML[n].z2);
 GotoXY(1, 7);
 Write('C (', ML[n].c,') : ');
 ReadLn(ML[n].c);
 If ML[n].c=0 Then
 Begin
  i:=1;
  Repeat
   If ML[i].c<ML[i+1].c Then
   Begin
    Z.x1:=ML[i].x1;
    Z.y1:=ML[i].y1;
    Z.z1:=ML[i].z1;
    Z.x2:=ML[i].x2;
    Z.y2:=ML[i].y2;
    Z.z2:=ML[i].z2;
    Z.c:=ML[i].c;
    ML[i].x1:=ML[i+1].x1;
    ML[i].y1:=ML[i+1].y1;
    ML[i].z1:=ML[i+1].z1;
    ML[i].x2:=ML[i+1].x2;
    ML[i].y2:=ML[i+1].y2;
    ML[i].z2:=ML[i+1].z2;
    ML[i].c:=ML[i+1].c;
    ML[i+1].x1:=Z.x1;
    ML[i+1].y1:=Z.y1;
    ML[i+1].z1:=Z.z1;
    ML[i+1].x2:=Z.x2;
    ML[i+1].y2:=Z.y2;
    ML[i+1].z2:=Z.z2;
    ML[i+1].c:=Z.c;
    i:=0;
   End;
   Inc(i);
  Until i>=mli;
  Dec(mli);
 End;
 CLS;
 InterF;
 ShowObjects;
 ShowScr;
 ShowMouse;
End;

Begin
 { Perspective }
 If _vid=1 Then
 Begin
  For i:=1 to mpi do
  Begin
   Project(MP[i].x, MP[i].y, MP[i].z, u, v);
   If (u=xm) and (v=ym) Then
   Begin
    ChangePix(i);
    Break;
   End;
  End;
  For i:=1 to mli do
  Begin
   Project(ML[i].x1, ML[i].y1, ML[i].z1, u, v);
   Project(ML[i].x2, ML[i].y2, ML[i].z2, q, w);
   If (w-v<>0) and (q-u<>0) Then
   Begin
    If (w-v)<(q-u) Then
    Begin
     If ym=Round(v+((w-v)/(q-u))*(xm-u)) Then
     Begin
      ChangeLine(i);
      Break;
     End;
    End
    Else
    Begin
     If xm=Round(u+((q-u)/(w-v))*(ym-v)) Then
     Begin
      ChangeLine(i);
      Break;
     End;
    End;
   End;
  End;
 End;
 { X/Y }
 If _vid=2 Then
 Begin
  For i:=1 to mpi do
   If (xm=100+MP[i].x) and (ym=190-MP[i].y) Then
   Begin
    ChangePix(i);
    Break;
   End;
 End;
 { X/Z }
 If _vid=3 Then
 Begin
  For i:=1 to mpi do
   If (xm=100+MP[i].x) and (ym=190-MP[i].z) Then
   Begin
    ChangePix(i);
    Break;
   End;
 End;
 { Y/Z }
 If _vid=4 Then
 Begin
  For i:=1 to mpi do
   If (xm=100+MP[i].y) and (ym=190-MP[i].z) Then
   Begin
    ChangePix(i);
    Break;
   End;
 End;
End;

Begin
 GetMem(Scr, 64000);
 CLS;
 Asm
  mov ax, 13h
  int 10h
 End;
 Init;
 InterF;
 ShowObjects;
 ShowScr;
 ShowMouse;
 Repeat
  Repeat
   ReadMouse(xm, ym, bm);
   For i:=1 to 100 do WaitRetrace;
   EffectGash;
  Until (bm=1) or (bm=2) or (Port[$60]=1);
  If (xm>282) and (xm<317) and (ym>2) and (ym<10) and (bm=1) Then _Halt;
  If (xm>283) and (xm<316) and (ym>14) and (ym<22) and (bm=1) Then
  Begin
   Izometric;
   ChangePr;
  End;
  If (xm>283) and (xm<316) and (ym>24) and (ym<32) and (bm=1) Then
  Begin
   Dimetric;
   ChangePr;
  End;
  If (xm>283) and (xm<316) and (ym>34) and (ym<42) and (bm=1) Then
  Begin
   Oblique;
   ChangePr;
  End;
  If (xm>282) and (xm<317) and (ym>46) and (ym<54) and (bm=1) Then
  Begin
   If _sqr=true Then _sqr:=false
   Else _sqr:=true;
   ChangePr;
   ResetMouse;
  End;
  If (xm>283) and (xm<316) and (ym>58) and (ym<66) and (bm=1) Then _Pixel;
  If (xm>283) and (xm<316) and (ym>68) and (ym<76) and (bm=1) Then _Lin;
  If (xm>283) and (xm<316) and (ym>188) and (ym<196) and (bm=1) Then
  Begin
   _vid:=1;
   ChangePr;
   ResetMouse;
  End;
  If (xm>283) and (xm<316) and (ym>178) and (ym<186) and (bm=1) Then
  Begin
   _vid:=2;
   ChangePr;
   ResetMouse;
  End;
  If (xm>283) and (xm<316) and (ym>168) and (ym<176) and (bm=1) Then
  Begin
   _vid:=3;
   ChangePr;
   ResetMouse;
  End;
  If (xm>283) and (xm<316) and (ym>158) and (ym<166) and (bm=1) Then
  Begin
   _vid:=4;
   ChangePr;
   ResetMouse;
  End;
  If (xm>50) and (xm<240) and (ym>15) and (ym<195) and (bm=1) Then
  Begin
   FindObject;
  End;
 Until (bm=1) and (Port[$60]=1);
 Fade;
 Asm
  mov ax, 3
  int 10h
 End;
 FreeMem(Scr, 64000);
End.
