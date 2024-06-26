{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 02/05/2024 11:44           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Cadastrar.Telefone.Pessoa;

interface

uses
  Data.DB,
  System.JSON,
  System.SysUtils,

  DataSet.Serialize,

  Model.Cadastrar.Telefone.Pessoa.Interfaces,
  Model.Entidade.Telefone.Pessoa.Interfaces,
  Controller.Interfaces;

type
  TCadastrarTelefonePessoa = class(TInterfacedObject, iCadastrarTelefonePessoa)
    private
      FController       : iController;
      FTelefonePessoa   : iEntidadeTelefonePessoa<iCadastrarTelefonePessoa>;
      FJSONArray        : TJSONArray;
      FJSONObject       : TJSONObject;
      FJSONObjectPai    : TJSONObject;
      FDSTelefonePessoa : TDataSource;

      FError : Boolean;
      FQuantidadeRegistro : Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iCadastrarTelefonePessoa;

      function JSONObjectPai(Value : TJSONObject) : iCadastrarTelefonePessoa; overload;
      function JSONObjectPai                      : TJSONObject;              overload;
      function Post  : iCadastrarTelefonePessoa;
      function Error : Boolean;
      //inje��o de depend�ncia
      function TelefonePessoa : iEntidadeTelefonePessoa<iCadastrarTelefonePessoa>;
      function &End : iCadastrarTelefonePessoa;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Telefone.Pessoa;

{ TCadastrarTelefonePessoa }

constructor TCadastrarTelefonePessoa.Create;
begin
  FController       := TController.New;
  FTelefonePessoa   := TEntidadeTelefonePessoa<iCadastrarTelefonePessoa>.New(Self);
  FDSTelefonePessoa := TDataSource.Create(nil);

  FError := False;
  FQuantidadeRegistro := 0;
end;

destructor TCadastrarTelefonePessoa.Destroy;
begin
  inherited;
end;

class function TCadastrarTelefonePessoa.New: iCadastrarTelefonePessoa;
begin
  Result := Self.Create;
end;

function TCadastrarTelefonePessoa.JSONObjectPai(Value: TJSONObject): iCadastrarTelefonePessoa;
begin
  Result := Self;
  FJSONObject := Value;
end;

function TCadastrarTelefonePessoa.JSONObjectPai: TJSONObject;
begin
  Result := FJSONObject;
end;

function TCadastrarTelefonePessoa.Post: iCadastrarTelefonePessoa;
Var
  I : Integer;
begin
  Result := Self;
  FJSONArray := FJSONObjectPai.GetValue('telefonepessoa') as TJSONArray;
  try
    //Loop emails
    for I := 0 to FJSONArray.Count - 1 do
    begin
      //Extraindo os dados do(s) emai(s)  e salvando no banco de dados
      FJSONObject :=  FJSONArray.Items[I] as TJSONObject;
      //verifico se consta o email que esta vindo no json. Na tabela emailempresa, se n�o existir insiro.
      if not FController
               .FactoryPesquisar
                 .PesquisarTelefonePessoa
                   .Getby(FTelefonePessoa.IdPessoa,
                          FJSONObject.GetValue<String>('ddd'),
                          FJSONObject.GetValue<String>('numerotelefone')).Found Then
        FController
          .FactoryDAO
            .DAOTelefonePessoa
              .This
                .IdEmpresa     (FTelefonePessoa.IdEmpresa)
                .Operadora     (FJSONObject.GetValue<String>('operadora'))
                .DDD           (FJSONObject.GetValue<String>('ddd'))
                .NumeroTelefone(FJSONObject.GetValue<String>('numerotelefone'))
                .TipoTelefone  (FJSONObject.GetValue<String>('tipotelefone'))
                .Ativo         (1)
              .&End
            .Post;
    end;
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar incluir registro: ' + E.Message);
      FError := True;
    end;
  end;

end;

function TCadastrarTelefonePessoa.Error: Boolean;
begin
  Result := FError;
end;

//Inje��o de depend�ncia
function TCadastrarTelefonePessoa.TelefonePessoa: iEntidadeTelefonePessoa<iCadastrarTelefonePessoa>;
begin
  Result := FTelefonePessoa;
end;

function TCadastrarTelefonePessoa.&End: iCadastrarTelefonePessoa;
begin
  Result := Self;
end;

end.
