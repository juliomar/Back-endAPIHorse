{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 02/05/2024 10:23           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Pesquisar.Telefone.Pessoa;

interface

uses
  Data.DB,
  System.JSON,
  DataSet.Serialize,

  Model.Pesquisar.Telefone.Pessoa.Interfaces,
  Controller.Interfaces,
  Model.Entidade.Telefone.Pessoa.Interfaces;

type
  TPesquisarTelefonePessoa = class(TInterfacedObject, iPesquisarTelefonePessoa)
    private
      FController     : iController;
      FTelefonePessoa : iEntidadeTelefonePessoa<iPesquisarTelefonePessoa>;

      FDSTelefonePessoa : TDataSource;

      FJSONObject : TJSONObject;
      FJSONArray  : TJSONArray;

      FFound : Boolean;
      FError : Boolean;

      FQuantidadeRegistro : Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iPesquisarTelefonePessoa;

      function GetBy(IdPessoa : Integer; DDD, NumeroTelefone: String) :iPesquisarTelefonePessoa;
      function LoopTelefonePessoa : TJSONValue;
      function Found : Boolean;
      function Error : Boolean;

      //inje��o de depend�ncia
      function TelefonePessoa : iEntidadeTelefonePessoa<iPesquisarTelefonePessoa>;
      function &End : iPesquisarTelefonePessoa;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Telefone.Pessoa;

{ TPesquisarTelefonePessoa }

constructor TPesquisarTelefonePessoa.Create;
begin
  FController       := TController.New;
  FTelefonePessoa   := TEntidadeTelefonePessoa<iPesquisarTelefonePessoa>.New(Self);
  FDSTelefonePessoa := TDataSource.Create(nil);

  FFound := False;
  FError := False;

  FQuantidadeRegistro := 0;
end;

destructor TPesquisarTelefonePessoa.Destroy;
begin
  inherited;
end;

class function TPesquisarTelefonePessoa.New: iPesquisarTelefonePessoa;
begin
  Result := Self.Create;
end;

function TPesquisarTelefonePessoa.GetBy(IdPessoa: Integer; DDD, NumeroTelefone: String): iPesquisarTelefonePessoa;
begin
  Result := Self;
end;

function TPesquisarTelefonePessoa.LoopTelefonePessoa: TJSONValue;
begin
  FQuantidadeRegistro := FController
                          .FactoryDAO
                            .DAOTelefonePessoa
                              .GetbyId(FTelefonePessoa.IdPessoa)
                            .DataSet(FDSTelefonePessoa)
                            .QuantidadeRegistro;
   if not FDSTelefonePessoa.DataSet.IsEmpty then
   begin
     FJSONArray := TJSONArray.Create;//JSONArray
     FDSTelefonePessoa.DataSet.First;
     while not FDSTelefonePessoa.DataSet.Eof do
     begin
       FJSONObject := TJSONObject.Create;//JSONObject
       FJSONObject := FDSTelefonePessoa.DataSet.ToJSONObject;
       Result := FJSONObject;
       // Se tiver mais de um registro, adiciona ao array
       if FQuantidadeRegistro > 1 then
       begin
         FJSONArray.Add(FJSONObject);
         Result := FJSONArray;
       end;
        FDSTelefonePessoa.DataSet.Next;
     end;
   end;
end;

function TPesquisarTelefonePessoa.Found: Boolean;
begin
  Result := FFound;
end;

function TPesquisarTelefonePessoa.Error: Boolean;
begin
  Result := FError;
end;

//Inje��o de depend�ncia
function TPesquisarTelefonePessoa.TelefonePessoa: iEntidadeTelefonePessoa<iPesquisarTelefonePessoa>;
begin
  Result := FTelefonePessoa;
end;

function TPesquisarTelefonePessoa.&End: iPesquisarTelefonePessoa;
begin
  Result := Self;
end;

end.
