{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 22/04/2024 14:46           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Caixa.Diario;

interface

uses
  Data.DB,
  System.SysUtils,

  Uteis.Interfaces,
  Uteis,
  Uteis.Tratar.Mensagens,


  Model.DAO.Caixa.Diario.Interfaces,
  Model.Entidade.Caixa.Diario.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;
type
  TDAOCaixaDiario = class(TInterfacedObject, iDAOCaixaDiario)
    private
      FCaixaDiario : iEntidadeCaixaDiario<iDAOCaixaDiario>;
      FConexao     : iConexao;
      FDataSet     : TDataSet;
      FQuery       : iQuery;
      FUteis       : iUteis;
      FMSG         : TMensagens;

    const
      FSQL=('select '+
            'cd.id, '+
            'cd.idempresa, '+
            'cd.idusuario, '+
            'u.nomeusuario, '+
            'cd.valorinicial, '+
            'cd.datahoraemissao, '+
            'cd.status '+
            'from caixadiario cd '+
            'inner join usuario u on u.id =cd.idusuario '
            );
      function LoopRegistro(Value : Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOCaixaDiario;

      function DataSet    (DataSource : TDataSource) : iDAOCaixaDiario; overload;
      function DataSet                               : TDataSet;        overload;
      function GetAll                                : iDAOCaixaDiario;
      function GetbyId    (Id : Variant)             : iDAOCaixaDiario;
      function GetbyParams                           : iDAOCaixaDiario; overload;
      function GetbyParams(aIdUsuario : Variant)     : iDAOCaixaDiario; overload;
      function GetbyParams(aNomeUsuario : String)    : iDAOCaixaDiario; overload;
      function Post                                  : iDAOCaixaDiario;
      function Put                                   : iDAOCaixaDiario;
      function Delete                                : iDAOCaixaDiario;
      function QuantidadeRegistro                    : Integer;

      function This : iEntidadeCaixaDiario<iDAOCaixaDiario>;
  end;

implementation

uses
  Model.Entidade.Imp.Caixa.Diario,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

{ TDAOCaixaDiario }

constructor TDAOCaixaDiario.Create;
begin
  FCaixaDiario := TEntidadeCaixaDiario<iDAOCaixaDiario>.New(Self);
  FConexao     := TModelConexaoFiredacMySQL.New;
  FQuery       := TQuery.New;
  FUteis       := TUteis.New;
  FMSG         := TMensagens.Create;
end;

destructor TDAOCaixaDiario.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAOCaixaDiario.New: iDAOCaixaDiario;
begin
  Result := Self.Create;
end;

function TDAOCaixaDiario.DataSet(DataSource: TDataSource): iDAOCaixaDiario;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOCaixaDiario.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOCaixaDiario.GetAll: iDAOCaixaDiario;
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
      FCaixaDiario.Id(FDataSet.FieldByName('cd.id').AsInteger);
      QuantidadeRegistro;
    end
    else
      FCaixaDiario.Id(0);
  end;
end;

function TDAOCaixaDiario.GetbyId(Id: Variant): iDAOCaixaDiario;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL+' where cd.Id=:Id')
                    .Params('Id', Id)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
      FCaixaDiario.Id(FDataSet.FieldByName('cd.id').AsInteger)
    else
      FCaixaDiario.Id(0);
  end;
end;

function TDAOCaixaDiario.GetbyParams: iDAOCaixaDiario;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL)
                    .Add('where u.nomeusuario=:nomeusuario')
                    .Params('nomeusuario', FCaixaDiario.Usuario.NomeUsuario)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
    begin
      FCaixaDiario.Id(FDataSet.FieldByName('cd.id').AsInteger);
      QuantidadeRegistro;
    end
    else
      FCaixaDiario.Id(0);
  end;
end;

function TDAOCaixaDiario.GetbyParams(aIdUsuario: Variant): iDAOCaixaDiario;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL)
                    .Add('where cd.idusuario=:idusuario')
                    .Params('idusuario', FCaixaDiario.IdUsuario)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
    begin
      FCaixaDiario.Id(FDataSet.FieldByName('up.id').AsInteger);
      QuantidadeRegistro;
    end
    else
      FCaixaDiario.Id(0);
  end;
end;

function TDAOCaixaDiario.GetbyParams(aNomeUsuario: String): iDAOCaixaDiario;
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
      FCaixaDiario.Id(FDataSet.FieldByName('cd.id').AsInteger);
      QuantidadeRegistro;
    end
    else
      FCaixaDiario.Id(0);
  end;
end;

function TDAOCaixaDiario.Post: iDAOCaixaDiario;
const
  LSQL=('insert into caixadiario( '+
                             'idempresa, '+
                             'idusuario, '+
                             'valorinicial, '+
                             'datahoraemissao, '+
                             'status '+
                           ')'+
                             ' values '+
                           '('+
                             ':idempresa, '+
                             ':idusuario, '+
                             ':valorinicial, '+
                             ':datahoraemissao, '+
                             ':status '+
                            ')'
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    try
      FQuery
        .SQL(LSQL)
          .Params('idempresa'       , FCaixaDiario.IdEmpresa)
          .Params('idusuario'       , FCaixaDiario.IdUsuario)
          .Params('valorinicial'    , FCaixaDiario.ValorInicial)
          .Params('datahoraemissao' , FCaixaDiario.DataHoraEmissao)
          .Params('status'          , FCaixaDiario.Status)
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
    FCaixaDiario.Id(FDataSet.FieldByName('id').AsInteger);
  end;
end;

function TDAOCaixaDiario.Put: iDAOCaixaDiario;
const
  LSQL=('update caixadiario set '+
                           'idempresa      =:unidade, '+
                           'idusuario      =:idusuario, '+
                           'valorinicial   =:valorinicial, '+
                           'datahoraemissao=:datahoraemissao, '+
                           'status         =:status '+
                           'where id       =:id '
       );
begin
  Result := Self;

  FConexao.StartTransaction;
  try
    try
      FQuery
        .SQL(LSQL)
          .Params('id'              , FCaixaDiario.Id)
          .Params('idempresa'       , FCaixaDiario.IdEmpresa)
          .Params('idusuario'       , FCaixaDiario.IdUsuario)
          .Params('valorinicial'    , FCaixaDiario.ValorInicial)
          .Params('datahoraemissao' , FCaixaDiario.DataHoraEmissao)
          .Params('status'          , FCaixaDiario.Status)
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

function TDAOCaixaDiario.Delete: iDAOCaixaDiario;
const
  LSQL=('delete from caixadiario where id=:id ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    try
      FQuery.SQL(LSQL)
              .Params('id', FCaixaDiario.Id)
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

function TDAOCaixaDiario.LoopRegistro(Value: Integer): Integer;
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

function TDAOCaixaDiario.QuantidadeRegistro: Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAOCaixaDiario.This: iEntidadeCaixaDiario<iDAOCaixaDiario>;
begin
  Result := FCaixaDiario;
end;

end.
