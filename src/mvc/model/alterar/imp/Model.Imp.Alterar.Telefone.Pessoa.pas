{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 02/05/2024 13:42           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Alterar.Telefone.Pessoa;

interface

uses
  Data.DB,
  System.JSON,
  System.SysUtils,

  Model.Alterar.Telefone.Pessoa.Interfaces,
  Model.Entidade.Telefone.Pessoa.Interfaces,
  Controller.Interfaces;

type
  TAlterarTelefonePessoa = class(TInterfacedObject, iAlterarTelefonePessoa)
    private
      FController       : iController;
      FTelefonePessoa   : iEntidadeTelefonePessoa<iAlterarTelefonePessoa>;
      FDSTelefonePessoa : TDataSource;

      FJSONObject : TJSONObject;
      FJSONArray  : TJSONArray;

      FFound : Boolean;
      FError : Boolean;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iAlterarTelefonePessoa;

      function JSONObject(Value : TJSONObject) : iAlterarTelefonePessoa; overload;
      function JSONObject                      : TJSONObject;            overload;
      function Put    : iAlterarTelefonePessoa;
      function Found  : Boolean;
      function Error  : Boolean;

      //inje��o de depend�ncia
      function TelefonePessoa : iEntidadeTelefonePessoa<iAlterarTelefonePessoa>;
      function &End : iAlterarTelefonePessoa;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Telefone.Pessoa;

{ TAlterarTelefonePessoa }

constructor TAlterarTelefonePessoa.Create;
begin
  FController       := TController.New;
  FTelefonePessoa   := TEntidadeTelefonePessoa<iAlterarTelefonePessoa>.New(Self);
  FDSTelefonePessoa := TDataSource.Create(nil);

  FFound := False;
  FError := False;
end;

destructor TAlterarTelefonePessoa.Destroy;
begin
  inherited;
end;

class function TAlterarTelefonePessoa.New: iAlterarTelefonePessoa;
begin
  Result := Self.Create;
end;

function TAlterarTelefonePessoa.JSONObject(Value: TJSONObject): iAlterarTelefonePessoa;
begin
  Result := Self;
  FJSONObject := Value;
end;

function TAlterarTelefonePessoa.JSONObject: TJSONObject;
begin
  Result := FJSONObject;
end;

function TAlterarTelefonePessoa.Put: iAlterarTelefonePessoa;
Var
  I : Integer;
begin
  FJSONArray := FJSONObject.Get('telefonepessoa').JsonValue as TJSONArray;
  try
    //Loop telefone(s)
    for I := 0 to FJSONArray.Count - 1 do
    begin
      //Extraindo os dados do(s) telefone(s) e salvando no banco de dados
      FJSONObject := FJSONArray.Items[I] as TJSONObject;
        FController
          .FactoryDAO
            .DAOTelefonePessoa
              .This
                .Id            (FJSONObject.GetValue<Integer>('id'))
                .IdEmpresa     (FTelefonePessoa.IdEmpresa)
                .IdPessoa      (FTelefonePessoa.IdPessoa)
                .Operadora     (FJSONObject.GetValue<String> ('operadora'))
                .DDD           (FJSONObject.GetValue<String> ('ddd'))
                .NumeroTelefone(FJSONObject.GetValue<String> ('numerotelefone'))
                .TipoTelefone  (FJSONObject.GetValue<String> ('tipotelefone'))
                .Ativo         (FJSONObject.GetValue<Integer>('ativo'))
              .&End
            .Put;
    end;
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar alterar registro: ' + E.Message);
      FError := True;
    end;
  end;
end;

function TAlterarTelefonePessoa.Found: Boolean;
begin
  Result := FFound;
end;

function TAlterarTelefonePessoa.Error: Boolean;
begin
  Result := FError;
end;

//Inje��o de depend�ncia
function TAlterarTelefonePessoa.TelefonePessoa: iEntidadeTelefonePessoa<iAlterarTelefonePessoa>;
begin
  Result := FTelefonePessoa;
end;

function TAlterarTelefonePessoa.&End: iAlterarTelefonePessoa;
begin
  Result := Self;
end;

end.
