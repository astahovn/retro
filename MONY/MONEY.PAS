{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 16384,0,655360}
{ $M 16384, 0, 327680 }
program mons;
uses {play_v,} dos, graph, crt{, mk4}; {��몠��� �ࠣ�����,�맮� ⥪�⮢��� 䠩��}
 var gd,gm:integer; {����᪨� ��६����}
         n,m:integer; {��६���� �⢥��騥 �� �������� ��䨪�}
         money:integer;{��६���� �⢥��騥 �� �롮� ��楢�� ��� ������}
         mon:integer;{��६���� �⢥��騥 �� �롮� ���짮��⥫�  }
         fs : boolean;
         tf: integer;{��६����� �⢥���� �� ���᪨� ����}
         ST : STRING;{��६����� �⢥���� �� ��� �窮�}
         key:char;{��६����� �⢥���� �� ����� ����⮩ ������}
         sc,scs:integer;{��६����� �⢥���� �� ��砫쭮� ���-�� �窮� }

procedure over;forward;{����� ����}
procedure soob;forward;{ᮮ�饭�� �� �窠�}
procedure sscs;forward;
procedure info;forward;{���ᠭ��}
procedure reshka;forward;{���⨭�� �誨}
procedure orel;forward;{���⨭�� �ૠ}
procedure bok;forward; {���⨭�� ॡ�}
procedure score;forward;{�ਡ������� �窮�}
procedure scors;forward;{���⠭�� �窮�}
procedure vibor_1;forward;{�롮� � ������� ����}
procedure vibor_2;forward;{�롮� � ����⥯����� ����}
procedure options;forward;{������� ����}
procedure menu;forward;{����⥯����� ����}
procedure pictyre;forward;{���⠢�� ����}
procedure games;forward;{��饭�� ������}
procedure rnd;forward;{��砩�� �롮� ��஭� ������}
procedure result;forward;{१����}

procedure r; assembler;
asm
 mov dx, 3dah
@1:
 in al, dx
 test al, 8
 jz @1
end;

procedure info;
begin
restorecrtmode;  { ������ ⥪�⮢��� ०��� ��� �맮�� 䠩��}
{txt('money1.txt', 2);{�맮� txt 䠩��}
readkey;
initgraph(gd, gm, '');{���樠�����㥬 ��䨪�}
options;
end;

procedure pictyre;
begin
ReadKey;
settextstyle(4, 0, 3 );
n:=480;
repeat
{Delay(50);}
r;
cleardevice;
line(180,n,460,n);
n:=n-5;
until n = 300;
n:=0;
m:=640;
repeat
setcolor(15);
line(n,140,n,300);
line(m,140,m,300);
{Delay(50);}
r;
setcolor(0);
line(n,140,n,300);
line(m,140,m,300);
n:=n+1;
m:=m-1;
setcolor(15);
until (n =180) and (m = 460);
n:=180;
m:=460;
repeat
line(n,140,180,300);
line(m,140,460,300);
{Delay(50);}
r;
setcolor(0);
line(n,140,180,300);
line(m,140,460,300);
setcolor(15);
n:=n+1;
m:=m-1;
until (n=320) and (m=320);
line(n,140,180,300);
line(m,140,460,300);
SETCOLOR(9);
settextstyle(tf,0,7);
outtextxy(245,140,'����');
settextstyle(tf,0,4);
outtextxy(290,200,'���');
settextstyle(tf,0,7);
outtextxy(230,220,'�����');
{play('life.voc');{������}
Readkey;
options;
end;

procedure score;
begin
settextstyle(7,0,7);
SC:=SC-1;{���⠭�� �窮�}
STR(SC, ST);
if SC=0 then over;
delay(2000);
cleardevice;
soob;
end;

procedure scors;
begin
settextstyle(7,0,7);
SC:=SC+1; {᫮����� �窮�}
STR(SC, ST);
delay(2000);
cleardevice;
soob;
end;

procedure over;
begin
cleardevice;
settextstyle(7,0,7);
outtextxy(110,150,'GAME OVER');
{play('over.voc');{��몠}
halt;
end;

procedure options;
begin
cleardevice;
settextstyle(9,0,3);
n:=0;
m:=640;
repeat
outtextxy(n,200,'1-start');
outtextxy(m,240,'2-info');
outtextxy(n,280,'3-exit');
{delAy(5);}
r;
setcolor(0);
outtextxy(n,200,'1-start');
outtextxy(m,240,'2-info');
outtextxy(n,280,'3-exit');
setcolor(15);
n:=n+10;
m:=m-10;
until n=320;
outtextxy(n,200,'1-start');
outtextxy(m,240,'2-info');
outtextxy(n,280,'3-exit');
{play('not.voc');{��몠}
vibor_1;
end;

procedure vibor_1;
begin
 key:=readkey;
if key='1' then menu;
if key='2' then info;
if key='3' then Halt;
if key=#24 then Halt;
if key=#26 then info;
end;

procedure menu;
begin
cleardevice;
settextstyle(9,0,3);
n:=0;
m:=640;
repeat
outtextxy(n,200,'1-orel');
outtextxy(m,240,'2-reshka');
outtextxy(n,280,'3-rebro');
outtextxy(m,320,'4-exit');
{delay(5);}
r;
setcolor(0);
outtextxy(n,200,'1-orel');
outtextxy(m,240,'2-reshka');
outtextxy(n,280,'3-rebro');
outtextxy(m,320,'4-exit');
setcolor(15);
n:=n+40;
m:=m-40;
until n=320;
outtextxy(n,200,'1-orel');
outtextxy(m,240,'2-reshka');
outtextxy(n,280,'3-rebro');
outtextxy(m,320,'4-exit');
{play('not.voc');{��몠}
vibor_2;
end;

procedure vibor_2;
begin
key:=READKEY;
if key ='1' then mon:=1;
if key ='2' then mon:=2;
if key ='3' then mon:=3;
if key =#10 then sscs;
if key=#26 then info;
if key ='4' then options;
games;
end;

procedure sscs;
begin
cleardevice;
setcolor(2);
readln(scs);
sc:=scs;
setcolor(15);
cleardevice;
menu;
end;

procedure games;
begin
if key=#26 then info;
cleardevice;
for n:=1 to 10 do begin
circle(320,240,100);
settextstyle(4,0,9);
outtextxy(260,180,'20');
delay(100);
cleardevice;
ellipse(320,240,0,360,100,30);
DELAY(100);
cleardevice;
rectangle(220,235,420,245);
delay(100);
cleardevice;
ellipse(320,240,0,360,100,30);
delay(100);
cleardevice;
circle(320,240,100);
end;
rnd;
end;

procedure rnd;
begin
randomize;
money:=1+random(3);
if money=1 then orel;
if money=2 then reshka;
if money=3 then bok;
end;

procedure orel;
begin
cleardevice;
circle(320,240,100);
line(350,180,340,170);
line(350,180,340,190);
line(340,190,340,200);
line(300,170,295,200);
arc(320,170,0,180,20);
line(295,200,310,190);
line(310,190,320,200);
line(320,200,330,190);
line(330,190,340,200);
line(340,200,400,220);
line(295,200,240,220);
line(300,220,250,230);
line(340,220,390,230);
line(260,240,300,240);
line(340,240,380,240);
line(290,250,350,250);
line(300,260,340,260);
line(310,270,330,270);
line(315,280,325,280);
putpixel(320,290,15);
circle(320,310,10);
circle(323,170,2);
if key=#26 then info;
result;
end;

procedure reshka;
begin
cleardevice;
circle(320,240,100);
settextstyle(4,0,9);
outtextxy(260,180,'20');
result;
end;

procedure bok;
begin
cleardevice;
rectangle(220,235,420,245);
result;
end;

procedure result;
begin
delay(10000);
cleardevice;
if mon<>money then begin
settextstyle(tf,0,5);
outtextxy(200,240,'�� ���������');
Delay(10000);
{play('no2.voc');{��몠}
if key=#26 then info;
SCORE;
end
else
begin
settextstyle(tf,0,5);
outtextxy(200,240,'�� ��������');
Delay(10000);
{play('ohyeh.voc');{��몠}
if key=#26 then info;
scors;
end;
end;

procedure soob;
begin
settextstyle(7,0,7);
OUTTEXTXY(100, 100, 'SCORE   '+ST);
Delay(10000);
if key=#26 then info;
menu;
end;

begin
fs:=false;
setcbreak(fs);
SC:=5;
gd:=detect;
initgraph(gd,gm,'');
tf:=installuserfont('C_01.chr');{������祭�� ����}
pictyre;
readln;
closegraph;
end.

