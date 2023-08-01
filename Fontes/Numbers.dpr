program Numbers;

uses
  System.StartUpCopy,
  FMX.Forms,
  Menu in 'Menu.pas' {FrmNumbers},
  Principal in 'Principal.pas' {FrmPrincipal},
  GameOver in 'GameOver.pas' {FrmGameOver},
  Ranking in 'Ranking.pas' {FrmRanking},
  ListRanking in 'ListRanking.pas' {FrameRanking: TFrame},
  uLoading in 'Uteis\uLoading.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.CreateForm(TFrmNumbers, FrmNumbers);
  Application.Run;
end.
