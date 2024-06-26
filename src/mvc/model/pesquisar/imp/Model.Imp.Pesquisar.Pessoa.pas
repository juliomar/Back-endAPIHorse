{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 02/05/2024 10:23           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Pesquisar.Pessoa;

interface

uses
  Data.DB,
  System.SysUtils,

  Controller.Interfaces,
  Model.Entidade.Pessoa.Interfaces,
  Model.Pesquisar.Pessoa.Interfaces;

type
  TPesquisarPessoa = class(TInterfacedObject, iPesquisarPessoa)
    private
      FController : iController;
      FPessoa     : iEntidadePessoa<iPesquisarPessoa>;
      FDataSet    : TDataSource;
      FDSPessoa   : TDataSource;

      FFound : Boolean;
      FError : Boolean;

      FQuantidadeRegistro : Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iPesquisarPessoa;

      function DataSet(Value : TDataSource)         : iPesquisarPessoa; overload;
      function DataSet                              : TDataSource;      overload;
      function GetbyId        (Id : Variant)        : iPesquisarPessoa;
      function GetbyCPFCNPJ   (CPFCNPJ    : String) : iPesquisarPessoa;
      function GetbyNomePessoa(NomePessoa : String) : iPesquisarPessoa;
      function GetbySobreNome (SobreNome  : String) : iPesquisarPessoa;
      function GetAll                               : iPesquisarPessoa;
      function LoopPessoa                           : iPesquisarPessoa;
      function Found  : Boolean;
      function Error  : Boolean;
      function Pessoa : iEntidadePessoa<iPesquisarPessoa>;
      function &End   : iPesquisarPessoa;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Pessoa;

{ TPesquisarPessoa }

constructor TPesquisarPessoa.Create;
begin
  FController := TController.New;
  FPessoa     := TEntidadePessoa<iPesquisarPessoa>.New(Self);
  FDSPessoa   := TDataSource.Create(nil);
  FDataSet    := TDataSource.Create(nil);

  FFound := False;
  FError := False;
end;

destructor TPesquisarPessoa.Destroy;
begin
  inherited;
end;

class function TPesquisarPessoa.New: iPesquisarPessoa;
begin
  Result := Self.Create;
end;

function TPesquisarPessoa.DataSet: TDataSource;
begin
  Result := FDataSet;
end;

function TPesquisarPessoa.DataSet(Value: TDataSource): iPesquisarPessoa;
begin
  Result := Self;
  FDataSet := Value;
end;

function TPesquisarPessoa.GetbyId(Id: Variant): iPesquisarPessoa;
begin
  Result := Self;
  FController
    .FactoryDAO
      .DAOPessoa
        .GetbyID(Id)
      .DataSet(FDSPessoa);
  FFound := not FDSPessoa.DataSet.IsEmpty;
  FDataSet:= FDSPessoa;
end;

function TPesquisarPessoa.GetbyCPFCNPJ(CPFCNPJ: String): iPesquisarPessoa;
begin
  Result := Self;
  FController
    .FactoryDAO
      .DAOPessoa
        .GetbyParams(CPFCNPJ)
      .DataSet(FDSPessoa);
  FFound := not FDSPessoa.DataSet.IsEmpty;
  FDataSet := FDSPessoa;
end;

function TPesquisarPessoa.GetbyNomePessoa(NomePessoa: String): iPesquisarPessoa;
begin
  Result := Self;
  FQuantidadeRegistro := FController
                           .FactoryDAO
                             .DAOPessoa
                               .GetbyParams(0, NomePessoa)
                               .DataSet(FDSPessoa)
                               .QuantidadeRegistro;
  FDataSet := FDSPessoa;
end;

function TPesquisarPessoa.GetbySobreNome(SobreNome: String): iPesquisarPessoa;
begin
  Result := Self;
  FQuantidadeRegistro := FController
                          .FactoryDAO
                            .DAOPessoa
                              .GetbyParams(1, SobreNome)
                              .DataSet(FDSPessoa)
                              .QuantidadeRegistro;
  FDataSet := FDSPessoa;
end;

function TPesquisarPessoa.GetAll: iPesquisarPessoa;
begin
  Result := Self;
  FQuantidadeRegistro := FController
                           .FactoryDAO
                             .DAOPessoa
                               .GetAll
                             .DataSet(FDSPessoa)
                             .QuantidadeRegistro;
  FDataSet := FDSPessoa;
end;

function TPesquisarPessoa.LoopPessoa: iPesquisarPessoa;
begin
//
end;

function TPesquisarPessoa.Found: Boolean;
begin
  Result := FFound;
end;

function TPesquisarPessoa.Error: Boolean;
begin
  Result := FError;
end;

//Inje��o de depend�ncia
function TPesquisarPessoa.Pessoa: iEntidadePessoa<iPesquisarPessoa>;
begin
  Result := FPessoa;
end;

function TPesquisarPessoa.&End: iPesquisarPessoa;
begin
  Result := Self
end;

end.
