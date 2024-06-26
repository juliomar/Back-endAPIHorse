unit Model.DAO.Imp.Unidade.Produto;

interface

uses
  System.SysUtils,
  Data.DB,

  Uteis.Tratar.Mensagens,

  Model.DAO.Unidade.Produto.Interfaces,
  Model.Entidade.Unidade.Produto.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;

type
  TDAOUnidadeProduto = class(TInterfacedObject, iDAOUnidadeProduto)
    private
      FUnidadeProduto : iEntidadeUnidadeProduto<iDAOUnidadeProduto>;
      FConexao        : iConexao;
      FDataSet        : TDataSet;
      FQuery          : iQuery;
      FMSG            : TMensagens;

   const
      FSQL=('select '+
            'up.id, '+
            'up.unidade, '+
            'up.nomeunidade, '+
            'up.ativo '+
            'from unidadeproduto up ');
      function LoopRegistro (Value : Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOUnidadeProduto;

      function DataSet(DataSource : TDataSource) : iDAOUnidadeProduto; overload;
      function DataSet                           : TDataSet;    overload;
      function GetAll                            : iDAOUnidadeProduto;
      function GetbyId(Id : Variant)             : iDAOUnidadeProduto;
      function GetbyParams                       : iDAOUnidadeProduto;
      function Post                              : iDAOUnidadeProduto;
      function Put                               : iDAOUnidadeProduto;
      function Delete                            : iDAOUnidadeProduto;

      function QuantidadeRegistro : Integer;
      function This : iEntidadeUnidadeProduto<iDAOUnidadeProduto>;
  end;

implementation

uses
  Model.Entidade.Imp.Unidade.Produto,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;


{ TDAOUnidadeProduto }

constructor TDAOUnidadeProduto.Create;
begin
  FUnidadeProduto := TEntidadeUnidadeProduto<iDAOUnidadeProduto>.New(Self);
  FConexao        := TModelConexaoFiredacMySQL.New;
  FQuery          := TQuery.New;
  FMSG            := TMensagens.Create;
end;

destructor TDAOUnidadeProduto.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAOUnidadeProduto.New: iDAOUnidadeProduto;
begin
  Result := Self.Create;
end;

function TDAOUnidadeProduto.DataSet(DataSource: TDataSource): iDAOUnidadeProduto;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOUnidadeProduto.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOUnidadeProduto.GetAll: iDAOUnidadeProduto;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOUnidadeProduto.GetAll - ao tentar encontrar Unidadeproduto todas: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FUnidadeProduto.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FUnidadeProduto.Id(0);
end;

function TDAOUnidadeProduto.GetbyId(Id: Variant): iDAOUnidadeProduto;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL+' where up.Id=:Id')
                    .Params('Id', Id)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOUnidadeProduto.GetbyId - ao tentar encontrar Unidadeproduto por Id: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FUnidadeProduto.Id(FDataSet.FieldByName('id').AsInteger)
    else
    FUnidadeProduto.Id(0);
end;

function TDAOUnidadeProduto.GetbyParams: iDAOUnidadeProduto;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where up.unidade=:unidade')
                    .Params('unidade', FUnidadeProduto.Unidade)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOUnidadeProduto.GetbyParams - ao tentar encontrar Unidadeproduto por unidade: ' + E.Message);
      Abort;
    end;
  end;
    if not FDataSet.IsEmpty then
    begin
      FUnidadeProduto.Id(FDataSet.FieldByName('id').AsInteger);
      QuantidadeRegistro;
    end
    else
      FUnidadeProduto.Id(0);
end;

function TDAOUnidadeProduto.Post: iDAOUnidadeProduto;
const
  LSQL=('insert into unidadeproduto( '+
                             'unidade, '+
                             'nomeunidade, '+
                             'ativo '+
                           ')'+
                             ' values '+
                           '('+
                             ':unidade, '+
                             ':nomeunidade, '+
                             ':ativo '+
                            ')'
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('unidade'     , FUnidadeProduto.Unidade)
        .Params('nomeunidade' , FUnidadeProduto.NomeUnidade)
        .Params('ativo'       , FUnidadeProduto.Ativo)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOUnidadeProduto.Post - ao tentar incluir Unidadeproduto: ' + E.Message);
      Abort;
    end;
  end;
  FConexao.Commit;
  FDataSet := FQuery
                .SQL('select LAST_INSERT_ID () as id')
                .Open
                .DataSet;
  FUnidadeProduto.Id(FDataSet.FieldByName('id').AsInteger);
end;

function TDAOUnidadeProduto.Put: iDAOUnidadeProduto;
const
  LSQL=('update unidadeproduto set '+
                              'unidade    =:unidade, '+
                              'nomeunidade=:nomeunidade, '+
                              'ativo      =:ativo '+
                              'where id   =:id ');
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('id'          , FUnidadeProduto.Id)
        .Params('unidade'     , FUnidadeProduto.Unidade)
        .Params('nomeunidade' , FUnidadeProduto.NomeUnidade)
        .Params('ativo'       , FUnidadeProduto.Ativo)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOUnidadeProduto.Put - ao tentar alterar Unidadeproduto: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOUnidadeProduto.Delete: iDAOUnidadeProduto;
const
  LSQL=('delete from unidadeproduto where id=:id ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    FQuery.SQL(LSQL)
                .Params('id', FUnidadeProduto.Id)
               .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOUnidadeProduto.Delete - ao tentar exclu�r Unidadeproduto: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOUnidadeProduto.LoopRegistro(Value : Integer): Integer;
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

function TDAOUnidadeProduto.QuantidadeRegistro : Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAOUnidadeProduto.This: iEntidadeUnidadeProduto<iDAOUnidadeProduto>;
begin
  Result := FUnidadeProduto;
end;

end.
