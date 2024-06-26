{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 01/05/2024 13:38           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Pesquisar.Endereco;

interface

uses
  Data.DB,
  System.JSON,
  System.SysUtils,

  DataSet.Serialize,
  Controller.Interfaces,
  Model.Pesquisar.Endereco.Interfaces,
  Model.Entidade.Endereco.Interfaces;

Type
  TPesquisarEndereco = class(TInterfacedObject, iPesquisarEndereco)
    private
      FController : iController;
      FEndereco   : iEntidadeEndereco<iPesquisarEndereco>;
      FDSEndereco : TDataSource;

      FFound : Boolean;
      FError : Boolean;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iPesquisarEndereco;

      function GetbyCep(Cep : String) : iPesquisarEndereco;
      function Found    : Boolean;
      function Error    : Boolean;
      function Endereco : iEntidadeEndereco<iPesquisarEndereco>;
      function &End     : iPesquisarEndereco;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Endereco;

{ TPesquisarEndereco }

constructor TPesquisarEndereco.Create;
begin
  FController := TController.New;
  FEndereco   := TEntidadeEndereco<iPesquisarEndereco>.New(Self);
  FDSEndereco := TDataSource.Create(nil);

  FFound := False;
  FError := False;
end;

destructor TPesquisarEndereco.Destroy;
begin
  inherited;
end;

class function TPesquisarEndereco.New: iPesquisarEndereco;
begin
  Result := Self.Create;
end;

function TPesquisarEndereco.GetbyCep(Cep: String): iPesquisarEndereco;
begin
  Result := Self;
  FFound := False;
  try
    FController
      .FactoryDAO
        .DAOEndereco
        .GetbyParams(Cep)
        .DataSet(FDSEndereco);
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar encontrar registro: ' + E.Message);
      FError := True;
    end;
  end;
  FFound := FDSEndereco.DataSet.IsEmpty;
end;

function TPesquisarEndereco.Found: Boolean;
begin
  Result := FFound;
end;

function TPesquisarEndereco.Error: Boolean;
begin
  Result := FError;
end;

//Inje��o de depend�ncia
function TPesquisarEndereco.Endereco: iEntidadeEndereco<iPesquisarEndereco>;
begin
  Result := FEndereco;
end;

function TPesquisarEndereco.&End: iPesquisarEndereco;
begin
  Result := Self;
end;

end.
