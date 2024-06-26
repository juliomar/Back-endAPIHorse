{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 19/03/2024 22:59           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Produto;

interface

uses
  System.SysUtils,

  Data.DB,

  Uteis,
  Uteis.Interfaces,
  Uteis.Tratar.Mensagens,

  Model.DAO.Produto.Interfaces,
  Model.Entidade.Produto.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;

Type
  TDAOProduto = class(TInterfacedObject, iDAOProduto)
    private
      FProduto : iEntidadeProduto<iDAOProduto>;
      FConexao : iConexao;
      FQuery   : iQuery;
      FUteis   : iUteis;
      FMSG     : TMensagens;

      FDataSet : TDataSet;

      FKey     : String;
      FValue   : String;
   const
      FSQL=('select '+
            'pro.id, '+
            'pro.idempresa, '+
            'pro.idusuario, '+
            'pro.idcategoria, '+
            'cp.nomecategoria, '+
            'pro.idunidade, '+
            'up.unidade, '+
            'pro.gtin, '+
            'pro.ceantrib, '+
            'pro.cean, '+
            'pro.nomeproduto, '+
            'pro.ncm, '+
            'pro.valorcusto, '+
            'pro.aliquotalucro, '+
            'pro.valorvendagelado, '+
            'pro.valorvendanatural, '+
            'pro.valorvendapromocional, '+
            'pro.estoqueanterior, '+
            'pro.estoquemaximo, '+
            'pro.estoqueminimo, '+
            'pro.estoqueatual, '+
            'pro.origem, '+
            'pro.volume, '+
            'pro.quantidadeembalagem, '+
            'pro.balanca, '+
            'pro.pesoliquido, '+
            'pro.pesobruto, '+
            'pro.datahoraemissao, '+
            'pro.ativo '+
            'from produto pro '+
            'inner join categoriaproduto cp on cp.id = pro.idcategoria '+
            'inner join unidadeproduto   up on up.id = pro.idunidade '
            );


      procedure FiltroKey;
      function  FiltroValue(Value : String) : String;
      function LoopRegistro (Value : Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOProduto;

      function DataSet(DataSource : TDataSource) : iDAOProduto; overload;
      function DataSet                           : TDataSet;    overload;
      function GetAll                            : iDAOProduto;
      function GetbyId(Id : Variant)             : iDAOProduto;
      function GetbyParams                       : iDAOProduto;
      function Post                              : iDAOProduto;
      function Put                               : iDAOProduto;
      function Delete                            : iDAOProduto;

      function QuantidadeRegistro : Integer;
      function This : iEntidadeProduto<iDAOProduto>;
  end;

implementation

uses
  Model.Entidade.Imp.Produto,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

{ TDAOProduto }

constructor TDAOProduto.Create;
begin
  FProduto := TEntidadeProduto<iDAOProduto>.New(Self);
  FConexao := TModelConexaoFiredacMySQL.New;
  FQuery   := TQuery.New;
  FUteis   := TUteis.New;
  FMSG     := TMensagens.Create;
end;

destructor TDAOProduto.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAOProduto.New: iDAOProduto;
begin
  Result := Self.Create;
end;

procedure TDAOProduto.FiltroKey;
begin
  if FProduto.NomeProduto <>'' then FKey := 'pro.nomeproduto'     else
  if FProduto.Gtin        <>'' then FKey := 'pro.gtin'     else
  if FProduto.cEanTrib    <>'' then FKey := 'pro.ceantrib' else
  if FProduto.cEan        <>'' then FKey := 'pro.cean';

  FValue := FiltroValue(FKey);
end;

function TDAOProduto.FiltroValue(Value: String): String;
begin
  Result := '';
  if Value ='pro.nomeproduto' then Result := FProduto.NomeProduto else
  if Value ='pro.gtin'        then Result := FProduto.Gtin        else
  if Value ='pro.ceantrib'    then Result := FProduto.cEanTrib    else
  if Value ='pro.cean'        then Result := FProduto.cEan;
end;

function TDAOProduto.DataSet(DataSource: TDataSource): iDAOProduto;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOProduto.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOProduto.GetAll: iDAOProduto;
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
      WriteLn('Erro no TDAOProduto.GetAll - ao tentar encontrar produto todos: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FProduto.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FProduto.Id(0);
end;

function TDAOProduto.GetbyId(Id: Variant): iDAOProduto;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where pro.Id=:Id')
                    .Params('Id', Id)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOProduto.GetbyId - ao tentar encontrar produto por Id: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FProduto.Id(FDataSet.FieldByName('id').AsInteger)
    else
    FProduto.Id(0);
end;

function TDAOProduto.GetbyParams: iDAOProduto;
begin
  Result := Self;
  FiltroKey;
  try
    FDataSet := FQuery
                  .SQL(FSQL +' where ' + FUteis.Pesquisar(FKey, ';' + FValue))
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOProduto.GetbyParams - ao tentar encontrar produto por FKey+FValue: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FProduto.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FProduto.Id(0);
end;

function TDAOProduto.Post: iDAOProduto;
const
  LSQL=('insert into produto(idempresa, '+
                             'idusuario, '+
                             'idcategoria, '+
                             'idunidade, '+
                             'gtin, '+
                             'ceantrib, '+
                             'cean, '+
                             'nomeproduto, '+
                             'ncm, '+
                             'valorcusto, '+
                             'aliquotalucro, '+
                             'valorvendagelado, '+
                             'valorvendanatural, '+
                             'valorvendapromocional, '+
                             'estoqueanterior, '+
                             'estoquemaximo, '+
                             'estoqueminimo, '+
                             'estoqueatual, '+
                             'origem, '+
                             'volume, '+
                             'quantidadeembalagem, '+
                             'balanca, '+
                             'pesoliquido, '+
                             'pesobruto, '+
                             'datahoraemissao, '+
                             'ativo '+
                            ')'+
                             ' values '+
                            '('+
                             ':idempresa, '+
                             ':idusuario, '+
                             ':idcategoria, '+
                             ':idunidade, '+
                             ':gtin, '+
                             ':ceantrib, '+
                             ':cean, '+
                             ':nomeproduto, '+
                             ':ncm, '+
                             ':valorcusto, '+
                             ':aliquotalucro, '+
                             ':valorvendagelado, '+
                             ':valorvendanatural, '+
                             ':valorvendapromocional, '+
                             ':estoqueanterior, '+
                             ':estoquemaximo, '+
                             ':estoqueminimo, '+
                             ':estoqueatual, '+
                             ':origem, '+
                             ':volume, '+
                             ':quantidadeembalagem, '+
                             ':balanca, '+
                             ':pesoliquido, '+
                             ':pesobruto, '+
                             ':datahoraemissao, '+
                             ':ativo '+
                            ')'
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('idempresa'             , FProduto.IdEmpresa)
        .Params('idusuario'             , FProduto.IdUsuario)
        .Params('idcategoria'           , FProduto.IdCategoria)
        .Params('idunidade'             , FProduto.IdUnidade)
        .Params('gtin'                  , FProduto.Gtin)
        .Params('ceantrib'              , FProduto.cEanTrib)
        .Params('cean'                  , FProduto.cEan)
        .Params('nomeproduto'           , FProduto.NomeProduto)
        .Params('ncm'                   , FProduto.NCM)
        .Params('valorcusto'            , FProduto.ValorCusto)
        .Params('aliquotalucro'         , FProduto.AliquotaLucro)
        .Params('valorvendagelado'      , FProduto.ValorVendaGelado)
        .Params('valorvendanatural'     , FProduto.ValorVendaNatural)
        .Params('valorvendapromocional' , FProduto.ValorVendaPromocional)
        .Params('estoqueanterior'       , FProduto.EstoqueAnterior)
        .Params('estoquemaximo'         , FProduto.EstoqueMaximo)
        .Params('estoqueminimo'         , FProduto.EstoqueMinimo)
        .Params('estoqueatual'          , FProduto.EstoqueAtual)
        .Params('origem'                , FProduto.Origem)
        .Params('volume'                , FProduto.Volume)
        .Params('quantidadeembalagem'   , FProduto.QuantidadeEmbalagem)
        .Params('balanca'               , FProduto.Balanca)
        .Params('pesoliquido'           , FProduto.PesoLiquido)
        .Params('pesobruto'             , FProduto.PesoBruto)
        .Params('datahoraemissao'       , FProduto.DataHoraEmissao)
        .Params('ativo'                 , FProduto.Ativo)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOProduto.Post - ao tentar incluir um novo produto: ' + E.Message);
      Abort;
    end;
  end;
  FConexao.Commit;
  FDataSet := FQuery
                .SQL('select LAST_INSERT_ID () as id')
                .Open
                .DataSet;
  FProduto.Id(FDataSet.FieldByName('id').AsInteger);
end;

function TDAOProduto.Put: iDAOProduto;
const
  LSQL=('update produto set '+
                'idempresa            :idempresa, '+
                'idusuario            :idusuario, '+
                'idcategoria          :idcategoria, '+
                'idunidade            :idunidade, '+
                'gtin                 :gtin, '+
                'ceantrib             :ceantrib, '+
                'cean                 :cean, '+
                'nomeproduto          :nomeproduto, '+
                'ncm                  :ncm, '+
                'valorcusto           :valorcusto, '+
                'aliquotalucro        :aliquotalucro, '+
                'valorvendagelado     :valorvendagelado, '+
                'valorvendanatural    :valorvendanatural, '+
                'valorvendapromocional:valorvendapromocional, '+
                'estoqueanterior      :estoqueanterior, '+
                'estoquemaximo        :estoquemaximo, '+
                'estoqueminimo        :estoqueminimo, '+
                'estoqueatual         :estoqueatual, '+
                'origem               :origem, '+
                'volume               :volume, '+
                'quantidadeembalagem  :quantidadeembalagem, '+
                'balanca              :balanca, '+
                'pesoliquido          :pesoliquido, '+
                'pesobruto            :pesobruto, '+
                'datahoraemissao      :datahoraemissao, '+
                'ativo                :ativo '+
                'where id=:id '
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('id'                    , FProduto.Id)
        .Params('idempresa'             , FProduto.IdEmpresa)
        .Params('idusuario'             , FProduto.IdUsuario)
        .Params('idcategoria'           , FProduto.IdCategoria)
        .Params('idunidade'             , FProduto.IdUnidade)
        .Params('gtin'                  , FProduto.Gtin)
        .Params('ceantrib'              , FProduto.cEanTrib)
        .Params('cean'                  , FProduto.cEan)
        .Params('nomeproduto'           , FProduto.NomeProduto)
        .Params('ncm'                   , FProduto.NCM)
        .Params('valorcusto'            , FProduto.ValorCusto)
        .Params('aliquotalucro'         , FProduto.AliquotaLucro)
        .Params('valorvendagelado'      , FProduto.ValorVendaGelado)
        .Params('valorvendanatural'     , FProduto.ValorVendaNatural)
        .Params('valorvendapromocional' , FProduto.ValorVendaPromocional)
        .Params('estoqueanterior'       , FProduto.EstoqueAnterior)
        .Params('estoquemaximo'         , FProduto.EstoqueMaximo)
        .Params('estoqueminimo'         , FProduto.EstoqueMinimo)
        .Params('estoqueatual'          , FProduto.EstoqueAtual)
        .Params('origem'                , FProduto.Origem)
        .Params('volume'                , FProduto.Volume)
        .Params('quantidadeembalagem'   , FProduto.QuantidadeEmbalagem)
        .Params('balanca'               , FProduto.Balanca)
        .Params('pesoliquido'           , FProduto.PesoLiquido)
        .Params('pesobruto'             , FProduto.PesoBruto)
        .Params('datahoraemissao'       , FProduto.DataHoraEmissao)
        .Params('ativo'                 , FProduto.Ativo)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOProduto.Put - ao tentar alterar o produto: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOProduto.Delete: iDAOProduto;
const
  LSQL=('delete from produto where id=:id ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    FQuery.SQL(LSQL)
                 .Params('id', FProduto.Id)
               .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOProduto.Delete - ao tentar exclu�r o produto: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOProduto.LoopRegistro(Value : Integer): Integer;
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

function TDAOProduto.QuantidadeRegistro : Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAOProduto.This: iEntidadeProduto<iDAOProduto>;
begin
  Result := FProduto;
end;

end.
