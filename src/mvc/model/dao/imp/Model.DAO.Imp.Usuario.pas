{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 13/03/2024 10:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Usuario;

interface

uses
  System.SysUtils,
  Data.DB,
  FireDAC.Comp.Client,

  Uteis.Tratar.Mensagens,

  Model.DAO.Usuario.Interfaces,
  Model.Entidade.Usuario.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;

type
  TDAOUsuario = class(TInterfacedObject, iDAOUsuario)
    private
      FUsuario : iEntidadeUsuario<iDAOUsuario>;
      FConexao : iConexao;
      FQuery   : iQuery;
      FMSG     : TMensagens;

      FDataSet : TDataSet;
   const
      FSQL=('select '+
            'u.id, '+
            'u.idempresa, '+
            'u.nomeusuario, '+
            'u.email, '+
            'u.senha, '+
            'u.datahoraemissao, '+
            'u.ativo '+
            'from usuario u ');
      function LoopRegistro (Value : Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOUsuario;

      function DataSet(DataSource : TDataSource) : iDAOUsuario; overload;
      function DataSet                           : TDataSet;    overload;
      function GetAll                            : iDAOUsuario;
      function GetbyId(Id : Variant)             : iDAOUsuario;
      function GetbyParams                       : iDAOUsuario;
      function Post                              : iDAOUsuario;
      function Put                               : iDAOUsuario;
      function Delete                            : iDAOUsuario;

      function QuantidadeRegistro : Integer;
      function This : iEntidadeUsuario<iDAOUsuario>;
  end;

implementation

uses
  Model.Entidade.Imp.Usuario,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

{ TDAOUsuario }

constructor TDAOUsuario.Create;
begin
  FUsuario := TEntidadeUsuario<iDAOUsuario>.New(Self);
  FConexao := TModelConexaoFiredacMySQL.New;
  FQuery   := TQuery.New;
  FMSG     := TMensagens.Create;
end;

destructor TDAOUsuario.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAOUsuario.New: iDAOUsuario;
begin
  Result := Self.Create;
end;

function TDAOUsuario.DataSet(DataSource: TDataSource): iDAOUsuario;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOUsuario.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOUsuario.GetAll: iDAOUsuario;
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
      WriteLn('Erro no TDAOUsuario.GetAll - ao tentar encontrar usuario todos: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FUsuario.Id(FDataSet.FieldByName('id').AsInteger)
    else
    FUsuario.Id(0);
end;

function TDAOUsuario.GetbyId(Id: Variant): iDAOUsuario;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where u.Id=:Id ')
                    .Params('Id', Id)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOUsuario.GetbyId - ao tentar encontrar usuario por Id: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FUsuario.Id(FDataSet.FieldByName('id').AsInteger)
    else
    FUsuario.Id(0);
end;

function TDAOUsuario.GetbyParams: iDAOUsuario;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL+' where ((lower(email) like lower(:email) and (senha=:senha))) ')
                    .Params('email', FUsuario.EMail)
                    .Params('senha', FUsuario.Senha)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOUsuario.GetbyParams - ao tentar encontrar usuario email+senha: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FUsuario.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FUsuario.Id(0);
end;

function TDAOUsuario.Post: iDAOUsuario;
const
  LSQL=('insert into usuario( '+
                             'idempresa, '+
                             'nomeusuario, '+
                             'email, '+
                             'senha, '+
                             'datahoraemissao, '+
                             'ativo '+
                           ')'+
                             ' values '+
                           '('+
                             ':idempresa, '+
                             ':nomeusuario, '+
                             ':email, '+
                             ':senha, '+
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
        .Params('idempresa'       , FUsuario.IdEmpresa)
        .Params('nomeusuario'     , FUsuario.NomeUsuario)
        .Params('email'           , FUsuario.EMail)
        .Params('senha'           , FUsuario.Senha)
        .Params('datahoraemissao' , FUsuario.DataHoraEmissao)
        .Params('ativo'           , FUsuario.Ativo)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOUsuario.Post - ao tentar incluir usuario: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
    FDataSet := FQuery
                    .SQL('select LAST_INSERT_ID () as id')
                    .Open
                    .DataSet;
    FUsuario.Id(FDataSet.FieldByName('id').AsInteger);
end;

function TDAOUsuario.Put: iDAOUsuario;
const
  LSQL=('update usuario set '+
                'idempresa      =:idempresa, '+
                'nomeusuario    =:nomeusuario, '+
                'email          =:email, '+
                'senha          =:senha, '+
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
        .Params('id'              , FUsuario.Id)
        .Params('idempresa'       , FUsuario.IdEmpresa)
        .Params('nomeusuario'     , FUsuario.NomeUsuario)
        .Params('email'           , FUsuario.EMail)
        .Params('senha'           , FUsuario.Senha)
        .Params('datahoraemissao' , FUsuario.DataHoraEmissao)
        .Params('ativo'           , FUsuario.Ativo)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOUsuario.Put - ao tentar alterar usuario: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOUsuario.Delete: iDAOUsuario;
const
  LSQL=('delete from usuario where id=:id ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    FQuery.SQL(LSQL)
                 .Params('id', FUsuario.Id)
               .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOUsuario.Delete - ao tentar exclu�r usuario: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOUsuario.LoopRegistro(Value : Integer): Integer;
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

function TDAOUsuario.QuantidadeRegistro : Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAOUsuario.This: iEntidadeUsuario<iDAOUsuario>;
begin
  Result := FUsuario;
end;

end.
