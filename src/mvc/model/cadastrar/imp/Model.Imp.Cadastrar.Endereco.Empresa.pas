{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 30/04/2024 14:18           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Cadastrar.Endereco.Empresa;

interface

uses
  Data.DB,

  System.JSON,
  System.SysUtils,

  DataSet.Serialize,
  Controller.Interfaces,
  Model.Cadastrar.Endereco.Empresa.Interfaces,
  Model.Entidade.Endereco.Empresa.Interfaces;

type
  TCadastrarEnderecoEmpresa = class(TInterfacedObject, iCadastrarEnderecoEmpresa)
    private
      FController       : iController;
      FEnderecoEmpresa  : iEntidadeEnderecoEmpresa<iCadastrarEnderecoEmpresa>;

      FJSONObjectPai      : TJSONObject;
      FJSONArrayEndereco  : TJSONArray;
      FJSONObjectEndereco : TJSONObject;

      FDSEnderecoEmpresa : TDataSource;
      FError     : Boolean;
      FQuantidadeRegistro : Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iCadastrarEnderecoEmpresa;

      function JSONObjectPai(Value : TJSONObject) : iCadastrarEnderecoEmpresa; overload;
      function JSONObjectPai                      : TJSONObject;               overload;
      function Post : iCadastrarEnderecoEmpresa;

      function Error     : Boolean;
      //inje��o de depend�ncia
      function EnderecoEmpresa : iEntidadeEnderecoEmpresa<iCadastrarEnderecoEmpresa>;
      function &End : iCadastrarEnderecoEmpresa;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Endereco.Empresa;

{ TCadastrarEnderecoEmpresa }

constructor TCadastrarEnderecoEmpresa.Create;
begin
  FController        := TController.New;
  FEnderecoEmpresa   := TEntidadeEnderecoEmpresa<iCadastrarEnderecoEmpresa>.New(Self);
  FDSEnderecoEmpresa := TDataSource.Create(nil);

  FError := False;
end;

destructor TCadastrarEnderecoEmpresa.Destroy;
begin
  inherited;
end;

class function TCadastrarEnderecoEmpresa.New: iCadastrarEnderecoEmpresa;
begin
  Result := Self.Create;
end;

function TCadastrarEnderecoEmpresa.JSONObjectPai(Value: TJSONObject): iCadastrarEnderecoEmpresa;
begin
  Result := Self;
  FJSONObjectPai := Value;
end;

function TCadastrarEnderecoEmpresa.JSONObjectPai: TJSONObject;
begin
  Result := FJSONObjectPai;
end;

//Inserindo dados na tabela enderecoempresa
function TCadastrarEnderecoEmpresa.Post: iCadastrarEnderecoEmpresa;
begin
  Result := Self;
  //Inserindo dados na tabela enderecoempresa caso n�o existir
  try
    if not FController
             .FactoryPesquisar
               .PesquisarEnderecoEmpresa
                 .EnderecoEmpresa
                   .IdEmpresa(FEnderecoEmpresa.IdEmpresa)
                   .IdEndereco(FEnderecoEmpresa.IdEndereco)
                 .&End
                .Getby(FEnderecoEmpresa.IdEmpresa, FEnderecoEmpresa.IdEndereco).Found then
      FController
        .FactoryDAO
          .DAOEnderecoEmpresa
            .This
              .IdEmpresa (FEnderecoEmpresa.IdEmpresa)
              .IdEndereco(FEnderecoEmpresa.IdEndereco)
            .&End
          .Post;
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar incluir enderecoempresa: ' + E.Message);
      FError := True;
    end;
  end;
end;

function TCadastrarEnderecoEmpresa.Error: Boolean;
begin
  Result := FError;
end;

//Inj~e��o de depend�ncia
function TCadastrarEnderecoEmpresa.EnderecoEmpresa: iEntidadeEnderecoEmpresa<iCadastrarEnderecoEmpresa>;
begin
  Result := FEnderecoEmpresa;
end;

function TCadastrarEnderecoEmpresa.&End: iCadastrarEnderecoEmpresa;
begin
  Result := Self;
end;

end.
