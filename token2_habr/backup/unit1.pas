unit Unit1;

{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, fphttpclient, ShellApi, DateUtils  ;

{ TForm1 }

type
  TForm1 = class(TForm)
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Label2: TLabel;
    l_status: TLabel;
    Memo1: TMemo;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public
  Time_reload : TTime;
  end;

var
  Form1: TForm1;
  html,html_old : String;
  ip, url:String;
  f:textfile;
  flag_net:integer;
const
  name_up='up.bat';
  name_down='down.bat';
implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);


begin


end;

procedure config();
var id:string;

begin
  //настройка id c с генеррированием bat файлов
begin
ip:='192.168.111.1';
repeat
    ip := InputBox('settings', 'укажите IP сервера', ip);
until ip <> '';
repeat
    id := InputBox('settings', 'укажите ID токена', '1-1');
  until id <> '';
  //файл подключения
  assignfile(f,name_up);
  rewrite(f);//если файл есть, его очистит, если нет, создаст.
  writeln(f,'REM:'+ip);
  writeln(f,'@ECHO off');
  writeln(f,'usbip -a '+ip+ ' '+id+' > nul');
  writeln(f,'msg * "Token busy or unavailable"');
  closefile(f);
  assignfile(f,name_down);
  rewrite(f);//если файл есть, его очистит, если нет, создаст.
  writeln(f,'@ECHO off');
  writeln(f,'taskkill /IM usbip.exe /F /T  > nul'); //грубо
  writeln(f,'ping 127.0.0.1 -n 10 > nul'); //ждем
  writeln(f,'taskkill /IM conhost.exe /F /T  > nul'); //все консоли
  closefile(f);
end;
end;
procedure first_init();
begin
config();
end;

procedure TForm1.Button2Click(Sender: TObject);
begin //подсоединяемся
  if ShellExecute(0,nil, PChar('cmd'),PChar('/c '+name_up),nil,1) =0 then;
end;
procedure TForm1.Button3Click(Sender: TObject);
begin   //грубо отключаемся
   if ShellExecute(0,nil, PChar('cmd'),PChar('/c '+name_down),nil,1) =0 then;
end;
procedure TForm1.FormCreate(Sender: TObject);
var x,y:integer;
begin //при запуске инициализируем....
if not(FileExists(name_up) or FileExists(name_down)) then first_init();
memo1.Text := '';
assignfile(f,'up.bat');reset(f);
read(f, ip);
closefile(f); //нас волнует  строка...
x:=length(ip); y:=x-4; ip:= copy(ip,5,y); //пришлось играться из-за ошибок компилятора
//ShowMessage(ip); // отладка
url:='http://'+ip+'/123/usbip_fam.txt';
//Time_reload := IncSecond(Now, 15);
flag_net:=1;
end;

procedure TForm1.Label1Click(Sender: TObject);
var pass:string;
begin  //настройка id c с генеррированием bat файлов
pass := InputBox('settings', 'password', '1000');
if (pass='1111') then
config();
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
//memo1.Text :=  memo1.Text+'☺';
// if SecondsBetween(Time_reload, Now) > 15 then
//  begin  //SecondsBetween-темная история всегда возвращает модуль разницы
   // (Sender as TTimer).Enabled := False;
    Time_reload := IncSecond(Now, 15);
    try//при подключении с отладчиком при отсутсвие связи с веб сервером генерирует ошибку EsocketError
    html := TFPCustomHTTPClient.SimpleGet(url);
if (flag_net=0) then
begin flag_net:=1; l_status.Color:=clNone;l_status.Caption:='обм. з серв. підкл. відновл.'; end;
    except
    if (flag_net=1) then
    begin
    l_status.Color:=clRed; l_status.Caption:='error_1 обм. з серв. підкл.';
    flag_net:=0;
    end;end;
    if(html<>html_old)then
    begin
    memo1.Text :=  memo1.Text+TimeToStr(Time)+'_'+ html;
    html_old:=html;
    end;
 // end;
 if memo1.Lines.Count>10 then memo1.Text := '';
end;
end.

