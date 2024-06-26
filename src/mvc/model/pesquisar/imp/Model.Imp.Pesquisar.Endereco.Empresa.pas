{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 01/05/2024 11:37           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Pesquisar.Endereco.Empresa;

interface

uses
  Data.DB,
  System.SysUtils,
  System.JSON,

  DataSet.Serialize,

  Model.Pesquisar.Endereco.Empresa.Interfaces,
  Model.Entidade.Endereco.Empresa.Interfaces,
  Controller.Interfaces;

type
  TPesquisarEnderecoEmpresa = class(TInterfacedObject, iPesquisarEnderecoEmpresa)
    private
      FController      : iController;
      FEnderecoEmpresa : iEntidadeEnderecoEmpresa<iPesquisarEnderecoEmpresa>;
      FDSEnderecoEmpresa : TDataSource;
      FJSONObject : TJSONObject;
      FJSONArray  : TJSONArray;

      FFound : Boolean;
      FError : Boolean;

      FQuantidadeRegistro : Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iPesquisarEnderecoEmpresa;

      function Getby(IdEmpresa, IdEndereco : Integer) : iPesquisarEnderecoEmpresa;
      function LoopEnderecoEmpresa : TJSONValue;

      function Found : Boolean;
      function Error : Boolean;

      function EnderecoEmpresa : iEntidadeEnderecoEmpresa<iPesquisarEnderecoEmpresa>;
      function &End  : iPesquisarEnderecoEmpresa;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Endereco.Empresa;

{ TPesquisarEnderecoEmpresa }

constructor TPesquisarEnderecoEmpresa.Create;
begin
  FController      := TController.New;
  FEnderecoEmpresa := TEntidadeEnderecoEmpresa<iPesquisarEnderecoEmpresa>.New(Self);
  FDSEnderecoEmpresa := TDataSource.Create(nil);

  FFound := False;
  FError := False;
end;

destructor TPesquisarEnderecoEmpresa.Destroy;
begin
  inherited;
end;

class function TPesquisarEnderecoEmpresa.New: iPesquisarEnderecoEmpresa;
begin
  Result := Self.Create;
end;

function TPesquisarEnderecoEmpresa.Getby(IdEmpresa, IdEndereco : Integer) : iPesquisarEnderecoEmpresa;
begin
  Result := Self;
  FFound := False;
  try
    FController
      .FactoryDAO
        .DAOEnderecoEmpresa
          .This
            .IdEmpresa (IdEmpresa)
            .IdEndereco(IdEndereco)
          .&End
        .GetbyParams
        .DataSet(FDSEnderecoEmpresa);
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar encontrar enderecoempresa: ' + E.Message);
      FError := True;
    end;
  end;
  FFound := not FDSEnderecoEmpresa.DataSet.IsEmpty;
end;

//Loop para montar JSON endereco para alimentar JSON Pai empresa
function TPesquisarEnderecoEmpresa.LoopEnderecoEmpresa: TJSONValue;
begin
  FQuantidadeRegistro:= FController
                           .FactoryDAO
                             .DAOEnderecoEmpresa
                               .This
                                 .IdEmpresa(FEnderecoEmpresa.IdEmpresa)
                               .&End
                             .GetbyParams(Self)
                             .DataSet(FDSEnderecoEmpresa)
                             .QuantidadeRegistro;

  if not FDSEnderecoEmpresa.DataSet.IsEmpty then
  begin
    FJSONArray := TJSONArray.Create;
    FDSEnderecoEmpresa.DataSet.First;
    while not FDSEnderecoEmpresa.DataSet.Eof do
    begin
      FJSONObject := TJSONObject.Create;
      FJSONObject := FDSEnderecoEmpresa.DataSet.ToJSONObject;
      Result := FJSONObject;
      // Se tiver mais de um registro, adiciona ao array
      if FQuantidadeRegistro > 1 then
      begin
        FJSONArray.Add(FJSONObject);
        Result := FJSONArray;
      end;
      FDSEnderecoEmpresa.DataSet.Next;
    end;
  end;
end;

function TPesquisarEnderecoEmpresa.Found: Boolean;
begin
  Result := FFound;
end;

function TPesquisarEnderecoEmpresa.Error: Boolean;
begin
  Result := FError;
end;

//Inje��o de depend�ncia
function TPesquisarEnderecoEmpresa.EnderecoEmpresa: iEntidadeEnderecoEmpresa<iPesquisarEnderecoEmpresa>;
begin
  Result := FEnderecoEmpresa;
end;

function TPesquisarEnderecoEmpresa.&End: iPesquisarEnderecoEmpresa;
begin
  Result := Self;
end;

end.
