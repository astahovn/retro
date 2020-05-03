Type
    TScr = Array[1..64000] of Byte;
Var
    Scr: ^TScr;
    C: Array[1..400] of Real;
    a, i, j: Integer;

Procedure ShowScr;
Begin
 Move(Scr^, Mem[$A000:0], 64000);
End;

Procedure CLS;
Begin
 FillChar(Scr^, 64000, 0);
End;

Procedure P(x, y, c: Integer);
Begin
 Scr^[(y shl 8)+(y shl 6)+x]:=c;
End;

Procedure SetPal(x, r, g, b: Byte);
Begin
 Port[$3c8]:=x;
 Port[$3c9]:=r; Port[$3c9]:=g; Port[$3c9]:=b;
End;

Procedure Init;
Begin
 For i:=1 to 60 do SetPal(i, i, 0, 60-i);
 For i:=1 to 60 do SetPal(i+60, 60, i, 0);
 For i:=1 to 60 do SetPal(i+120, 60-i, 60-i, i);
 For i:=1 to 60 do SetPal(i+180, i, 0, 60);
 For i:=1 to 15 do SetPal(i+240, 60-i*2, 0, 60);
 For i:=1 to 200 do C[i]:=Cos(i*pi/180)/2;
End;

Begin
 GetMem(Scr, 64000);
 Asm
  mov ax, 13h
  int 10h
 End;
 Init;
 CLS;
 For j:=1 to 200 do
 Begin
  For i:=1 to 320 do
  Begin
   P(i, j, 100+Round((i-j)*C[j]));
  End;
 End;
 ShowScr;
 Asm
  xor ah, ah
  int 16h
  mov ax, 3h
  int 10h
 End;
 FreeMem(Scr, 64000);
End.
