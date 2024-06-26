{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 05/04/2024 09:19           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2004/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Imp.Pessoa;

interface

uses
  Model.Entidade.Pessoa.Interfaces,
  Model.Entidade.Endereco.Pessoa.Interfaces,
  Model.Entidade.Email.Pessoa.Interfaces,
  Model.Entidade.Telefone.Pessoa.Interfaces;

type
  TEntidadePessoa<T : iInterface>= class (TInterfacedObject, iEntidadePessoa<T>)
    private
      [weak]
      FParent         : T;
      FId             : Integer;
      FIdEmpresa      : Integer;
      FIdUsuario      : Integer;
      FCPFCNPJ        : String;
      FRGIE           : String;
      FNomePessoa     : String;
      FSobreNome      : String;
      FFisicaJuridica : String;
      FSexo           : String;
      FTipoPessoa     : String;
      FDataHoraEmissao    : TDateTime;
      FDataNascimento : TDateTime;
      FAtivo          : Integer;

      FEnderecoPessoa : iEntidadeEnderecoPessoa<iEntidadePessoa<T>>;
      FEmailPessoa    : iEntidadeEmailPessoa   <iEntidadePessoa<T>>;
      FTelefonePessoa : iEntidadeTelefonePessoa<iEntidadePessoa<T>>;
    public
      constructor Create(Parent : T);
      destructor Destroy; override;
      class function New(Parent : T) : iEntidadePessoa<T>;

      function Id             (Value : Integer)   : iEntidadePessoa<T>; overload;
      function Id                                 : Integer;            overload;
      function IdEmpresa      (Value : Integer)   : iEntidadePessoa<T>; overload;
      function IdEmpresa                          : Integer;            overload;
      function IdUsuario       (Value : Integer)  : iEntidadePessoa<T>; overload;
      function IdUsuario                          : Integer;            overload;
      function CPFCNPJ        (Value : String)    : iEntidadePessoa<T>; overload;
      function CPFCNPJ                            : String;             overload;
      function RGIE           (Value : String)    : iEntidadePessoa<T>; overload;
      function RGIE                               : String;             overload;
      function NomePessoa     (Value : String)    : iEntidadePessoa<T>; overload;
      function NomePessoa                         : String;             overload;
      function SobreNome      (Value : String)    : iEntidadePessoa<T>; overload;
      function SobreNome                          : String;             overload;
      function FisicaJuridica (Value : String)    : iEntidadePessoa<T>; overload;
      function FisicaJuridica                     : String;             overload;
      function Sexo           (Value : String)    : iEntidadePessoa<T>; overload;
      function Sexo                               : String;             overload;
      function TipoPessoa     (Value : String)    : iEntidadePessoa<T>; overload;
      function TipoPessoa                         : String;             overload;
      function DataHoraEmissao(Value : TDateTime) : iEntidadePessoa<T>; overload;
      function DataHoraEmissao                    : TDateTime;          overload;
      function DataNascimento (Value : TDateTime) : iEntidadePessoa<T>; overload;
      function DataNascimento                     : TDateTime;          overload;
      function Ativo          (Value : Integer)   : iEntidadePessoa<T>; overload;
      function Ativo                              : Integer;            overload;


      //Inje��o de depend�ncia
      function EnderecoPessoa : iEntidadeEnderecoPessoa<iEntidadePessoa<T>>;
      function EmailPessoa    : iEntidadeEmailPessoa   <iEntidadePessoa<T>>;
      function TelefonePessoa : iEntidadeTelefonePessoa<iEntidadePessoa<T>>;

      function &End : T;
  end;

implementation

uses
  Model.Entidade.Imp.Endereco.Pessoa,
  Model.Entidade.Imp.Email.Pessoa,
  Model.Entidade.Imp.Telefone.Pessoa;

{ TEntidadePessoa<T> }

constructor TEntidadePessoa<T>.Create(Parent: T);
begin
  FParent := Parent;
  FEnderecoPessoa := TEntidadeEnderecoPessoa<iEntidadePessoa<T>>.New(Self);
  FEmailPessoa    := TEntidadeEmailPessoa   <iEntidadePessoa<T>>.New(Self);
  FTelefonePessoa := TEntidadeTelefonePessoa<iEntidadePessoa<T>>.New(Self);
end;

destructor TEntidadePessoa<T>.Destroy;
begin
  inherited;
end;

class function TEntidadePessoa<T>.New(Parent: T): iEntidadePessoa<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadePessoa<T>.Id(Value: Integer): iEntidadePessoa<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadePessoa<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadePessoa<T>.IdEmpresa(Value: Integer): iEntidadePessoa<T>;
begin
  Result     := Self;
  FIdEmpresa := Value;
end;

function TEntidadePessoa<T>.IdEmpresa: Integer;
begin
  Result := FIdEmpresa;
end;

function TEntidadePessoa<T>.IdUsuario(Value: Integer): iEntidadePessoa<T>;
begin
  Result     := Self;
  FIdUsuario := Value;
end;

function TEntidadePessoa<T>.IdUsuario: Integer;
begin
  Result := FIdUsuario;
end;

function TEntidadePessoa<T>.CPFCNPJ(Value: String): iEntidadePessoa<T>;
begin
  Result := Self;
  FCPFCNPJ := Value;
end;

function TEntidadePessoa<T>.CPFCNPJ: String;
begin
  Result := FCPFCNPJ;
end;

function TEntidadePessoa<T>.RGIE(Value: String): iEntidadePessoa<T>;
begin
  Result := Self;
  FRGIE  := Value;
end;

function TEntidadePessoa<T>.RGIE: String;
begin
  Result := FRGIE;
end;

function TEntidadePessoa<T>.NomePessoa(Value: String): iEntidadePessoa<T>;
begin
  Result := Self;
  FNomePessoa := Value;
end;

function TEntidadePessoa<T>.NomePessoa: String;
begin
  Result := FNomePessoa;
end;

function TEntidadePessoa<T>.SobreNome(Value: String): iEntidadePessoa<T>;
begin
  Result := Self;
  FSobreNome := Value;
end;

function TEntidadePessoa<T>.SobreNome: String;
begin
  Result := FSobreNome;
end;

function TEntidadePessoa<T>.FisicaJuridica(Value: String): iEntidadePessoa<T>;
begin
  Result := Self;
  FFisicaJuridica := Value;
end;

function TEntidadePessoa<T>.FisicaJuridica: String;
begin
  Result := FFisicaJuridica;
end;

function TEntidadePessoa<T>.Sexo(Value: String): iEntidadePessoa<T>;
begin
  Result := Self;
  FSexo  := Value;
end;

function TEntidadePessoa<T>.Sexo: String;
begin
  Result := FSexo;
end;

function TEntidadePessoa<T>.TipoPessoa(Value: String): iEntidadePessoa<T>;
begin
  Result := Self;
  FTipoPessoa := Value;
end;

function TEntidadePessoa<T>.TipoPessoa: String;
begin
  Result := FTipoPessoa;
end;

function TEntidadePessoa<T>.DataHoraEmissao(Value: TDateTime): iEntidadePessoa<T>;
begin
  Result := Self;
  FDataHoraEmissao := Value;
end;

function TEntidadePessoa<T>.DataHoraEmissao: TDateTime;
begin
  Result := FDataHoraEmissao;
end;

function TEntidadePessoa<T>.DataNascimento(Value: TDateTime): iEntidadePessoa<T>;
begin
  Result := Self;
  FDataNascimento := Value;
end;

function TEntidadePessoa<T>.DataNascimento: TDateTime;
begin
  Result := FDataNascimento;
end;

function TEntidadePessoa<T>.Ativo(Value: Integer): iEntidadePessoa<T>;
begin
  Result := Self;
  FAtivo := Value;
end;

function TEntidadePessoa<T>.Ativo: Integer;
begin
  Result := FAtivo;
end;

//Inje��o de depend�ncia
function TEntidadePessoa<T>.EnderecoPessoa: iEntidadeEnderecoPessoa<iEntidadePessoa<T>>;
begin
  Result := FEnderecoPessoa;
end;

function TEntidadePessoa<T>.EmailPessoa: iEntidadeEmailPessoa<iEntidadePessoa<T>>;
begin
  Result := FEmailPessoa;
end;

function TEntidadePessoa<T>.TelefonePessoa: iEntidadeTelefonePessoa<iEntidadePessoa<T>>;
begin
  Result := FTelefonePessoa;
end;

function TEntidadePessoa<T>.&End: T;
begin
  Result := FParent;
end;

end.
