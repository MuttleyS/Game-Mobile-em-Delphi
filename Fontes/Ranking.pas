unit Ranking;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.ListBox, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, RESTRequest4D, DataSet.Serialize,
  DataSet.Serialize.Adapter.RESTRequest4D, uLoading;

type
  TFrmRanking = class(TForm)
    rectVoltar: TRectangle;
    imgVoltar: TImage;
    Image1: TImage;
    lbRanking: TListBox;
    imgRanking1: TImage;
    TabPlacar: TFDMemTable;
    procedure rectVoltarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
   procedure AddRanking(Posicao, Pontuacao : Integer; Nome : string);
   procedure CarregarRanking;
   procedure ThreadTerminate(Sender : TObject);
  public
    { Public declarations }
  end;

var
  FrmRanking: TFrmRanking;

implementation

uses
   ListRanking;

{$R *.fmx}

procedure TFrmRanking.AddRanking(Posicao, Pontuacao : Integer; Nome : string);
var
   Item : TListBoxItem;
   Frame : TFrameRanking;
begin
   Item := TListBoxItem.Create(lbRanking);
   Item.Parent := lbRanking;
   Item.Text := '';
   Item.Selectable := False;
   Item.Height := 40;
   Frame := TFrameRanking.Create(Item);
   Frame.Parent := Item;
   Frame.lbPosicao.Text := Posicao.ToString;
   Frame.lbNomeJogador.Text := Nome;
   Frame.lbPtsJogador.Text := FormatFloat(',0', Pontuacao);
   if Posicao=1 then
      Frame.imgPosicao.Bitmap := imgRanking1.Bitmap;
   Item.AddObject(Frame);
   lbRanking.AddObject(Item);
end;

procedure TFrmRanking.ThreadTerminate(Sender : TObject);
begin
   TLoading.Hide;
   if Sender is TThread then begin
      if Assigned(TThread(Sender).FatalException) then begin
         ShowMessage(Exception(TThread(Sender).FatalException).Message);
         Exit;
      end;
   end;
end;

procedure TFrmRanking.CarregarRanking;
var
   I: Integer;
   T : TThread;
begin
   lbRanking.Items.Clear;
   TabPlacar.FieldDefs.Clear;
   TLoading.Show(FrmRanking, '');
   T := TThread.CreateAnonymousThread(procedure
   var
      Resp : IResponse;
   begin
      Resp := TRequest.New.BaseURL('http://localhost:9000')
              .Resource('ranking')
              .BasicAuthentication('numbers', 'numbers')
              .Adapters(TDataSetSerializeAdapter.New(TabPlacar))
              .Accept('application/json')
              .Get;
      if Resp.StatusCode <> 200 then
         raise Exception.Create(Resp.Content);
      while not TabPlacar.Eof do begin
         TThread.Synchronize(TThread.CurrentThread, procedure
         begin
            AddRanking(TabPlacar.RecNo,
                       TabPlacar.FieldByName('pontos').AsInteger,
                       TabPlacar.FieldByName('nome').AsString);
         end);
         TabPlacar.Next;
      end;
   end);
   T.OnTerminate := ThreadTerminate;
   T.Start;
end;

procedure TFrmRanking.FormShow(Sender: TObject);
begin
   CarregarRanking;
end;

procedure TFrmRanking.rectVoltarClick(Sender: TObject);
begin
   Close;
end;

end.
