{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 03/04/2024 16:03           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Endereco.Pessoa;

interface

uses
  Data.DB,

  System.SysUtils,

  Uteis.Tratar.Mensagens,

  Model.DAO.Endereco.Pessoa.Interfaces,
  Model.Entidade.Endereco.Pessoa.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;

type
  TDAOEnderecoPessoa = class(TInterfacedObject, iDAOEnderecoPessoa)
    private
      FEnderecoPessoa : iEntidadeEnderecoPessoa<iDAOEnderecoPessoa>;
      FConexao        : iConexao;
      FQuery          : iQuery;
      FMSG            : TMensagens;
      FDataSet        : TDataSet;

      const
        FSQL=('select '+
              'ep.id, '+
              'ep.idempresa, '+
              'ep.idendereco, '+
              'ep.idpessoa, '+
              'ed.cep, '+
              'ed.tipologradouro , '+
              'ed.logradouro, '+
              'n.numeroendereco, '+
              'n.complementoendereco, '+
              'ed.Bairro, '+
              'ed.ibge '+
              'from enderecopessoa ep '+
              'inner join endereco ed on ed.id        = ep.idendereco '+
              'inner join empresa   e on e.Id         = ep.idempresa '+
              'left  join numero    n on n.idendereco = ep.idendereco '
               );

      function LoopRegistro (Value : Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOEnderecoPessoa;

      function DataSet(DataSource : TDataSource) : iDAOEnderecoPessoa; overload;
      function DataSet                           : TDataSet;           overload;
      function GetAll                            : iDAOEnderecoPessoa;
      function GetbyId(Id : Variant)             : iDAOEnderecoPessoa; overload;
      function GetbyId(IdPessoa : Integer)       : iDAOEnderecoPessoa; overload;
      function GetbyParams                       : iDAOEnderecoPessoa; overload;
      function GetbyParams(IdEmpresa, IdEndereco, IdPessoa : Integer): iDAOEnderecoPessoa; overload;
      function Post                              : iDAOEnderecoPessoa;
      function Put                               : iDAOEnderecoPessoa;
      function Delete                            : iDAOEnderecoPessoa;

      function QuantidadeRegistro : Integer;
      function This : iEntidadeEnderecoPessoa<iDAOEnderecoPessoa>;
  end;

implementation

uses
  Model.Entidade.Imp.Endereco.Pessoa,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

{ TDAOEnderecoPessoa }

constructor TDAOEnderecoPessoa.Create;
begin
  FEnderecoPessoa := TEntidadeEnderecoPessoa<iDAOEnderecoPessoa>.New(Self);
  FConexao        := TModelConexaoFiredacMySQL.New;
  FQuery          := TQuery.New;
  FMSG            := TMensagens.Create;
end;

destructor TDAOEnderecoPessoa.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAOEnderecoPessoa.New: iDAOEnderecoPessoa;
begin
  Result := Self.Create;
end;

function TDAOEnderecoPessoa.DataSet(DataSource: TDataSource): iDAOEnderecoPessoa;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOEnderecoPessoa.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOEnderecoPessoa.GetAll: iDAOEnderecoPessoa;
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
      WriteLn('Erro no TDAOEnderecoPessoa.GetAll - ao tentar encontrar enderecopessoa todos: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FEnderecoPessoa.Id(FDataSet.FieldByName('id').AsInteger)
    else
    FEnderecoPessoa.Id(0);
end;

function TDAOEnderecoPessoa.GetbyId(Id: Variant): iDAOEnderecoPessoa;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where ep.id=:id')
                    .Params('Id', Id)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOEnderecoPessoa.GetId - ao tentar encontrar enderecopessoa por Id: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FEnderecoPessoa.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FEnderecoPessoa.Id(0);
end;

function TDAOEnderecoPessoa.GetbyId(IdPessoa: Integer): iDAOEnderecoPessoa;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where ep.idpessoa=:idpessoa')
                    .Params('idpessoa' , IdPessoa)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOEnderecoPessoa.GetId - ao tentar encontrar enderecopessoa por Idpessoa: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FEnderecoPessoa.Id(FDataSet.FieldByName('id').AsInteger)
  else
    FEnderecoPessoa.Id(0);
end;

function TDAOEnderecoPessoa.GetbyParams(IdEmpresa, IdEndereco, IdPessoa : Integer): iDAOEnderecoPessoa;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where ep.idempresa =:idempresa')
                    .Add('and   ep.idendereco=:idendereco')
                    .Add('and   ep.idpessoa  =:idpessoa')
                    .Params('idempresa'  , IdEmpresa)
                    .Params('idendereco' , IdEndereco)
                    .Params('idpessoa'   , IdPessoa)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOEnderecoPessoa.GetParams - ao tentar encontrar enderecopessoa por idempresa+idendereco+idpessoa: ' + E.Message);
      Abort;
    end;
  end;
    if not FDataSet.IsEmpty then
      FEnderecoPessoa.Id(FDataSet.FieldByName('id').AsInteger)
    else
      FEnderecoPessoa.Id(0);
end;

function TDAOEnderecoPessoa.GetbyParams: iDAOEnderecoPessoa;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where ep.idpessoa =:idpessoa')
                    .Add('and   ep.idempresa=ep.idempresa')
                    .Params('idpessoa'  , FEnderecoPessoa.Idpessoa)
                    .Add('order by ep.idpessoa asc')
                    .Add(', ep.idendereco asc')
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOEnderecoPessoa.GetId - ao tentar encontrar enderecopessoa por Idpessoa: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FEnderecoPessoa.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FEnderecoPessoa.Id(0);
end;

function TDAOEnderecoPessoa.Post: iDAOEnderecoPessoa;
const
  LSQL=('insert into enderecopessoa('+
                                    'idempresa,' +
                                    'idendereco, '+
                                    'idpessoa '+
                                    ')'+
                                    ' values '+
                                    '('+
                                    ':idempresa,' +
                                    ':idendereco, '+
                                    ':idpessoa '+
                                    ')'
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('idempresa'  , FEnderecoPessoa.IdEmpresa)
        .Params('idendereco' , FEnderecoPessoa.IdEndereco)
        .Params('idpessoa'   , FEnderecoPessoa.IdPessoa)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOEnderecoPessoa.Post - ao tentar incluir enderecopessoa: ' + E.Message);
      Abort;
    end;
  end;
  FConexao.Commit;
  FDataSet := FQuery
                .SQL('select LAST_INSERT_ID () as id')
                .Open
                .DataSet;
  FEnderecoPessoa.Id(FDataSet.FieldByName('id').AsInteger);
end;

function TDAOEnderecoPessoa.Put: iDAOEnderecoPessoa;
const
  LSQL=('update enderecopessoa set '+
                               'idempresa =:idempresa, '+
                               'idendereco=:idendereco, '+
                               'idpessoa  =:idpessoa '+
                               'where id=:id '
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('id'         , FEnderecoPessoa.Id)
        .Params('idempresa'  , FEnderecoPessoa.IdEmpresa)
        .Params('idendereco' , FEnderecoPessoa.IdEndereco)
        .Params('idpessoa'   , FEnderecoPessoa.IdPessoa)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOEnderecoPessoa.Put - ao tentar alterar enderecopessoa: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOEnderecoPessoa.Delete: iDAOEnderecoPessoa;
const
  LSQL=('delete from enderecopessoa where id=:id ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    FQuery.SQL(LSQL)
                 .Params('id', FEnderecoPessoa.Id)
               .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOEnderecoPessoa.Delete - ao tentar exclu�r enderecopessoa: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOEnderecoPessoa.LoopRegistro(Value : Integer): Integer;
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

function TDAOEnderecoPessoa.QuantidadeRegistro : Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAOEnderecoPessoa.This: iEntidadeEnderecoPessoa<iDAOEnderecoPessoa>;
begin
  Result := FEnderecoPessoa;
end;

end.
