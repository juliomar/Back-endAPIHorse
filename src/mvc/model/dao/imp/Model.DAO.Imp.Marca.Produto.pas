{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 18/03/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Marca.Produto;

interface

uses
  System.SysUtils,

  Data.DB,

  Uteis,
  Uteis.Interfaces,
  Uteis.Tratar.Mensagens,

  Model.DAO.Marca.Produto.Interfaces,
  Model.Entidade.Marca.Produto.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;

type
  TDAOMarcaProduto = class(TInterfacedObject, iDAOMarcaProduto)
    private
      FMarcaProduto : iEntidadeMarcaProduto<iDAOMarcaProduto>;
      FConexao      : iConexao;
      FUteis        : iUteis;
      FMSG          : TMensagens;
      FDataSet      : TDataSet;
      FQuery        : iQuery;

   const
      FSQL=('select '+
            'mp.id, '+
            'mp.idempresa, '+
            'mp.idusuario, '+
            'mp.nomemarca, '+
            'mp.datahoraemissao, '+
            'mp.ativo '+
            'from marcaproduto mp ');
      function LoopRegistro (Value : Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOMarcaProduto;

      function DataSet(DataSource : TDataSource) : iDAOMarcaProduto; overload;
      function DataSet                           : TDataSet;         overload;
      function GetAll                            : iDAOMarcaProduto;
      function GetbyId(Id : Variant)             : iDAOMarcaProduto;
      function GetbyParams                       : iDAOMarcaProduto;
      function Post                              : iDAOMarcaProduto;
      function Put                               : iDAOMarcaProduto;
      function Delete                            : iDAOMarcaProduto;

      function QuantidadeRegistro : Integer;
      function This : iEntidadeMarcaProduto<iDAOMarcaProduto>;
  end;

implementation

uses
  Model.Entidade.Imp.Marca.Produto,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

constructor TDAOMarcaProduto.Create;
begin
  FMarcaProduto := TEntidadeMarcaProduto<iDAOMarcaProduto>.New(Self);
  FConexao      := TModelConexaoFiredacMySQL.New;
  FQuery        := TQuery.New;
  FUteis        := TUteis.New;
  FMSG          := TMensagens.Create;
end;

destructor TDAOMarcaProduto.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAOMarcaProduto.New: iDAOMarcaProduto;
begin
  Result := Self.Create;
end;

function TDAOMarcaProduto.DataSet(DataSource: TDataSource): iDAOMarcaProduto;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOMarcaProduto.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOMarcaProduto.GetAll: iDAOMarcaProduto;
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
      WriteLn('Erro no TDAOMarcaProduto.GetAll - ao tentar encontrar marcaproduto todos: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FMarcaProduto.Id(FDataSet.FieldByName('id').AsInteger)
    else
    FMarcaProduto.Id(0);
end;

function TDAOMarcaProduto.GetbyId(Id: Variant): iDAOMarcaProduto;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where mp.id=:id')
                    .Params('Id', Id)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOMarcaProduto.GetbyId - ao tentar encontrar marcaproduto por Id: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FMarcaProduto.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FMarcaProduto.Id(0);
end;

function TDAOMarcaProduto.GetbyParams: iDAOMarcaProduto;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL+' where ' + FUteis.Pesquisar('mp.nomemarca', ';' + FMarcaProduto.NomeMarca))
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOMarcaProduto.GetbyParams - ao tentar encontrar marcaproduto por nomemarca: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FMarcaProduto.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FMarcaProduto.Id(0);
end;

function TDAOMarcaProduto.Post: iDAOMarcaProduto;
const
  LSQL=('insert into marcaproduto( '+
                             'idempresa, '+
                             'idususario, '+
                             'nomemarca, '+
                             'datahoraemissao, '+
                             'ativo '+
                           ')'+
                             ' values '+
                           '( '+
                             ':idempresa, '+
                             ':idususario, '+
                             ':nomemarca, '+
                             ':datahoraemissao, '+
                             ':ativo ' +
                            ')'
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('idempresa'       , FMarcaProduto.IdEmpresa)
        .Params('idusuario'       , FMarcaProduto.IdUsuario)
        .Params('nomemarca'       , FMarcaProduto.NomeMarca)
        .Params('datahoraemissao' , FMarcaProduto.DataHoraEmissao)
        .Params('ativo'           , FMarcaProduto.Ativo)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOMarcaProduto.Post - ao tentar incluir nova marcaproduto: ' + E.Message);
      Abort;
    end;
  end;
  FConexao.Commit;
  FDataSet := FQuery
                .SQL('select LAST_INSERT_ID () as id')
                .Open
                .DataSet;
  FMarcaProduto.Id(FDataSet.FieldByName('id').AsInteger);
end;

function TDAOMarcaProduto.Put: iDAOMarcaProduto;
const
  LSQL=('update marcaproduto set '+
                     'idempresa      =:idempresa, '+
                     'idusuario      =:idusuario, '+
                     'nomemarca      =:nomemarca, '+
                     'datahoraemissao=:datahoraemissao, '+
                     'ativo          =:ativo '+
                     'where id       =:id '
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('id'              , FMarcaProduto.Id)
        .Params('idusuario'       , FMarcaProduto.IdUsuario)
        .Params('idempresa'       , FMarcaProduto.IdEmpresa)
        .Params('nomemarca'       , FMarcaProduto.NomeMarca)
        .Params('datahoraemissao' , FMarcaProduto.DataHoraEmissao)
        .Params('ativo'           , FMarcaProduto.Ativo)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOMarcaProduto.Put - ao tentar alterar marcaproduto: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOMarcaProduto.Delete: iDAOMarcaProduto;
const
  LSQL=('delete from marcaproduto where id=:id ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    FQuery.SQL(LSQL)
                 .Params('id', FMarcaProduto.Id)
               .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOMarcaProduto.Delete - ao tentar exclu�r marcaproduto: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOMarcaProduto.LoopRegistro(Value : Integer): Integer;
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

function TDAOMarcaProduto.QuantidadeRegistro : Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAOMarcaProduto.This: iEntidadeMarcaProduto<iDAOMarcaProduto>;
begin
  Result := FMarcaProduto;
end;

end.
