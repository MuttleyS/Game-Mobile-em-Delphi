program Server;

uses
  System.StartUpCopy,
  FMX.Forms,
  Principal in 'Principal.pas' {FrmPrincipal},
  DAO.Connection in 'DAO\DAO.Connection.pas',
  DAO.Ranking in 'DAO\DAO.Ranking.pas',
  Controller.Ranking in 'Controller\Controller.Ranking.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
