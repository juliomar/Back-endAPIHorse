{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 26/04/2024 12:56           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Movimento.Pedido;

interface

uses
  Data.DB,
  Uteis.Tratar.Mensagens,
  System.SysUtils,

  Model.DAO.Movimento.Pedido.Interfaces,
  Model.Entidade.Movimento.Pedido.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;

type
  TDAOMovimentoPedido = class(TInterfacedObject, iDAOMovimentoPedido)
    private
      FMovimentoPedido : iEntidadeMovimentoPedido<iDAOMovimentoPedido>;
      FConexao : iConexao;
      FQuery   : iQuery;
      FMSG     : TMensagens;

      FDataSet : TDataSet;
   const
      FSQL=('select '+
            'mp.id, '+
            'mp.idempresa, '+
            'mp.idpedido, '+
            'p1.nomepessoa, '+
            'p.datahoraemissao, '+
            'p.valorproduto, '+
            'p.valordesconto, '+
            'p.valorreceber, '+
            'p.idusuario as idusuariopedido, '+
            'mp.idusuario, '+
            'mp.datahoraemissao, '+
            'mp.status, '+
            'case '+
            '  when mp.status = 0 then ''Pedido inserido'' '+
            '  when mp.status = 1 then ''Pedido alterado'' '+
            '  when mp.status = 2 then ''Pedido cancelad'' '+
            '  when mp.status = 3 then ''Pedido exclu�do'' '+
            'end tipomovimento '+
            'from movimentopedido mp '+
            'inner join empresa e on mp.idempresa = e.Id '+
            'inner join usuario u on mp.idusuario = u.id '+
            'inner join pedido  p on mp.idpedido  = p.id  '+
            'inner join pessoa p1 on p.idpessoa  = p1.id '
           );
      function LoopRegistro (Value : Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOMovimentoPedido;

      function DataSet(DataSource : TDataSource) : iDAOMovimentoPedido; overload;
      function DataSet                           : TDataSet;            overload;
      function GetAll                            : iDAOMovimentoPedido;
      function GetbyId(Id : Variant)             : iDAOMovimentoPedido; overload;
      function GetbyId(IdPedido : Integer)       : iDAOMovimentoPedido; overload;
      function GetbyParams                       : iDAOMovimentoPedido;
      function Post                              : iDAOMovimentoPedido;
      function Put                               : iDAOMovimentoPedido;
      function Delete                            : iDAOMovimentoPedido;

      function QuantidadeRegistro : Integer;
      function This : iEntidadeMovimentoPedido<iDAOMovimentoPedido>;
  end;

implementation

uses
  Model.Entidade.Imp.Movimento.Pedido,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

{ TDAOMovimentoPedido }

constructor TDAOMovimentoPedido.Create;
begin
  FMovimentoPedido := TEntidadeMovimentoPedido<iDAOMovimentoPedido>.New(Self);
  FConexao := TModelConexaoFiredacMySQL.New;
  FQuery   := TQuery.New;
  FMSG     := TMensagens.Create;
end;

destructor TDAOMovimentoPedido.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAOMovimentoPedido.New: iDAOMovimentoPedido;
begin
  Result := Self.Create;
end;

function TDAOMovimentoPedido.DataSet(DataSource: TDataSource): iDAOMovimentoPedido;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOMovimentoPedido.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOMovimentoPedido.GetAll: iDAOMovimentoPedido;
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
      WriteLn('Erro no TDAOMovimentoPedido.GetAll - ao tentar encontrar movimentopedido: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FMovimentoPedido.Id(FDataSet.FieldByName('id').AsInteger)
  else
    FMovimentoPedido.Id(0);
end;

function TDAOMovimentoPedido.GetbyId(Id: Variant): iDAOMovimentoPedido;
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
      WriteLn('Erro no TDAOMovimentoPedido.GetbyId - ao tentar encontrar movimentopedido por Id: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FMovimentoPedido.Id(FDataSet.FieldByName('id').AsInteger)
    else
    FMovimentoPedido.Id(0);
end;

function TDAOMovimentoPedido.GetbyId(IdPedido: Integer): iDAOMovimentoPedido;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where mp.idpedido=:idpedido')
                    .Params('idpedido', IdPedido)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOMovimentoPedido.GetbyId - ao tentar encontrar movimentopedido por Idpedido: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FMovimentoPedido.Id(FDataSet.FieldByName('idpedido').AsInteger);
    QuantidadeRegistro;
  end
  else
    FMovimentoPedido.Id(0);
end;

function TDAOMovimentoPedido.GetbyParams: iDAOMovimentoPedido;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL+' where ((lower(p1.nomepessoa) like lower(:nomepessoa)) ')
                    .Params('nomepessoa', FMovimentoPedido.Pessoa.NomePessoa)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOMovimentoPedido.GetbyParams - ao tentar encontrar movimentopedido por nomepessoa: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FMovimentoPedido.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FMovimentoPedido.Id(0);
end;

function TDAOMovimentoPedido.Post: iDAOMovimentoPedido;
const
  LSQL=('insert into movimento( '+
                               'idempresa, '+
                               'idpedido, '+
                               'idusuario, '+
                               'datahoraemissao, '+
                               'status '+
                              ')'+
                               ' values '+
                              '('+
                               ':idempresa, '+
                               ':idpedido, '+
                               ':idusuario, '+
                               ':datahoraemissao, '+
                               ':status '+
                              ')'
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('idempresa'       , FMovimentoPedido.IdEmpresa)
        .Params('idpedido'        , FMovimentoPedido.IdPedido)
        .Params('idusuario'       , FMovimentoPedido.IdUsuario)
        .Params('datahoraemissao' , FMovimentoPedido.DataHoraEmissao)
        .Params('status'          , FMovimentoPedido.Status)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOMovimentoPedido.Post - ao tentar incluir novo movimentopedido: ' + E.Message);
      Abort;
    end;
  end;
  FConexao.Commit;
  FDataSet := FQuery
                .SQL('select LAST_INSERT_ID () as id')
                .Open
                .DataSet;
  FMovimentoPedido.Id(FDataSet.FieldByName('id').AsInteger);
end;

function TDAOMovimentoPedido.Put: iDAOMovimentoPedido;
begin
//n�o vai ter
end;

function TDAOMovimentoPedido.Delete: iDAOMovimentoPedido;
begin
//n�o vai ter
end;

function TDAOMovimentoPedido.LoopRegistro(Value: Integer): Integer;
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

function TDAOMovimentoPedido.QuantidadeRegistro: Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAOMovimentoPedido.This: iEntidadeMovimentoPedido<iDAOMovimentoPedido>;
begin
  Result := FMovimentoPedido;
end;

end.
