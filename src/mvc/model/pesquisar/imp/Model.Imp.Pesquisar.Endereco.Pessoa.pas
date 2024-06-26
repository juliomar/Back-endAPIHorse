{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 02/05/2024 10:23           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Pesquisar.Endereco.Pessoa;

interface

uses
  Data.DB,
  System.JSON,
  System.SysUtils,

  DataSet.Serialize,

  Model.Pesquisar.Endereco.Pessoa.Interfaces,
  Controller.Interfaces,
  Model.Entidade.Endereco.Pessoa.Interfaces;

type
  TPesquisarEnderecoPessoa = class(TInterfacedObject, iPesquisarEnderecoPessoa)
    private
      FController     : iController;
      FEnderecoPessoa : iEntidadeEnderecoPessoa<iPesquisarEnderecoPessoa>;

      FDSEnderecoPessoa : TDataSource;

      FDataSet    : TDataSource;
      FJSONObject : TJSONObject;
      FJSONArray  : TJSONArray;

      FFound : Boolean;
      FError : Boolean;

      FQuantidadeRegistro : Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iPesquisarEnderecoPessoa;

      function DataSet(Value : TDataSource)                     : iPesquisarEnderecoPessoa; overload;
      function DataSet                                          : TDataSource;              overload;
      function Getby(IdEmpresa, IdEndereco, IdPessoa : Integer) : iPesquisarEnderecoPessoa;
      function LoopEnderecoPessoa : TJSONValue;
      function Found : Boolean;
      function Error : Boolean;

      function EnderecoPessoa : iEntidadeEnderecoPessoa<iPesquisarEnderecoPessoa>;
      function &End  : iPesquisarEnderecoPessoa;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Endereco.Pessoa;

{ TPesquisarEnderecoPessoa }

constructor TPesquisarEnderecoPessoa.Create;
begin
  FController     := TController.New;
  FEnderecoPessoa := TEntidadeEnderecoPessoa<iPesquisarEnderecoPessoa>.New(Self);
  FDSEnderecoPessoa := TDataSource.Create(nil);
  FDataSet    := TDataSource.Create(nil);

  FFound := False;
  FError := False;
  FQuantidadeRegistro := 0;
end;

destructor TPesquisarEnderecoPessoa.Destroy;
begin
  inherited;
end;

class function TPesquisarEnderecoPessoa.New: iPesquisarEnderecoPessoa;
begin
  Result := Self.Create;
end;

function TPesquisarEnderecoPessoa.DataSet(Value: TDataSource): iPesquisarEnderecoPessoa;
begin
  Result := Self;
  FDataSet := Value;
end;

function TPesquisarEnderecoPessoa.DataSet: TDataSource;
begin
  Result := FDataSet;
end;

function TPesquisarEnderecoPessoa.Getby(IdEmpresa, IdEndereco, IdPessoa: Integer): iPesquisarEnderecoPessoa;
begin
  Result := Self;
  FFound := False;
  try
    FController
      .FactoryDAO
        .DAOEnderecoPessoa
          .This
            .IdEmpresa (IdEmpresa)
            .IdEndereco(IdEndereco)
            .IdPessoa  (IdPessoa)
          .&End
        .GetbyParams
        .DataSet(FDSEnderecoPessoa);
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar encontrar enderecoempresa: ' + E.Message);
      FError := True;
    end;
  end;
  FFound := not FDSEnderecoPessoa.DataSet.IsEmpty;
  FDataSet:= FDSEnderecoPessoa;
end;

function TPesquisarEnderecoPessoa.LoopEnderecoPessoa: TJSONValue;
begin
  FQuantidadeRegistro:= FController
                           .FactoryDAO
                             .DAOEnderecoPessoa
                               .GetbyId(FEnderecoPessoa.IdPessoa)
                             .DataSet(FDSEnderecoPessoa)
                             .QuantidadeRegistro;

  if not FDSEnderecoPessoa.DataSet.IsEmpty then
  begin
    FJSONArray := TJSONArray.Create;
    FDSEnderecoPessoa.DataSet.First;
    while not FDSEnderecoPessoa.DataSet.Eof do
    begin
      FJSONObject := TJSONObject.Create;
      FJSONObject := FDSEnderecoPessoa.DataSet.ToJSONObject;
      Result := FJSONObject;
      // Se tiver mais de um registro, adiciona ao array
      if FQuantidadeRegistro > 1 then
      begin
        FJSONArray.Add(FJSONObject);
        Result := FJSONArray;
      end;
      FDSEnderecoPessoa.DataSet.Next;
    end;
  end;
end;

function TPesquisarEnderecoPessoa.Found: Boolean;
begin
  Result := FFound;
end;

function TPesquisarEnderecoPessoa.Error: Boolean;
begin
  Result := FError;
end;

//Inje��o de depend�ncia
function TPesquisarEnderecoPessoa.EnderecoPessoa: iEntidadeEnderecoPessoa<iPesquisarEnderecoPessoa>;
begin
  Result := FEnderecoPessoa;
end;

function TPesquisarEnderecoPessoa.&End: iPesquisarEnderecoPessoa;
begin
  Result := Self;
end;

end.
