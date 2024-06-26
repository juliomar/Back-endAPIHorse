unit Model.DAO.Imp.Caixa.Diario.Encerramento;

interface

uses
  Data.DB,
  System.SysUtils,

  Uteis.Interfaces,
  Uteis,
  Uteis.Tratar.Mensagens,

  Model.DAO.Caixa.Diario.Encerramento.Interfaces,
  Model.Entidade.Caixa.Diario.Encerramento.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;

type
  TDAOCaixaDiarioEncerramento= class(TInterfacedObject, iDAOCaixaDiarioEncerramento)
    private
      FCaixaDiarioEncerramento : iEntidadeCaixaDiarioEncerramento<iDAOCaixaDiarioEncerramento>;
      FConexao     : iConexao;
      FDataSet     : TDataSet;
      FQuery       : iQuery;
      FUteis       : iUteis;
      FMSG         : TMensagens;

    const
      FSQL=('select '+
            'cde.id, '+
            'cde.idcaixadiario, '+
            'cde.idusuario, '+
            'u.nomeusuario, '+
            'cde.valorlancamento, '+
            'cde.datahoraemissao, '+
            'cde.observacao '+
            'from caixadiarioencerramento cde '+
            'inner join usuario u on u.id = cde.idusuario '
            );
      function LoopRegistro(Value : Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOCaixaDiarioEncerramento;

      function DataSet    (DataSource : TDataSource) : iDAOCaixaDiarioEncerramento; overload;
      function DataSet                               : TDataSet;                    overload;
      function GetAll                                : iDAOCaixaDiarioEncerramento;
      function GetbyId    (Id : Variant)             : iDAOCaixaDiarioEncerramento;
      function GetbyParams                           : iDAOCaixaDiarioEncerramento; overload;
      function GetbyParams(aIdUsuario : Variant)     : iDAOCaixaDiarioEncerramento; overload;
      function GetbyParams(aNomeUsuario : String)    : iDAOCaixaDiarioEncerramento; overload;
      function GetbyParams(aIdPedido : Integer)      : iDAOCaixaDiarioEncerramento; overload;
      function Post                                  : iDAOCaixaDiarioEncerramento;
      function Put                                   : iDAOCaixaDiarioEncerramento;
      function Delete                                : iDAOCaixaDiarioEncerramento;
      function QuantidadeRegistro                    : Integer;

      function This : iEntidadeCaixaDiarioEncerramento<iDAOCaixaDiarioEncerramento>;
  end;

implementation

uses
  Model.Entidade.Imp.Caixa.Diario.Encerramento,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

constructor TDAOCaixaDiarioEncerramento.Create;
begin
  FCaixaDiarioEncerramento := TEntidadeCaixaDiarioEncerramento<iDAOCaixaDiarioEncerramento>.New(Self);
  FConexao     := TModelConexaoFiredacMySQL.New;
  FQuery       := TQuery.New;
  FUteis       := TUteis.New;
  FMSG         := TMensagens.Create;
end;

destructor TDAOCaixaDiarioEncerramento.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAOCaixaDiarioEncerramento.New: iDAOCaixaDiarioEncerramento;
begin
  Result := Self.Create;
end;

function TDAOCaixaDiarioEncerramento.DataSet(DataSource: TDataSource): iDAOCaixaDiarioEncerramento;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOCaixaDiarioEncerramento.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOCaixaDiarioEncerramento.GetAll: iDAOCaixaDiarioEncerramento;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
    begin
      FCaixaDiarioEncerramento.Id(FDataSet.FieldByName('cde.id').AsInteger);
      QuantidadeRegistro;
    end
    else
      FCaixaDiarioEncerramento.Id(0);
  end;
end;

function TDAOCaixaDiarioEncerramento.GetbyId(Id: Variant): iDAOCaixaDiarioEncerramento;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL+' where cde.Id=:Id')
                    .Params('Id', Id)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
      FCaixaDiarioEncerramento.Id(FDataSet.FieldByName('cde.id').AsInteger)
    else
      FCaixaDiarioEncerramento.Id(0);
  end;
end;

function TDAOCaixaDiarioEncerramento.GetbyParams(aIdPedido: Integer): iDAOCaixaDiarioEncerramento;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL+' where cde.idpedido=:Idpedido')
                    .Params('Idpedido', aIdPedido)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
      FCaixaDiarioEncerramento.Id(FDataSet.FieldByName('cde.id').AsInteger)
    else
      FCaixaDiarioEncerramento.Id(0);
  end;
end;

function TDAOCaixaDiarioEncerramento.GetbyParams: iDAOCaixaDiarioEncerramento;
begin
   Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL)
                    .Add('where u.nomeusuario=:nomeusuario')
                    .Params('nomeusuario', FCaixaDiarioEncerramento.Usuario.NomeUsuario)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
    begin
      FCaixaDiarioEncerramento.Id(FDataSet.FieldByName('cde.id').AsInteger);
      QuantidadeRegistro;
    end
    else
      FCaixaDiarioEncerramento.Id(0);
  end;
end;

function TDAOCaixaDiarioEncerramento.GetbyParams(aIdUsuario: Variant): iDAOCaixaDiarioEncerramento;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL)
                    .Add('where cde.idusuario=:idusuario')
                    .Params('idusuario', FCaixaDiarioEncerramento.IdUsuario)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
    begin
      FCaixaDiarioEncerramento.Id(FDataSet.FieldByName('cde.id').AsInteger);
      QuantidadeRegistro;
    end
    else
      FCaixaDiarioEncerramento.Id(0);
  end;
end;

function TDAOCaixaDiarioEncerramento.GetbyParams(aNomeUsuario: String): iDAOCaixaDiarioEncerramento;
begin
  Result := Self;
  try
   try
     FDataSet := FQuery
                   .SQL(FSQL+' where ' + FUteis.Pesquisar('u.nomeusuario', ';' + aNomeUsuario))
                   .Open
                 .DataSet;
   except
     on E: Exception do
     raise exception.Create(FMSG.MSGerroGet+E.Message);
   end;
  finally
    if not FDataSet.IsEmpty then
    begin
      FCaixaDiarioEncerramento.Id(FDataSet.FieldByName('cde.id').AsInteger);
      QuantidadeRegistro;
    end
    else
      FCaixaDiarioEncerramento.Id(0);
  end;
end;

function TDAOCaixaDiarioEncerramento.Post: iDAOCaixaDiarioEncerramento;
const
  LSQL=('insert into caixadiariomovimento( '+
                                         'idcaixadiario, '+
                                         'idusuario, '+
                                         'valorlancamento, '+
                                         'datahoraemissao, '+
                                         'observacao '+
                                       ')'+
                                         ' values '+
                                       '('+
                                         ':idcaixadiario, '+
                                         ':idusuario, '+
                                         ':valorlancamento, '+
                                         ':datahoraemissao, '+
                                         ':observacao '+
                                        ')'
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    try
      FQuery
        .SQL(LSQL)
          .Params('idcaixadiario'   , FCaixaDiarioEncerramento.IdCaixaDiario)
          .Params('idusuario'       , FCaixaDiarioEncerramento.IdUsuario)
          .Params('valorlancamento' , FCaixaDiarioEncerramento.ValorLancamento)
          .Params('datahoraemissao' , FCaixaDiarioEncerramento.DataHoraEmissao)
          .Params('observacao'      , FCaixaDiarioEncerramento.Observacao)
        .ExecSQL;
    except
      on E: Exception do
      begin
        FConexao.Rollback;
        raise Exception.Create(FMSG.MSGerroPost+E.Message);
      end;
    end;
  finally
    FConexao.Commit;
    FDataSet := FQuery
                    .SQL('select LAST_INSERT_ID () as id')
                    .Open
                    .DataSet;
    FCaixaDiarioEncerramento.Id(FDataSet.FieldByName('id').AsInteger);
  end;
end;

function TDAOCaixaDiarioEncerramento.Put: iDAOCaixaDiarioEncerramento;
const
  LSQL=('update caixadiariomovimento set '+
                                   'idcaixadiario   =:idcaixadiario, '+
                                   'idusuario       =:idusuario, '+
                                   'valorlancamento =:valorlancamento '+
                                   'observacao      =:observacao '+
                                   'where id        =:id '
       );
begin
  Result := Self;

  FConexao.StartTransaction;
  try
    try
      FQuery
        .SQL(LSQL)
          .Params('id'              , FCaixaDiarioEncerramento.Id)
          .Params('idcaixadiario'   , FCaixaDiarioEncerramento.IdCaixaDiario)
          .Params('idusuario'       , FCaixaDiarioEncerramento.IdUsuario)
          .Params('valorlancamento' , FCaixaDiarioEncerramento.ValorLancamento)
          .Params('observacao'      , FCaixaDiarioEncerramento.Observacao)
        .ExecSQL;
    except
      on E: Exception do
      begin
        FConexao.Rollback;
        raise Exception.Create(FMSG.MSGerroPut+E.Message);
      end;
    end;
  finally
    FConexao.Commit;
  end;
end;

function TDAOCaixaDiarioEncerramento.Delete: iDAOCaixaDiarioEncerramento;
const
  LSQL=('delete from caixadiariomovimento where id=:id ');
begin
   Result := self;
  FConexao.StartTransaction;
  try
    try
      FQuery.SQL(LSQL)
              .Params('id', FCaixaDiarioEncerramento.Id)
            .ExecSQL;
    except
      on E: Exception do
      begin
        FConexao.Rollback;
        raise Exception.Create(FMSG.MSGerroDelete+E.Message);
      end;
    end;
  finally
    FConexao.Commit;
  end;
end;

function TDAOCaixaDiarioEncerramento.LoopRegistro(Value: Integer): Integer;
begin
  FDataSet.First;
  try
    while not FDataSet.Eof do
    begin
      Value := Value + 1;
      FDataSet.Next;
    end;
  finally
    Result := Value;
  end;
end;

function TDAOCaixaDiarioEncerramento.QuantidadeRegistro: Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAOCaixaDiarioEncerramento.This: iEntidadeCaixaDiarioEncerramento<iDAOCaixaDiarioEncerramento>;
begin
  Result := FCaixaDiarioEncerramento;
end;

end.
