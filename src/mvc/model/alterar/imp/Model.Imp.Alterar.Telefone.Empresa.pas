{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 30/04/2024 14:18           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Alterar.Telefone.Empresa;

interface

uses
  Data.DB,
  System.SysUtils,
  System.JSON,

  Model.Alterar.Telefone.Empresa.Interfaces,
  Model.Entidade.Telefone.Empresa.Interfaces,
  Controller.Interfaces;

type
  TAlterarTelefoneEmpresa = class(TInterfacedObject, iAlterarTelefoneEmpresa)
    private
      FController      : iController;
      FTelefoneEmpresa : iEntidadeTelefoneEmpresa<iAlterarTelefoneEmpresa>;
      FDSTelefoneEmpresa  : TDataSource;

      FJSONObject : TJSONObject;
      FJSONArray  : TJSONArray;

      FFound : Boolean;
      FError : Boolean;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iAlterarTelefoneEmpresa;

      function JSONObject(Value : TJSONObject) : iAlterarTelefoneEmpresa; overload;
      function JSONObject                      : TJSONObject;             overload;
      function Put    : iAlterarTelefoneEmpresa;
      function Found  : Boolean;
      function Error  : Boolean;

      //inje��o de depend�ncia
      function TelefoneEmpresa : iEntidadeTelefoneEmpresa<iAlterarTelefoneEmpresa>;
      function &End            : iAlterarTelefoneEmpresa;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Telefone.Empresa;

{ TAlterarTelefoneEmpresa }

constructor TAlterarTelefoneEmpresa.Create;
begin
  FController        := TController.New;
  FTelefoneEmpresa   := TEntidadeTelefoneEmpresa<iAlterarTelefoneEmpresa>.New(Self);
  FDSTelefoneEmpresa := TDataSource.Create(nil);

  FFound := False;
  FError := False;
end;

destructor TAlterarTelefoneEmpresa.Destroy;
begin
  inherited;
end;

class function TAlterarTelefoneEmpresa.New: iAlterarTelefoneEmpresa;
begin
  Result := Self.Create;
end;

function TAlterarTelefoneEmpresa.JSONObject(Value: TJSONObject): iAlterarTelefoneEmpresa;
begin
  Result := Self;
  FJSONObject := Value;
end;

function TAlterarTelefoneEmpresa.JSONObject: TJSONObject;
begin
  Result := FJSONObject;
end;

function TAlterarTelefoneEmpresa.Put: iAlterarTelefoneEmpresa;
Var
  I : Integer;
begin
  FJSONArray := FJSONObject.Get('telefoneempresa').JsonValue as TJSONArray;
  try
    //Loop emails
    for I := 0 to FJSONArray.Count - 1 do
    begin
      //Extraindo os dados do(s) emai(s)  e salvando no banco de dados
      FJSONObject :=  FJSONArray.Items[I] as TJSONObject;
      FController
        .FactoryDAO
          .DAOEmailEmpresa
            .This
              .Id       (FJSONObject.GetValue<Integer>('id'))
              .IdEmpresa(FTelefoneEmpresa.IdEmpresa)
              .Email    (FJSONObject.GetValue<String> ('email'))
              .TipoEmail(FJSONObject.GetValue<String> ('tipoemail'))
              .Ativo    (FJSONObject.GetValue<Integer>('ativo'))
            .&End
          .Put;
      end;
    except
      on E: Exception do
      begin
        WriteLn('Erro ao tentar alterar o registro: ' + E.Message);
        FError := True;
      end;
  end;
end;

function TAlterarTelefoneEmpresa.Found: Boolean;
begin
  Result := FFound;
end;

function TAlterarTelefoneEmpresa.Error: Boolean;
begin
  Result := FError;
end;

//Inje��o de depend�ncia
function TAlterarTelefoneEmpresa.TelefoneEmpresa: iEntidadeTelefoneEmpresa<iAlterarTelefoneEmpresa>;
begin
  Result := FTelefoneEmpresa;
end;

function TAlterarTelefoneEmpresa.&End: iAlterarTelefoneEmpresa;
begin
  Result := Self;
end;

end.
