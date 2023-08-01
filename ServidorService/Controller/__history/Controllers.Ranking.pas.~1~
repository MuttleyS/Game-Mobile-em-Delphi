unit Controller.Ranking;

interface

uses
   Horse, System.JSON, System.SysUtils, DAO.Ranking;

   procedure RegistrarRotas;
   procedure Listar(Req : THorseRequest; Res : THorseResponse; Next : Tproc);
   procedure Inserir(Req : THorseRequest; Res : THorseResponse; Next : Tproc);

implementation

procedure RegistrarRotas;
begin
   THorse.Get('/ranking', Listar);
   THorse.Post('/ranking', Inserir);
end;

procedure Listar(Req : THorseRequest; Res : THorseResponse; Next : Tproc);
var
   Ranking : TRanking;
begin
   try
      try
         Ranking := TRanking.Create;
         Res.Send<TJSONArray>(Ranking.Listar(10));
      Except
         on E : Exception do
            Res.Send(E.Message).Status(THTTPStatus.InternalServerError);
      end;
   finally
      Ranking.Free;
   end;
end;

procedure Inserir(Req : THorseRequest; Res : THorseResponse; Next : Tproc);
var
   Ranking : TRanking;
   Body : TJSONValue;
begin
   try
      Ranking := TRanking.Create;
      try
         Body := Req.Body<TJSONObject>;
         Ranking.Adicionar(Body.GetValue<string>('nome', ''),
                           Body.GetValue<Integer>('level', 0),
                           Body.GetValue<Integer>('pontos', 0));
         Res.Send('success').Status(THTTPStatus.Created);
      except
         on E : Exception do
            Res.Send(E.Message).Status(THTTPStatus.InternalServerError);
      end;
   finally
      Ranking.Free;
   end;
end;

end.
