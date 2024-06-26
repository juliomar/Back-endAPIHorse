{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 30/04/2024 14:18           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Cadastrar.Numero;

interface

uses
  Data.DB,

  System.JSON,
  System.SysUtils,

  Controller.Interfaces,
  Model.Cadastrar.Numero.Interfaces,
  Model.Entidade.Numero.Interfaces,
  Model.Entidade.Empresa.Interfaces;

type
  TCadastrarNumero = class(TInterfacedObject, iCadastrarNumero)
    private
      FController     : iController;
      FNumero         : iEntidadeNumero<iCadastrarNumero>;
      FEmpresa        : iEntidadeEmpresa<iCadastrarNumero>;
      FJSONArrayNumero  : TJSONArray;
      FJSONObjectNumero : TJSONObject;
      FJSONObjectPai    : TJSONObject;
      //
      FDSNumero  : TDataSource;

      FIdNumero  : Integer;
      FError     : Boolean;
      procedure CadastrarEnderecoEmpresa;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iCadastrarNumero;

      function JSONObjectPai(Value : TJSONObject) : iCadastrarNumero; overload;
      function JSONObjectPai                      : TJSONObject;      overload;
      function Post : iCadastrarNumero;
      function Error     : Boolean;
      //inje��o de depend�ncia
      function Numero  : iEntidadeNumero<iCadastrarNumero>;
      function Empresa : iEntidadeEmpresa<iCadastrarNumero>;
      function &End : iCadastrarNumero;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Numero,
  Model.Entidade.Imp.Empresa;

{ TCadastrarNumero }

constructor TCadastrarNumero.Create;
begin
  FController := TController.New;
  FNumero     := TEntidadeNumero<iCadastrarNumero>.New(Self);
  FEmpresa    := TEntidadeEmpresa<iCadastrarNumero>.New(Self);
  FDSNumero   := TDataSource.Create(nil);
  FError      := False;
end;

destructor TCadastrarNumero.Destroy;
begin
  inherited;
end;

class function TCadastrarNumero.New: iCadastrarNumero;
begin
  Result := Self.Create;
end;

function TCadastrarNumero.JSONObjectPai(Value: TJSONObject): iCadastrarNumero;
begin
  Result := Self;
  FJSONObjectPai := Value;
end;

function TCadastrarNumero.JSONObjectPai: TJSONObject;
begin
  Result := FJSONObjectPai;
end;

function TCadastrarNumero.Post: iCadastrarNumero;
Var
  I : Integer;
begin
  FJSONArrayNumero  := FJSONObjectPai.GetValue('numero') as TJSONArray;
  FJSONObjectNumero := FJSONArrayNumero.Items[I] as TJSONObject;
  try
    //verifico se consta este n�mero cadastrado na tabela numero(se n�o estiver insiro o mesmo)
    if not FController
             .FactoryPesquisar
               .PesquisarNumero
               .Getby(FNumero.IdEndereco, FJSONObjectNumero.GetValue<String>('numeroendereco')).Found then
    begin
      //Inserindo dados na tabela numero
      FController
        .FactoryDAO
          .DAONumero
            .This
              .IdEndereco         (FNumero.IdEndereco)
              .NumeroEndereco     (FJSONObjectNumero.GetValue<String>('numeroendereco'))
              .ComplementoEndereco(FJSONObjectNumero.GetValue<String>('complementoendereco'))
            .&End
          .Post;

       //Inserindo o numero com idempresa, caso n�o existir
       CadastrarEnderecoEmpresa;
    end;
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar alterar n�mero da tabela numero: ' + E.Message);
      FError := True;
    end;
  end;
end;

function TCadastrarNumero.Error: Boolean;
begin
  Result := FError;
end;

//Inje��o de depend�ncia
function TCadastrarNumero.Numero: iEntidadeNumero<iCadastrarNumero>;
begin
  Result := FNumero;
end;

//cadastro enderecoempresa-relacionamento entre endereco e empresa
procedure TCadastrarNumero.CadastrarEnderecoEmpresa;
begin
  FController
    .FactoryCadastrar
      .CadastrarEnderecoEmpresa
        .EnderecoEmpresa
          .IdEmpresa(FEmpresa.Id)
          .IdEndereco(FNumero.IdEndereco)
        .&End
      .JSONObjectPai(FJSONObjectNumero)
      .Post;
end;

function TCadastrarNumero.Empresa: iEntidadeEmpresa<iCadastrarNumero>;
begin
  Result := FEmpresa;
end;

function TCadastrarNumero.&End: iCadastrarNumero;
begin
  Result := Self;
end;

end.
