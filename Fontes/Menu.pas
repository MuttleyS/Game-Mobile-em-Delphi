unit Menu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects;

type
  TFrmNumbers = class(TForm)
    imgLogo: TImage;
    rectPlay: TRectangle;
    rectRanking: TRectangle;
    imgPlay: TImage;
    imgRanking: TImage;
    lbPlay: TLabel;
    lbRanking: TLabel;
    procedure rectPlayClick(Sender: TObject);
    procedure rectRankingClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmNumbers: TFrmNumbers;

implementation

uses
   Principal, Ranking;

{$R *.fmx}

procedure TFrmNumbers.rectPlayClick(Sender: TObject);
begin
   if not Assigned(FrmPrincipal) then
      Application.CreateForm(TFrmPrincipal, FrmPrincipal);
   FrmPrincipal.Show;
end;

procedure TFrmNumbers.rectRankingClick(Sender: TObject);
begin
   if not Assigned(FrmRanking) then
      Application.CreateForm(TFrmRanking, FrmRanking);
   FrmRanking.Show;
end;

end.
