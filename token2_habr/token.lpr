program token;

{$mode delphi}

uses
  {$IFDEF Unix}{$IFDEF UseCThreads}CThreads, {$ENDIF}{$ENDIF}
  Interfaces,
  Forms, Unit1
  { Add units here };

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Scaled := True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

