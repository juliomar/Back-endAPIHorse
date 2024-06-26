{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 30/04/2024 23:48           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Alterar.Email.Empresa;

interface

uses
  Data.DB,
  System.SysUtils,
  System.JSON,

  Model.Alterar.Email.Empresa.Interfaces,
  Model.Entidade.Email.Empresa.Interfaces,
  Controller.Interfaces;

type
  TAlterarEmailEmpresa = class(TInterfacedObject, iAlterarEmailEmpresa)
    private
      FController     : iController;
      FEmailEmpresa   : iEntidadeEmailEmpresa<iAlterarEmailEmpresa>;
      FDSEmailEmpresa : TDataSource;

      FJSONObject : TJSONObject;
      FJSONArray  : TJSONArray;

      FFound : Boolean;
      FError : Boolean;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iAlterarEmailEmpresa;

      function JSONObject(Value : TJSONObject) : iAlterarEmailEmpresa; overload;
      function JSONObject                      : TJSONObject;          overload;
      function Put    : iAlterarEmailEmpresa;
      function Found  : Boolean;
      function Error  : Boolean;

      //inje��o de depend�ncia
      function EmailEmpresa : iEntidadeEmailEmpresa<iAlterarEmailEmpresa>;
      function &End         : iAlterarEmailEmpresa;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Email.Empresa;

{ TAlterarEmailEmpresa }

constructor TAlterarEmailEmpresa.Create;
begin
  FController     := TController.New;
  FEmailEmpresa   := TEntidadeEmailEmpresa<iAlterarEmailEmpresa>.New(Self);
  FDSEmailEmpresa := TDataSource.Create(nil);

  FFound := False;
  FError := False;
end;

destructor TAlterarEmailEmpresa.Destroy;
begin
  inherited;
end;

class function TAlterarEmailEmpresa.New: iAlterarEmailEmpresa;
begin
  Result := Self.Create;
end;

function TAlterarEmailEmpresa.JSONObject(Value: TJSONObject): iAlterarEmailEmpresa;
begin
  Result := Self;
  FJSONObject := Value;
end;

function TAlterarEmailEmpresa.JSONObject: TJSONObject;
begin
  Result := FJSONObject;
end;

function TAlterarEmailEmpresa.Put: iAlterarEmailEmpresa;
Var
  I : Integer;
begin
  FJSONArray := FJSONObject.Get('emailempresa').JsonValue as TJSONArray;
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
              .IdEmpresa(FEmailEmpresa.IdEmpresa)
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

function TAlterarEmailEmpresa.Found: Boolean;
begin
  Result := FFound;
end;

function TAlterarEmailEmpresa.Error: Boolean;
begin
  Result := FError;
end;

//Inje��o de depend�ncia
function TAlterarEmailEmpresa.EmailEmpresa: iEntidadeEmailEmpresa<iAlterarEmailEmpresa>;
begin
  Result := FEmailEmpresa;
end;

function TAlterarEmailEmpresa.&End: iAlterarEmailEmpresa;
begin
  Result := Self;
end;

end.
