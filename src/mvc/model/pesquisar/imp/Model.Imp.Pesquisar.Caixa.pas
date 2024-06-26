{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 02/05/2024 19:57           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Pesquisar.Caixa;

interface

uses
  Data.DB,
  System.JSON,
  DataSet.Serialize,

  Model.Pequisar.Caixa.Interfaces,
  Controller.Interfaces,
  Model.Entidade.Caixa.Interfaces;

type
  TPesquisarCaixa = class(TInterfacedObject, iPesquisarCaixa)
    private
      FController : iController;
      FCaixa      : iEntidadeCaixa<iPesquisarCaixa>;
      FDSCaixa    : TDataSource;

      FJSONValue  : TJSONValue;

      FFound : Boolean;
      FError : Boolean;

      FQuantidadeRegistro : Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iPesquisarCaixa;

      function JSONValue(Value : TJSONValue) : iPesquisarCaixa; overload;
      function JSONValue                     : TJSONValue;      overload;
      function GetbyId(Id : Variant)         : iPesquisarCaixa;
      function GetbyParams(Value : String)   : iPesquisarCaixa;
      function GetAll                        : iPesquisarCaixa;
      function Found : Boolean;
      function Error : Boolean;
      function Caixa : iEntidadeCaixa<iPesquisarCaixa>;
      function &End  : iPesquisarCaixa;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Caixa;

{ TPesquisarCaixa }

constructor TPesquisarCaixa.Create;
begin
  FController := TController.New;
  FCaixa      := TEntidadeCaixa<iPesquisarCaixa>.New(Self);
  FDSCaixa    := TDataSource.Create(nil);

  FFound := False;
  FError := False;

  FQuantidadeRegistro := 0;
end;

destructor TPesquisarCaixa.Destroy;
begin
  inherited;
end;

class function TPesquisarCaixa.New: iPesquisarCaixa;
begin
  Result := Self.Create;
end;

function TPesquisarCaixa.JSONValue(Value: TJSONValue): iPesquisarCaixa;
begin
  Result := Self;
  FJSONValue := Value;
end;

function TPesquisarCaixa.JSONValue: TJSONValue;
begin
  Result := FJSONValue;
end;

function TPesquisarCaixa.GetbyId(Id: Variant): iPesquisarCaixa;
begin
  Result := Self;
  FController
    .FactoryDAO
      .DAOCaixa
        .GetbyID(Id)
      .DataSet(FDSCaixa);
  FFound := not FDSCaixa.DataSet.IsEmpty;
end;

function TPesquisarCaixa.GetbyParams(Value: String): iPesquisarCaixa;
begin
  Result := Self;
  FQuantidadeRegistro := FController
                           .FactoryDAO
                             .DAOCaixa
                               .This
                                 .Usuario
                                   .NomeUsuario(Value)
                                 .&End
                               .&End
                               .GetbyParams
                             .DataSet(FDSCaixa)
                             .QuantidadeRegistro;

  FFound := not FDSCaixa.DataSet.IsEmpty;
end;

function TPesquisarCaixa.GetAll: iPesquisarCaixa;
begin
  Result := Self;
  FQuantidadeRegistro := FController
                           .FactoryDAO
                             .DAOCaixa
                               .GetAll
                             .DataSet(FDSCaixa)
                             .QuantidadeRegistro;
  FFound := not FDSCaixa.DataSet.IsEmpty;
end;

function TPesquisarCaixa.Found: Boolean;
begin
  Result := FFound;
end;

function TPesquisarCaixa.Error: Boolean;
begin
  Result := Error;
end;

//Inje��o de depend�ncia
function TPesquisarCaixa.Caixa: iEntidadeCaixa<iPesquisarCaixa>;
begin
  Result := FCaixa;
end;

function TPesquisarCaixa.&End: iPesquisarCaixa;
begin
  Result := Self;
end;

end.
