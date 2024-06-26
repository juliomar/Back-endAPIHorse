{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 30/04/2024 14:18           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Cadastrar.Pessoa;

interface

uses
  Data.DB,
  System.JSON,
  System.SysUtils,

  DataSet.Serialize,
  Controller.Interfaces,
  Model.Cadastrar.Pessoa.Interfaces,
  Model.Entidade.Pessoa.Interfaces;

type
  TCadastrarPessoa = class(TInterfacedObject, iCadastrarPessoa)
    private
      FController : iController;
      FPessoa     : iEntidadePessoa<iCadastrarPessoa>;

      FJSONObject       : TJSONObject;
      FJSONArrayPessoa  : TJSONArray;
      FJSONObjectPessoa : TJSONObject;

      FDSPessoa  : TDataSource;
      FIdPessoa  : Integer;
      FIdEmpresa : Integer;

      FFound : Boolean;
      FError : Boolean;

      function CadastrarEndereco : Boolean;
      function CadastrarEmail    : Boolean;
      function CadastrarTelefone : Boolean;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iCadastrarPessoa;

      function JSONObject(Value : TJSONObject) : iCadastrarPessoa; overload;
      function JSONObject                      : TJSONObject;      overload;
      function Post   : iCadastrarPessoa;

      function Found : Boolean;
      function Error : Boolean;
      //inje��o de depend�ncia
      function Pessoa : iEntidadePessoa<iCadastrarPessoa>;
      function &End   : iCadastrarPessoa;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Pessoa;

{ TCadastrarPessoa }

constructor TCadastrarPessoa.Create;
begin
  FController := TController.New;
  FPessoa     := TEntidadePessoa<iCadastrarPessoa>.New(Self);
  FDSPessoa   := TDataSource.Create(nil);

  FFound := False;
  FError := False;
end;

destructor TCadastrarPessoa.Destroy;
begin
  inherited;
end;

class function TCadastrarPessoa.New: iCadastrarPessoa;
begin
  Result := Self.Create;
end;

function TCadastrarPessoa.JSONObject(Value: TJSONObject): iCadastrarPessoa;
begin
  Result := Self;
  FJSONObject := Value;
end;

function TCadastrarPessoa.JSONObject: TJSONObject;
begin
  Result := FJSONObject;
end;

function TCadastrarPessoa.Post: iCadastrarPessoa;
begin
  Result := Self;
  try
    if not FController
            .FactoryPesquisar
              .PesquisarPessoa
                .GetbyCPFCNPJ(FPessoa.CPFCNPJ)
                  .Found then
    begin
      FJSONObjectPessoa := FJSONObject;
      FController
          .FactoryDAO
            .DAOPessoa
              .This
                .IdEmpresa      (FJSONObjectPessoa.GetValue<Integer>  ('idempresa'))
                .IdUsuario      (FJSONObjectPessoa.GetValue<Integer>  ('idusuario'))
                .CPFCNPJ        (FJSONObjectPessoa.GetValue<String>   ('cpfcnpj'))
                .RGIE           (FJSONObjectPessoa.GetValue<String>   ('rgie'))
                .NomePessoa     (FJSONObjectPessoa.GetValue<String>   ('nomepessoa'))
                .SobreNome      (FJSONObjectPessoa.GetValue<String>   ('sobrenome'))
                .FisicaJuridica (FJSONObjectPessoa.GetValue<String>   ('fisicajuridica'))
                .Sexo           (FJSONObjectPessoa.GetValue<String>   ('sexo'))
                .TipoPessoa     (FJSONObjectPessoa.GetValue<String>   ('tipopessoa'))
                .DataHoraEmissao(FJSONObjectPessoa.GetValue<TDateTime>('dataemissao'))
                .DataNascimento (FJSONObjectPessoa.GetValue<TDateTime>('datanascimento'))
                .Ativo          (1)
              .&End
            .Post
            .DataSet(FDSPessoa);
        FIdPessoa  := FDSPessoa.DataSet.FieldByName('id').AsInteger;
        FIdEmpresa := FJSONObject.GetValue<Integer>('idempresa');

      //Chamo o cadastrar endereco; email e telefone na sequ�ncia
      if not CadastrarEndereco then
        if not CadastrarEmail then
          CadastrarTelefone;
    end;
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar incluir registro: ' + E.Message);
      FError := True;
    end;
  end;
end;

function TCadastrarPessoa.Found: Boolean;
begin
  Result := FFound;
end;

function TCadastrarPessoa.Error: Boolean;
begin
  Result := FError;
end;

//Inje��o de depend�ncia
function TCadastrarPessoa.Pessoa: iEntidadePessoa<iCadastrarPessoa>;
begin
  Result := FPessoa;
end;

function TCadastrarPessoa.&End: iCadastrarPessoa;
begin
  Result := Self;
end;

//cadastrar endereco essas declara��es est�o somente na classe
function TCadastrarPessoa.CadastrarEndereco : Boolean;
begin
  Result := False;
  Result := FController
              .FactoryCadastrar
                .CadastrarEndereco
                  .Pessoa.Id(FIdPessoa)
                  .&End
                .JSONObjectPai(FJSONObjectPessoa)
                .Post
                .Error;
end;

function TCadastrarPessoa.CadastrarEmail: Boolean;
begin
  //Obt�m os dados JSON do corpo da requisi��o da tabela('emailPessoa')
  Result := False;
  Result := FController
              .FactoryCadastrar
                .CadastrarEmailPessoa
                  .EmailPessoa
                  .IdPessoa(FIdPessoa)
                  .&End
                .JSONObjectPai(FJSONObjectPessoa)
                .Post
                .Error;
end;
//cadastrar telefone
function TCadastrarPessoa.CadastrarTelefone: Boolean;
begin
  //Obt�m os dados JSON do corpo da requisi��o da tabela('emailPessoa')
  Result := False;
  Result := FController
              .FactoryCadastrar
                .CadastrarTelefonePessoa
                  .TelefonePessoa
                  .IdPessoa(FIdPessoa)
                  .&End
                .JSONObjectPai(FJSONObjectPessoa)
                .Post
                .Error;
end;

end.
