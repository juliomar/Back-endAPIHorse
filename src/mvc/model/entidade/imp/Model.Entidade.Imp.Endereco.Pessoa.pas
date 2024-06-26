unit Model.Entidade.Imp.Endereco.Pessoa;

interface

uses
  Model.Entidade.Endereco.Pessoa.Interfaces,
  Model.Entidade.Endereco.Interfaces,
  Model.Entidade.Numero.Interfaces;

type
  TEntidadeEnderecoPessoa<T : iInterface> = class(TInterfacedObject, iEntidadeEnderecoPessoa<T>)
    private
      [weak]
      FParent     : T;
      FId         : Integer;
      FIdEmpresa  : Integer;
      FIdEndereco : Integer;
      FIdPessoa   : Integer;
      //Inje��o de depend�ncia
      FEndereco   : iEntidadeEndereco<iEntidadeEnderecoPessoa<T>>;
      FNumero     : iEntidadeNumero  <iEntidadeEnderecoPessoa<T>>;
    public
      constructor Create(Parent : T);
      destructor Destroy; override;
      class function New(Parent : T) : iEntidadeEnderecoPessoa<T>;

      function Id        (Value : Integer) : iEntidadeEnderecoPessoa<T>; overload;
      function Id                          : Integer;                    overload;
      function IdEmpresa (Value : Integer) : iEntidadeEnderecoPessoa<T>; overload;
      function IdEmpresa                   : Integer;                    overload;
      function IdEndereco(Value : Integer) : iEntidadeEnderecoPessoa<T>; overload;
      function IdEndereco                         : Integer;             overload;
      function IdPessoa  (Value : Integer) : iEntidadeEnderecoPessoa<T>; overload;
      function IdPessoa                    : Integer;                    overload;

      //Inje��o de depend�ncia
      function Endereco : iEntidadeEndereco<iEntidadeEnderecoPessoa<T>>;
      function Numero   : iEntidadeNumero  <iEntidadeEnderecoPessoa<T>>;

      function &End : T;
  end;

implementation

uses
  Model.Entidade.Imp.Endereco,
  Model.Entidade.Imp.Numero;

{ TEntidadeEnderecoPessoa<T> }

constructor TEntidadeEnderecoPessoa<T>.Create(Parent: T);
begin
  FParent := Parent;
  FEndereco := TEntidadeEndereco<iEntidadeEnderecoPessoa<T>>.New(Self);
  FNumero   := TEntidadeNumero  <iEntidadeEnderecoPessoa<T>>.New(Self);
end;

destructor TEntidadeEnderecoPessoa<T>.Destroy;
begin
  inherited;
end;

class function TEntidadeEnderecoPessoa<T>.New(Parent: T): iEntidadeEnderecoPessoa<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeEnderecoPessoa<T>.Id(Value: Integer): iEntidadeEnderecoPessoa<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadeEnderecoPessoa<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeEnderecoPessoa<T>.IdEmpresa(Value: Integer): iEntidadeEnderecoPessoa<T>;
begin
  Result := Self;
  FIdEmpresa := Value;
end;

function TEntidadeEnderecoPessoa<T>.IdEmpresa: Integer;
begin
  Result := FIdEmpresa;
end;

function TEntidadeEnderecoPessoa<T>.IdEndereco(Value: Integer): iEntidadeEnderecoPessoa<T>;
begin
  Result := Self;
  FIdEndereco := Value;
end;

function TEntidadeEnderecoPessoa<T>.IdEndereco: Integer;
begin
  Result := FIdEndereco;
end;

function TEntidadeEnderecoPessoa<T>.IdPessoa(Value: Integer): iEntidadeEnderecoPessoa<T>;
begin
  Result := Self;
  FIdPessoa := Value;
end;

function TEntidadeEnderecoPessoa<T>.IdPessoa: Integer;
begin
  Result := FIdPessoa;
end;

//Inicio Inje��o de depend�ncia
function TEntidadeEnderecoPessoa<T>.Endereco: iEntidadeEndereco<iEntidadeEnderecoPessoa<T>>;
begin
  Result := FEndereco;
end;

function TEntidadeEnderecoPessoa<T>.Numero: iEntidadeNumero<iEntidadeEnderecoPessoa<T>>;
begin
  Result := FNumero;
end;
//Fim inje��o de depend�ncia

function TEntidadeEnderecoPessoa<T>.&End: T;
begin
  Result := FParent;
end;

end.
