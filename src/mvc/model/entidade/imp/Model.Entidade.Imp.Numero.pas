unit Model.Entidade.Imp.Numero;

interface

uses
  Model.Entidade.Numero.Interfaces;

type
  TEntidadeNumero<T : iInterface> = class(TInterfacedObject, iEntidadeNumero<T>)
    private
      [weak]
      FParent              : T;
      FId                  : Integer;
      FIdEndereco          : Integer;
      FNumeroEndereco      : String;
      FComplementoEndereco : String;
    public
      constructor Create(Parent : T);
      destructor Destroy; override;
      class function New(Parent : T) : iEntidadeNumero<T>;

      function Id                 (Value : Integer) : iEntidadeNumero<T>; overload;
      function Id                                   : Integer;            overload;
      function IdEndereco         (Value : Integer) : iEntidadeNumero<T>; overload;
      function IdEndereco                           : Integer;            overload;
      function NumeroEndereco     (Value : String)  : iEntidadeNumero<T>; overload;
      function NumeroEndereco                       : String;             overload;
      function ComplementoEndereco(Value : String)  : iEntidadeNumero<T>; overload;
      function ComplementoEndereco                  : String;             overload;

      function &End : T;
  end;

implementation

{ TEntidadeNumero<T> }
constructor TEntidadeNumero<T>.Create(Parent: T);
begin
  FParent   := Parent;
end;

destructor TEntidadeNumero<T>.Destroy;
begin
  inherited;
end;

class function TEntidadeNumero<T>.New(Parent: T): iEntidadeNumero<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeNumero<T>.Id(Value: Integer): iEntidadeNumero<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadeNumero<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeNumero<T>.IdEndereco(Value: Integer): iEntidadeNumero<T>;
begin
  Result := Self;
  FIdEndereco := Value;
end;

function TEntidadeNumero<T>.IdEndereco: Integer;
begin
  Result := FIdEndereco;
end;

function TEntidadeNumero<T>.NumeroEndereco(Value: String): iEntidadeNumero<T>;
begin
  Result := Self;
  FNumeroEndereco := Value;
end;

function TEntidadeNumero<T>.NumeroEndereco: String;
begin
  Result := FNumeroEndereco;
end;

function TEntidadeNumero<T>.ComplementoEndereco(Value: String): iEntidadeNumero<T>;
begin
  Result := Self;
  FComplementoEndereco := Value;
end;

function TEntidadeNumero<T>.ComplementoEndereco: String;
begin
  Result := FComplementoEndereco;
end;

function TEntidadeNumero<T>.&End: T;
begin
  Result := FParent;
end;

end.
