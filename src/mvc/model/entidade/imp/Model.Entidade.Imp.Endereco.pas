{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 18/03/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Imp.Endereco;

interface

uses
  Model.Entidade.Endereco.Interfaces,
  Model.Entidade.Municipio.Interfaces;

type
  TEntidadeEndereco<T : iInterface> = class(TInterfacedObject, iEntidadeEndereco<T>)
    private
      [weak]
      FParent         : T;
      FId             : Integer;
      FCep            : String;
      FTipoLogradouro : String;
      FLogradouro     : String;
      FBairro         : String;
      FIBGE           : Integer;
      FUF             : String;
      FGIA            : Integer;
      FDDD            : String;

      FMunicipio      : iEntidadeMunicipio<iEntidadeEndereco<T>>;
    public
      constructor Create(Parent : T);
      destructor Destroy; override;
      class function New(Parent : T) : iEntidadeEndereco<T>;

      function Id            (Value : Integer) : iEntidadeEndereco<T>; overload;
      function Id                              : Integer;              overload;
      function Cep           (Value : String)  : iEntidadeEndereco<T>; overload;
      function Cep                             : String;               overload;
      function TipoLogradouro(Value : String)  : iEntidadeEndereco<T>; overload;
      function TipoLogradouro                  : String;               overload;
      function Logradouro    (Value : String)  : iEntidadeEndereco<T>; overload;
      function Logradouro                      : String;               overload;
      function Bairro        (Value : String)  : iEntidadeEndereco<T>; overload;
      function Bairro                          : String;               overload;
      function IBGE          (Value : Integer) : iEntidadeEndereco<T>; overload;
      function IBGE                            : Integer;              overload;
      function UF            (Value : String)  : iEntidadeEndereco<T>; overload;
      function UF                              : String;               overload;
      function GIA           (Value : Integer) : iEntidadeEndereco<T>; overload;
      function GIA                             : Integer;              overload;
      function DDD           (Value : String)  : iEntidadeEndereco<T>; overload;
      function DDD                             : String;               overload;

      //Inje��o de depend�ncia
      function Municipio : iEntidadeMunicipio<iEntidadeEndereco<T>>;
      function &End : T;
  end;


implementation

uses
  Model.Entidade.Imp.Municipio;

{ TEntidadeEndereco<T> }
constructor TEntidadeEndereco<T>.Create(Parent: T);
begin
  FParent    := Parent;
  FMunicipio := TEntidadeMunicipio<iEntidadeEndereco<T>>.New(Self);
end;

destructor TEntidadeEndereco<T>.Destroy;
begin
  inherited;
end;

class function TEntidadeEndereco<T>.New(Parent: T): iEntidadeEndereco<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeEndereco<T>.Id(Value: Integer): iEntidadeEndereco<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadeEndereco<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeEndereco<T>.Cep(Value: String): iEntidadeEndereco<T>;
begin
  Result := Self;
  FCep   := Value;
end;

function TEntidadeEndereco<T>.Cep: String;
begin
  Result := FCep;
end;

function TEntidadeEndereco<T>.TipoLogradouro(Value: String): iEntidadeEndereco<T>;
begin
  Result := Self;
  FTipoLogradouro := Value;
end;

function TEntidadeEndereco<T>.TipoLogradouro: String;
begin
  Result := FTipoLogradouro;
end;

function TEntidadeEndereco<T>.Logradouro(Value: String): iEntidadeEndereco<T>;
begin
  Result := Self;
  FLogradouro := Value;
end;

function TEntidadeEndereco<T>.Logradouro: String;
begin
  Result := FLogradouro;
end;

function TEntidadeEndereco<T>.Bairro(Value: String): iEntidadeEndereco<T>;
begin
  Result := Self;
  FBairro := Value;
end;

function TEntidadeEndereco<T>.Bairro: String;
begin
  Result := FBairro;
end;

function TEntidadeEndereco<T>.IBGE(Value: Integer): iEntidadeEndereco<T>;
begin
  Result := Self;
  FIBGE  := Value;
end;

function TEntidadeEndereco<T>.IBGE: Integer;
begin
  Result := FIBGE;
end;

function TEntidadeEndereco<T>.UF(Value: String): iEntidadeEndereco<T>;
begin
  Result := Self;
  FUF    := Value;
end;

function TEntidadeEndereco<T>.UF: String;
begin
  Result := FUF;
end;

function TEntidadeEndereco<T>.GIA(Value: Integer): iEntidadeEndereco<T>;
begin
  Result := Self;
  FGIA   := Value;
end;

function TEntidadeEndereco<T>.GIA: Integer;
begin
  Result := FGIA;
end;

function TEntidadeEndereco<T>.DDD(Value: String): iEntidadeEndereco<T>;
begin
  Result := Self;
  FDDD   := Value;
end;

function TEntidadeEndereco<T>.DDD: String;
begin
  Result := FDDD;
end;

function TEntidadeEndereco<T>.Municipio: iEntidadeMunicipio<iEntidadeEndereco<T>>;
begin
  Result := FMunicipio;
end;

function TEntidadeEndereco<T>.&End: T;
begin
  Result := FParent;
end;

end.
