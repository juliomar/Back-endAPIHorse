{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 26/04/2024 17:41           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Cadastrar.Empresa;

interface

uses
  Data.DB,
  System.JSON,
  FireDAC.Comp.Client,

  DataSet.Serialize,
  Controller.Interfaces,
  Model.Cadastrar.Empresa.Interfaces,
  Model.Entidade.Empresa.Interfaces;

type
  TCadastrarEmpresa = class(TInterfacedObject, iCadastrarEmpresa)
    private
      FController : iController;
      FEmpresa    : iEntidadeEmpresa<iCadastrarEmpresa>;

      FJSONObject        : TJSONObject;
      FJSONArrayEmpresa  : TJSONArray;
      FJSONObjectEmpresa : TJSONObject;

      FDSEmpresa  : TDataSource;
      FIdEmpresa  : Integer;
      FDMemTable  : TFDMemTable;

      FError : Boolean;

      function CadastrarEndereco : Boolean;
      function CadastrarEmail    : Boolean;
      function CadastrarTelefone : Boolean;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iCadastrarEmpresa;

      function JSONObject(Value : TJSONObject) : iCadastrarEmpresa; overload;
      function JSONObject                      : TJSONObject;       overload;
      function Post   : Boolean;

      function Error : Boolean;
      //inje��o de depend�ncia
      function Empresa : iEntidadeEmpresa<iCadastrarEmpresa>;
      function &End    : iCadastrarEmpresa;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Empresa, System.SysUtils;

{ TCadastrarEmpresa }

constructor TCadastrarEmpresa.Create;
begin
  FController := TController.New;
  FEmpresa    := TEntidadeEmpresa<iCadastrarEmpresa>.New(Self);
  FDSEmpresa  := TDataSource.Create(nil);
  FDMemTable  := TFDMemTable.Create(nil);
  FError := False;
end;

destructor TCadastrarEmpresa.Destroy;
begin
  inherited;
end;

class function TCadastrarEmpresa.New: iCadastrarEmpresa;
begin
  Result := Self.Create;
end;

function TCadastrarEmpresa.JSONObject(Value: TJSONObject): iCadastrarEmpresa;
begin
  Result := Self;
  FJSONObject := Value;
end;

function TCadastrarEmpresa.JSONObject: TJSONObject;
begin
  Result := FJSONObject;
end;

function TCadastrarEmpresa.Post: Boolean;
begin
  Result := False;
  try
    if not FController
            .FactoryPesquisar
              .PesquisarEmpresa
                .GetbyCNPJ(FEmpresa.CNPJ)
                  .Found then
    begin
      FDMemTable.LoadFromJSON(FController
                      .FactoryDePara
                        .DeParaReceitaWSEmpresa
                          .ConsultarDadosPorCNPJ(FEmpresa.CNPJ).Format());
      FController
       .FactoryDAO
         .DAOEmpresa
           .This
             .CNPJ                 (FDMemTable.FieldByName('cnpj').AsString)
             .InscricaoEstadual    ('Isento')
             .NomeEmpresarial      (FDMemTable.FieldByName('nome').AsString)
             .NomeFantasia         (FDMemTable.FieldByName('fantasia').AsString)
             .IdNaturezaJuridica   (2)
             .DataHoraEmissao      (Now)
             .DataSituacaoCadastral(StrToDate(FDMemTable.FieldByName('abertura').AsString))
             .Ativo                (1)
           .&End
         .Post
         .DataSet(FDSEmpresa);
      FEmpresa.Id(FDSEmpresa.DataSet.FieldByName('id').AsInteger);
      FIdEmpresa := FEmpresa.Id;

      //Chamo o cadastrar endereco; email e telefone na sequ�ncia
      if not CadastrarEndereco then
        if not CadastrarEmail then
          CadastrarTelefone;
    end
    else
      Result := True;
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar incluir registro na tabela empresa, consultar TDAOEmpresa: ' + E.Message);
      FError := True;
    end;
  end;
end;

function TCadastrarEmpresa.Error: Boolean;
begin
  Result := FError;
end;

//Inje��o de depend�ncia
function TCadastrarEmpresa.Empresa: iEntidadeEmpresa<iCadastrarEmpresa>;
begin
  Result := FEmpresa;
end;

function TCadastrarEmpresa.&End: iCadastrarEmpresa;
begin
  Result := Self;
end;

//cadastrar endereco essas declara��es est�o somente na classe
function TCadastrarEmpresa.CadastrarEndereco : Boolean;
begin
  Result := False;
  Result := FController
              .FactoryCadastrar
                .CadastrarEndereco
                  .Empresa.Id(FIdEmpresa)
                  .&End
                .JSONObjectPai(FJSONObjectEmpresa)
                .Post
                .Error;
end;

function TCadastrarEmpresa.CadastrarEmail: Boolean;
begin
  //Obt�m os dados JSON do corpo da requisi��o da tabela('emailempresa')
  Result := False;
  Result := FController
              .FactoryCadastrar
                .CadastrarEmailEmpresa
                  .EmailEmpresa
                  .IdEmpresa(FIdEmpresa)
                  .&End
                .JSONObjectPai(FJSONObjectEmpresa)
                .Post
                .Error;
end;
//cadastrar telefone
function TCadastrarEmpresa.CadastrarTelefone: Boolean;
begin
  //Obt�m os dados JSON do corpo da requisi��o da tabela('emailempresa')
  Result := False;
  Result := FController
              .FactoryCadastrar
                .CadastrarTelefoneEmpresa
                  .TelefoneEmpresa
                  .IdEmpresa(FIdEmpresa)
                  .&End
                .JSONObjectPai(FJSONObjectEmpresa)
                .Post
                .Error;
end;

end.
