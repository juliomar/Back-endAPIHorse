{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 15/04/2024 15:37           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Natureza.Juridica;

interface

uses
  System.SysUtils,
  Data.DB,

  FireDAC.Comp.Client,

  Uteis.Tratar.Mensagens,

  Model.DAO.Natureza.Juridica.Interfaces,
  Model.Entidade.Natureza.Juridica.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;

type
  TDAONaturezaJuridica = class(TInterfacedObject, iDAONaturezaJuridica)
    private
      FNaturezaJuridica : iEntidadeNaturezaJuridica<iDAONaturezaJuridica>;
      FConexao          : iConexao;
      FQuery            : iQuery;
      FMSG              : TMensagens;

      FDataSet : TDataSet;
   const
      FSQL=('select '+
            'nj.id, '+
            'nj.nomenaturezajuridica '+
            'from naturezajuridica nj ');

      function LoopRegistro (Value : Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAONaturezaJuridica;

      function DataSet(DataSource : TDataSource) : iDAONaturezaJuridica; overload;
      function DataSet                           : TDataSet;             overload;
      function GetAll                            : iDAONaturezaJuridica;
      function GetbyId(Id : Variant)             : iDAONaturezaJuridica;
      function GetbyParams                       : iDAONaturezaJuridica;
      function Post                              : iDAONaturezaJuridica;
      function Put                               : iDAONaturezaJuridica;
      function Delete                            : iDAONaturezaJuridica;

      function QuantidadeRegistro : Integer;
      function This : iEntidadeNaturezaJuridica<iDAONaturezaJuridica>;
  end;

implementation

uses
  Model.Entidade.Imp.Natureza.Juridica,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

{ TDAOUsuario }

constructor TDAONaturezaJuridica.Create;
begin
  FNaturezaJuridica := TEntidadeNaturezaJuridica<iDAONaturezaJuridica>.New(Self);
  FConexao          := TModelConexaoFiredacMySQL.New;
  FQuery            := TQuery.New;
  FMSG              := TMensagens.Create;
end;

destructor TDAONaturezaJuridica.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAONaturezaJuridica.New: iDAONaturezaJuridica;
begin
  Result := Self.Create;
end;

function TDAONaturezaJuridica.DataSet(DataSource: TDataSource): iDAONaturezaJuridica;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAONaturezaJuridica.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAONaturezaJuridica.GetAll: iDAONaturezaJuridica;
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
      WriteLn('Erro no TDAONaturezaJuridica.GetAll - ao tentar encontrar naturezajuridica: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FNaturezaJuridica.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FNaturezaJuridica.Id(0);
end;

function TDAONaturezaJuridica.GetbyId(Id: Variant): iDAONaturezaJuridica;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where Id=:Id')
                    .Params('Id', Id)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAONaturezaJuridica.GetbyId - ao tentar encontrar naturezajuridica por Id: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FNaturezaJuridica.Id(FDataSet.FieldByName('id').AsInteger)
    else
    FNaturezaJuridica.Id(0);
end;

function TDAONaturezaJuridica.GetbyParams: iDAONaturezaJuridica;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL+' where ((lower(nomenaturezajuridica) like lower(:nomenaturezajuridica)) ')
                    .Params('nomenaturezajuridica', FNaturezaJuridica.NomeNaturezaJuridica)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAONaturezaJuridica.GetbyParams - ao tentar encontrar naturezajuridica por nomenatureza: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FNaturezaJuridica.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FNaturezaJuridica.Id(0);
end;

function TDAONaturezaJuridica.Post: iDAONaturezaJuridica;
const
  LSQL=('insert into usuario('+
                             'nomenaturezajuridica '+
                           ')'+
                             ' values '+
                           '('+
                             ':nomenaturezajuridica '+
                            ')'
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('nomenaturezajuridica' , FNaturezaJuridica.NomeNaturezaJuridica)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAONaturezaJuridica.Post - ao tentar incluir naturezajuridica: ' + E.Message);
      Abort;
    end;
  end;
  FConexao.Commit;
  FDataSet := FQuery
                .SQL('select LAST_INSERT_ID () as id')
                .Open
                .DataSet;
  FNaturezaJuridica.Id(FDataSet.FieldByName('id').AsInteger);
end;

function TDAONaturezaJuridica.Put: iDAONaturezaJuridica;
const
  LSQL=('update usuario set '+
                        'naturezajuridica=:naturezajuridica '+
                        'where id=:id '
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('id'                   , FNaturezaJuridica.Id)
        .Params('nomenaturezajuridica' , FNaturezaJuridica.NomeNaturezaJuridica)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAONaturezaJuridica.Put - ao tentar alterar naturezajuridica: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAONaturezaJuridica.Delete: iDAONaturezaJuridica;
const
  LSQL=('delete from naturezajuridica where id=:id ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    FQuery.SQL(LSQL)
                 .Params('id', FNaturezaJuridica.Id)
               .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAONaturezaJuridica.Delete - ao tentar exclu�r naturezajuridica: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAONaturezaJuridica.LoopRegistro(Value : Integer): Integer;
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

function TDAONaturezaJuridica.QuantidadeRegistro : Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAONaturezaJuridica.This: iEntidadeNaturezaJuridica<iDAONaturezaJuridica>;
begin
  Result := FNaturezaJuridica;
end;

end.
