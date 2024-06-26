{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 13/03/2024 17:18           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Imp.Usuario;

interface

uses
  Model.Entidade.Usuario.Interfaces;

type
  TEntidadeUsuario<T : iInterface> = class(TInterfacedObject, iEntidadeUsuario<T>)
    private
      [weak]
      FParent          : T;
      FId              : Integer;
      FIdEmpresa       : Integer;
      FNomeUsuario     : String;
      FEMail           : String;
      FSenha           : String;
      FDataHoraEmissao : TDateTime;
      FAtivo           : Integer;
    public
      constructor Create(Parent : T);
      destructor Destroy; override;
      class function New(Parent : T): iEntidadeUsuario<T>;

      function Id             (Value : Integer)   : iEntidadeUsuario<T>; overload;
      function Id                                 : Integer;             overload;
      function IdEmpresa      (Value : Integer)   : iEntidadeUsuario<T>; overload;
      function IdEmpresa                          : Integer;             overload;
      function NomeUsuario    (Value : String)    : iEntidadeUsuario<T>; overload;
      function NomeUsuario                        : String;              overload;
      function Email          (Value : String)    : iEntidadeUsuario<T>; overload;
      function Email                              : String;              overload;
      function Senha          (Value : String)    : iEntidadeUsuario<T>; overload;
      function Senha                              : String;              overload;
      function DataHoraEmissao(Value : TDateTime) : iEntidadeUsuario<T>; overload;
      function DataHoraEmissao                    : TDateTime;           overload;
      function Ativo          (Value : Integer)   : iEntidadeUsuario<T>; overload;
      function Ativo                              : Integer;             overload;

      function &End : T;
  end;

implementation

{ TEntidadeUsuario<T> }

constructor TEntidadeUsuario<T>.Create(Parent: T);
begin
  FParent := Parent;
end;

destructor TEntidadeUsuario<T>.Destroy;
begin
  inherited;
end;

class function TEntidadeUsuario<T>.New(Parent: T): iEntidadeUsuario<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeUsuario<T>.Id(Value: Integer): iEntidadeUsuario<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadeUsuario<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeUsuario<T>.IdEmpresa(Value: Integer): iEntidadeUsuario<T>;
begin
  Result := Self;
  FIdEmpresa := Value;
end;

function TEntidadeUsuario<T>.IdEmpresa: Integer;
begin
  Result := FIdEmpresa;
end;

function TEntidadeUsuario<T>.NomeUsuario(Value: String): iEntidadeUsuario<T>;
begin
  Result := Self;
  FNomeUsuario  := Value;
end;

function TEntidadeUsuario<T>.NomeUsuario: String;
begin
  Result := FNomeUsuario;
end;

function TEntidadeUsuario<T>.Email(Value: String): iEntidadeUsuario<T>;
begin
  Result := Self;
  FEmail := Value;
end;

function TEntidadeUsuario<T>.Email: String;
begin
  Result := FEmail;
end;

function TEntidadeUsuario<T>.Senha(Value: String): iEntidadeUsuario<T>;
begin
  Result := Self;
  FSenha := Value;
end;

function TEntidadeUsuario<T>.Senha: String;
begin
  Result := FSenha;
end;

function TEntidadeUsuario<T>.Ativo(Value: Integer): iEntidadeUsuario<T>;
begin
  Result := Self;
  FAtivo := Value;
end;

function TEntidadeUsuario<T>.DataHoraEmissao(Value: TDateTime): iEntidadeUsuario<T>;
begin
  Result := Self;
  FDataHoraEmissao := Value;
end;

function TEntidadeUsuario<T>.DataHoraEmissao: TDateTime;
begin
  Result := FDataHoraEmissao;
end;

function TEntidadeUsuario<T>.Ativo: Integer;
begin
  Result := FAtivo;
end;

function TEntidadeUsuario<T>.&End: T;
begin
  Result := FParent;
end;

end.
