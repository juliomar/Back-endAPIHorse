unit View.Controller.Endereco;

interface

uses
  System.SysUtils,
  System.JSON,
  Data.DB,
  FireDAC.Comp.Client,
  DataSet.Serialize,
  Horse,
  Horse.BasicAuthentication,
  Controller.Interfaces;
type
  TViewControllerEndereco = class
    private
      FBody       : TJSONValue;
      FJSONObject : TJSONObject;
      FJSONArray  : TJSONArray;
      FDataSource : TDataSource;
      FController : iController;
      FQuantidadeRegistro : Integer;
      procedure GetAll (Req: THorseRequest; Res: THorseResponse; Next : TProc);
      procedure GetbyId(Req: THorseRequest; Res: THorseResponse; Next : TProc);
      procedure Post   (Req: THorseRequest; Res: THorseResponse; Next : TProc);
      procedure Put    (Req: THorseRequest; Res: THorseResponse; Next : TProc);
      procedure Delete (Req: THorseRequest; Res: THorseResponse; Next : TProc);
      procedure Registry;
    public
      constructor Create;
      destructor Destroy; override;
  end;

implementation

uses
  Imp.Controller;

{ TViewControllerEndereco }

constructor TViewControllerEndereco.Create;
begin
  FController := TController.New;
  FDataSource := TDataSource.Create(nil);
  Registry;
end;

destructor TViewControllerEndereco.Destroy;
begin
  inherited;
end;

procedure TViewControllerEndereco.GetAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      if ((Req.Query.Field('cep').AsString<>'') or (Req.Query.Field('endereco').AsString<>'')) then
        FQuantidadeRegistro := FController
                                .FactoryDAO
                                  .DAOEndereco
                                    .This
                                      .Cep       (Req.Query.Field('cep').AsString)
                                      .Logradouro(Req.Query.Field('logradouro').AsString)
                                    .&End
                                  .GetbyParams
                                  .DataSet(FDataSource)
                                  .QuantidadeRegistro else
        FQuantidadeRegistro := FController
                                .FactoryDAO
                                  .DAOEndereco
                                    .GetAll
                                  .DataSet(FDataSource)
                                  .QuantidadeRegistro;

     if FQuantidadeRegistro > 1  then
     begin
       FJSONArray := FDataSource.DataSet.ToJSONArray();
       Res.Send<TJSONArray>(FJSONArray);
     end
     else
     begin
       FJSONObject := FDataSource.DataSet.ToJSONObject();
       Res.Send<TJSONObject>(FJSONObject);
     end;
   except
     Res.Status(500).Send('Ocorreu um erro interno no servidor.');
     Exit;
   End;
  finally
    if FDataSource.DataSet.IsEmpty then
      Res.Status(404).Send('Registro n�o encontrado!') else
      Res.Status(201).Send('Registro encontrado com sucesso!');
  end;
end;

procedure TViewControllerEndereco.GetbyId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Try
     try
       FController
         .FactoryDAO
           .DAOEndereco
             .GetbyId(Req.Params['id'].ToInt64)
           .DataSet(FDataSource);

       FJSONObject := FDataSource.DataSet.ToJSONObject();
       Res.Send<TJSONObject>(FJSONObject);
   except
     Res.Status(500).Send('Ocorreu um erro interno no servidor.');
     Exit;
   End;
   Finally
     if FDataSource.DataSet.IsEmpty then
       Res.Status(404).Send('Registro n�o encontrado!') else
       Res.Status(201).Send('Registro encontrado com sucesso!');
   End;
end;

procedure TViewControllerEndereco.Post(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FJSONObject := Req.Body<TJSONObject>;
      FController
        .FactoryDAO
          .DAOEndereco
            .This
              .Cep           (FJSONObject.GetValue<String> ('cep'))
              .IBGE          (FJSONObject.GetValue<Integer>('ibge'))
              .UF            (FJSONObject.GetValue<String> ('uf'))
              .TipoLogradouro(FJSONObject.GetValue<String> ('tipoLogradouro'))
              .Logradouro    (FJSONObject.GetValue<String> ('Logradouro'))
              .Bairro        (FJSONObject.GetValue<String> ('bairro'))
              .GIA           (FJSONObject.GetValue<Integer>('gia'))
              .DDD           (FJSONObject.GetValue<String> ('ddd'))
            .&End
          .Post
          .DataSet(FDataSource);
    except
      Res.Status(500).Send('Ocorreu um erro interno no servidor.');
      Exit;
    end;
    try
      FController
        .FactoryDAO
          .DAONumero
            .This
              .IdEndereco         (FDataSource.DataSet.FieldByName('id').AsInteger)
              .NumeroEndereco     (FJSONObject.GetValue<String>('numeroendereco'))
              .ComplementoEndereco(FJSONObject.GetValue<String>('complementoendereco'))
          .&End
          .Post
          .DataSet(FDataSource);
    except
      Res.Status(500).Send('Ocorreu um erro interno no servidor.');
      Exit;
    end;
  finally
    Res.Status(204).Send('Registro inclu�do com sucesso!');
  end;
end;

procedure TViewControllerEndereco.Put(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FJSONObject := Req.Body<TJSONObject>;
      FController
        .FactoryDAO
          .DAOEndereco
            .This
              .Id            (FJSONObject.GetValue<Integer>('id'))
              .Cep           (FJSONObject.GetValue<String> ('cep'))
              .IBGE          (FJSONObject.GetValue<Integer>('ibge'))
              .UF            (FJSONObject.GetValue<String> ('uf'))
              .TipoLogradouro(FJSONObject.GetValue<String> ('tipoLogradouro'))
              .Logradouro    (FJSONObject.GetValue<String> ('Logradouro'))
              .Bairro        (FJSONObject.GetValue<String> ('bairro'))
              .GIA           (FJSONObject.GetValue<Integer>('gia'))
              .DDD           (FJSONObject.GetValue<String> ('ddd'))
            .&End
          .Put
          .DataSet(FDataSource);
      FController
        .FactoryDAO
          .DAONumero
            .This
              .Id                 (FJSONObject.GetValue<Integer>('id'))
              .IdEndereco         (FDataSource.DataSet.FieldByName('id').AsInteger)
              .NumeroEndereco     (FBody.GetValue<String>('numeroendereco'))
              .ComplementoEndereco(FBody.GetValue<String>('complementoendereco'))
          .&End
          .Put
          .DataSet(FDataSource);
    except
      Res.Status(500).Send('Ocorreu um erro interno no servidor.');
      Exit;
    end;
  finally
    Res.Status(204).Send('Registro alterado com sucesso!');
  end;
end;

procedure TViewControllerEndereco.Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FController
        .FactoryDAO
          .DAOEndereco
            .This
              .Id(Req.Params['id'].ToInt64)
            .&End
          .Delete;
    except
      Res.Status(500).Send('Ocorreu um erro interno no servidor.');
      Exit;
    End;
  Finally
    Res.Status(204).Send('Registro exclu�do com sucesso!');
  End;
end;

procedure TViewControllerEndereco.Registry;
begin
  THorse
      .Group
        .Prefix  ('bmw')
          .Get   ('/endereco/:id' , GetbyId)
          .Get   ('/endereco'     , GetAll)
          .Post  ('endereco'      , Post)
          .Put   ('endereco/:id'  , Put)
          .Delete('endereco/:id'  , Delete);
end;

end.
