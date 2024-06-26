{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 03/04/2024 16:03           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Email.Pessoa;

interface

uses
  Data.DB,

  System.SysUtils,


  Uteis.Tratar.Mensagens,
  Model.DAO.Email.Pessoa.Interfaces,
  Model.Entidade.Email.Pessoa.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;

type
  TDAOEmailPessoa = class(TInterfacedObject, iDAOEmailPessoa)
    private
      FEmailPessoa : iEntidadeEmailPessoa<iDAOEmailPessoa>;
      FConexao     : iConexao;
      FQuery       : iQuery;
      FMSG         : TMensagens;
      FDataSet     : TDataSet;

      const
        FSQL=('select '+
              'ep.id, '+
              'ep.idempresa, '+
              'ep.idpessoa, '+
              'ep.email, '+
              'ep.tipoemail, '+
              'ep.ativo '+
              'from emailpessoa ep '
              );
      function LoopRegistro (Value : Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOEmailPessoa;
      function DataSet(DataSource : TDataSource) : iDAOEmailPessoa; overload;
      function DataSet                           : TDataSet;        overload;
      function GetAll                            : iDAOEmailPessoa;
      function GetbyId(Id : Variant)             : iDAOEmailPessoa; overload;
      function GetbyId(IdEmpresa : Integer)      : iDAOEmailPessoa; overload;
      function GetbyParams                       : iDAOEmailPessoa;
      function Post                              : iDAOEmailPessoa;
      function Put                               : iDAOEmailPessoa;
      function Delete                            : iDAOEmailPessoa;

      function QuantidadeRegistro : Integer;
      function This : iEntidadeEmailPessoa<iDAOEmailPessoa>;
  end;

implementation

uses
  Model.Entidade.Imp.Email.Pessoa,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

{ TDAOEmailPessoa }

constructor TDAOEmailPessoa.Create;
begin
  FEmailPessoa := TEntidadeEmailPessoa<iDAOEmailPessoa>.New(Self);
  FConexao     := TModelConexaoFiredacMySQL.New;
  FQuery       := TQuery.New;
  FMSG         := TMensagens.Create;
end;

destructor TDAOEmailPessoa.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAOEmailPessoa.New: iDAOEmailPessoa;
begin
  Result := Self.Create;
end;

function TDAOEmailPessoa.DataSet(DataSource: TDataSource): iDAOEmailPessoa;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOEmailPessoa.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOEmailPessoa.GetAll: iDAOEmailPessoa;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Open
                  .DataSet;
  except
      on E:Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
  end;
  if not FDataSet.IsEmpty then
  begin
    FEmailPessoa.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FEmailPessoa.Id(0);
end;

function TDAOEmailPessoa.GetbyId(Id: Variant): iDAOEmailPessoa;
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
      WriteLn('Erro no TDAOEmailPessoa.GetbyId - ao tentar encontrar emailpessoa por Id: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FEmailPessoa.Id(FDataSet.FieldByName('id').AsInteger)
    else
    FEmailPessoa.Id(0);
end;

function TDAOEmailPessoa.GetbyId(IdEmpresa: Integer): iDAOEmailPessoa;
begin
    Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where ep.idempresa=:idempresa')
                    .Params('idempresa' , IdEmpresa)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOEmailPessoa.GetbyId - ao tentar encontrar emailpessoa por idempresa: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FEmailPessoa.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FEmailPessoa.Id(0);
end;

function TDAOEmailPessoa.GetbyParams: iDAOEmailPessoa;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where ep.idempresa=:idempresa')
                    .Add('and ee.email=:email')
                    .Params('idempresa' , FEmailPessoa.IdEmpresa)
                    .Params('email'     , FEmailPessoa.Email)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOEmailPessoa.GetbyParams - ao tentar encontrar emailpessoa idempresa+email: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FEmailPessoa.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
     FEmailPessoa.Id(0);
end;

function TDAOEmailPessoa.Post: iDAOEmailPessoa;
const
  LSQL=('insert into emailpessoa('+
                                 'idempresa,' +
                                 'idpessoa, '+
                                 'email, '+
                                 'tipoemail, '+
                                 'ativo '+
                                 ')'+
                                 ' values '+
                                 '('+
                                 ':idempresa,' +
                                 ':idpessoa, '+
                                 ':email, '+
                                 ':tipoemail, '+
                                 ':ativo '+
                                 ')'
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('idempresa' , FEmailPessoa.IdEmpresa)
        .Params('idpessoa'  , FEmailPessoa.IdPessoa)
        .Params('email'     , FEmailPessoa.Email)
        .Params('tipoemail' , FEmailPessoa.TipoEmail)
        .Params('ativo'     , FEmailPessoa.Ativo)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOEmailPessoa.Post - ao tentar incluir emailpessoa: ' + E.Message);
      Abort;
    end;
  end;
  FConexao.Commit;
  FDataSet := FQuery
                .SQL('select LAST_INSERT_ID () as id')
                  .Open
                .DataSet;
  FEmailPessoa.Id(FDataSet.FieldByName('id').AsInteger);
end;

function TDAOEmailPessoa.Put: iDAOEmailPessoa;
const
  LSQL=('update emailpessoa set '+
                               'idempresa =:idempresa, '+
                               'idpessoa  =:idpessoa, '+
                               'email     =:email, '+
                               'tipoemail =:tipoemail '+
                               'ativo     =:ativo '+
                               'where   id=:id '
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('id'        , FEmailPessoa.Id)
        .Params('idempresa' , FEmailPessoa.IdEmpresa)
        .Params('idpessoa'  , FEmailPessoa.IdPessoa)
        .Params('email'     , FEmailPessoa.Email)
        .Params('tipoemail' , FEmailPessoa.TipoEmail)
        .Params('ativo'     , FEmailPessoa.Ativo)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOEmailPessoa.Put - ao tentar alterar emailpessoa: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOEmailPessoa.Delete: iDAOEmailPessoa;
const
  LSQL=('delete from emailpessoa where id=:id ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    FQuery.SQL(LSQL)
                 .Params('id', FEmailPessoa.Id)
               .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOEmailPessoa.Delete - ao tentar exclu�r emailpessoa: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOEmailPessoa.LoopRegistro(Value : Integer): Integer;
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

function TDAOEmailPessoa.QuantidadeRegistro : Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAOEmailPessoa.This: iEntidadeEmailPessoa<iDAOEmailPessoa>;
begin
  Result := FEmailPessoa;
end;

end.
