{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 05/04/2024 09:19           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2004/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Imp.Telefone.Pessoa;

interface

uses
  Model.Entidade.Telefone.Pessoa.Interfaces;

type
  TEntidadeTelefonePessoa<T : iInterface> = class(TInterfacedObject, iEntidadeTelefonePessoa<T>)
    private
      [weak]
      FParent         : T;
      FId             : Integer;
      FIdPessoa       : Integer;
      FIdEmpresa      : Integer;
      FOperadora      : String;
      FDDD            : String;
      FNumeroTelefone : String;
      FTipoTelefone   : String;
      FAtivo          : Integer;
    public
      constructor Create(Parent : T);
      destructor Destroy; override;
      class function New(Parent : T) : iEntidadeTelefonePessoa<T>;

      function Id          (Value : Integer)   : iEntidadeTelefonePessoa<T>; overload;
      function Id                              : Integer;                    overload;
      function IdPessoa      (Value : Integer) : iEntidadeTelefonePessoa<T>; overload;
      function IdPessoa                        : Integer;                    overload;
      function IdEmpresa    (Value : Integer)  : iEntidadeTelefonePessoa<T>; overload;
      function IdEmpresa                       : Integer;                    overload;
      function Operadora    (Value : String)   : iEntidadeTelefonePessoa<T>; overload;
      function Operadora                       : String;                     overload;
      function DDD            (Value : String) : iEntidadeTelefonePessoa<T>; overload;
      function DDD                             : String;                     overload;
      function NumeroTelefone(Value : String)  : iEntidadeTelefonePessoa<T>; overload;
      function NumeroTelefone                  : String;                     overload;
      function TipoTelefone  (Value : String)  : iEntidadeTelefonePessoa<T>; overload;
      function TipoTelefone                    : String;                     overload;
      function Ativo          (Value : Integer): iEntidadeTelefonePessoa<T>; overload;
      function Ativo                           : Integer;                    overload;

      function &End : T;
  end;

implementation

constructor TEntidadeTelefonePessoa<T>.Create(Parent: T);
begin
  FParent := Parent;
end;

destructor TEntidadeTelefonePessoa<T>.Destroy;
begin
  inherited;
end;

class function TEntidadeTelefonePessoa<T>.New(Parent: T): iEntidadeTelefonePessoa<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeTelefonePessoa<T>.Id(Value: Integer): iEntidadeTelefonePessoa<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadeTelefonePessoa<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeTelefonePessoa<T>.IdPessoa(Value: Integer): iEntidadeTelefonePessoa<T>;
begin
  Result := Self;
  FIdPessoa := Value;
end;

function TEntidadeTelefonePessoa<T>.IdPessoa: Integer;
begin
  Result := FIdPessoa;
end;

function TEntidadeTelefonePessoa<T>.IdEmpresa(Value: Integer): iEntidadeTelefonePessoa<T>;
begin
  Result := Self;
  FIdEmpresa := Value;
end;

function TEntidadeTelefonePessoa<T>.IdEmpresa: Integer;
begin
  Result := FIdEmpresa;
end;

function TEntidadeTelefonePessoa<T>.Operadora(Value: String): iEntidadeTelefonePessoa<T>;
begin
  Result := Self;
  FOperadora := Value;
end;

function TEntidadeTelefonePessoa<T>.Operadora: String;
begin
  Result := FOperadora;
end;

function TEntidadeTelefonePessoa<T>.DDD(Value: String): iEntidadeTelefonePessoa<T>;
begin
  Result := Self;
  FDDD   := Value;
end;

function TEntidadeTelefonePessoa<T>.DDD: String;
begin
  Result := FDDD;
end;

function TEntidadeTelefonePessoa<T>.NumeroTelefone(Value: String): iEntidadeTelefonePessoa<T>;
begin
  Result := Self;
  FNumeroTelefone := Value;
end;

function TEntidadeTelefonePessoa<T>.NumeroTelefone: String;
begin
  Result := FNumeroTelefone;
end;

function TEntidadeTelefonePessoa<T>.TipoTelefone(Value: String): iEntidadeTelefonePessoa<T>;
begin
  Result := Self;
  FTipoTelefone := Value;
end;

function TEntidadeTelefonePessoa<T>.TipoTelefone: String;
begin
  Result := FTipoTelefone;
end;

function TEntidadeTelefonePessoa<T>.Ativo(Value: Integer): iEntidadeTelefonePessoa<T>;
begin
  Result := Self;
  FAtivo := Value;
end;

function TEntidadeTelefonePessoa<T>.Ativo: Integer;
begin
  Result := FAtivo;
end;

function TEntidadeTelefonePessoa<T>.&End: T;
begin
  Result := FParent;
end;

end.
