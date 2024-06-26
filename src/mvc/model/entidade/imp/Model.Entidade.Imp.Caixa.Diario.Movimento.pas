{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 22/04/2024 12:08           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Imp.Caixa.Diario.Movimento;

interface

uses
  Model.Entidade.Caixa.Diario.Movimento.Interfaces,
  Model.Entidade.Usuario.Interfaces;

type
  TEntidadeCaixaDiarioMovimento<T : iInterface> = class(TInterfacedObject, iEntidadeCaixaDiarioMovimento<T>)
    private
      [weak]
      FParent           : T;
      FId               : Integer;
      FIdCaixaDiario    : Integer;
      FIdPedido         : Integer;
      FIdFormaPagamento : Integer;
      FIdUsuario        : Integer;
      FValorLancamento  : Currency;
      FCreditoDebito    : String;
      FDataHoraEmissao  : TDateTime;
      FTipoLancamento   : String;

      FUsuario  : iEntidadeUsuario<iEntidadeCaixaDiarioMovimento<T>>;
    public
      constructor Create(Parent : T);
      destructor Destroy; override;
      class function New(Parent : T) : iEntidadeCaixaDiarioMovimento<T>;

      function Id              (Value : Integer)   : iEntidadeCaixaDiarioMovimento<T>; overload;
      function Id                                  : Integer;                          overload;
      function IdCaixaDiario   (Value : Integer)   : iEntidadeCaixaDiarioMovimento<T>; overload;
      function IdCaixaDiario                       : Integer;                          overload;
      function IdPedido        (Value : Integer)   : iEntidadeCaixaDiarioMovimento<T>; overload;
      function IdPedido                            : Integer;                          overload;
      function IdFormaPagamento(Value : Integer)   : iEntidadeCaixaDiarioMovimento<T>; overload;
      function IdFormaPagamento                    : Integer;                          overload;
      function IdUsuario       (Value : Integer)   : iEntidadeCaixaDiarioMovimento<T>; overload;
      function IdUsuario                           : Integer;                          overload;
      function ValorLancamento (Value : Currency)  : iEntidadeCaixaDiarioMovimento<T>; overload;
      function ValorLancamento                     : Currency;                         overload;
      function CreditoDebito   (Value : String)    : iEntidadeCaixaDiarioMovimento<T>; overload;
      function CreditoDebito                       : String;                           overload;
      function DataHoraEmissao (Value : TDateTime) : iEntidadeCaixaDiarioMovimento<T>; overload;
      function DataHoraEmissao                     : TDateTime;                        overload;
      function TipoLancamento  (Value : String)    : iEntidadeCaixaDiarioMovimento<T>; overload;
      function TipoLancamento                      : String;                           overload;

      //Inje��o de deped�ncia
      function Usuario  : iEntidadeUsuario<iEntidadeCaixaDiarioMovimento<T>>;
      function &End : T;
  end;

implementation

{ TEntidadeCaixaDiarioMovimento<T> }

constructor TEntidadeCaixaDiarioMovimento<T>.Create(Parent: T);
begin
  FParent := Parent;
end;

destructor TEntidadeCaixaDiarioMovimento<T>.Destroy;
begin
  inherited;
end;

class function TEntidadeCaixaDiarioMovimento<T>.New(Parent: T): iEntidadeCaixaDiarioMovimento<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeCaixaDiarioMovimento<T>.Id(Value: Integer): iEntidadeCaixaDiarioMovimento<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadeCaixaDiarioMovimento<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeCaixaDiarioMovimento<T>.IdCaixaDiario(Value: Integer): iEntidadeCaixaDiarioMovimento<T>;
begin
  Result := Self;
  FIdCaixaDiario := Value;
end;

function TEntidadeCaixaDiarioMovimento<T>.IdCaixaDiario: Integer;
begin
  Result := FIdCaixaDiario;
end;

function TEntidadeCaixaDiarioMovimento<T>.IdPedido(Value: Integer): iEntidadeCaixaDiarioMovimento<T>;
begin
  Result := Self;
  FIdPedido := Value;
end;

function TEntidadeCaixaDiarioMovimento<T>.IdPedido: Integer;
begin
  Result := FIdPedido;
end;

function TEntidadeCaixaDiarioMovimento<T>.IdFormaPagamento(Value: Integer): iEntidadeCaixaDiarioMovimento<T>;
begin
  Result := Self;
  FIdFormaPagamento :=Value;
end;

function TEntidadeCaixaDiarioMovimento<T>.IdFormaPagamento: Integer;
begin
  Result := FIdFormaPagamento;
end;

function TEntidadeCaixaDiarioMovimento<T>.IdUsuario(Value: Integer): iEntidadeCaixaDiarioMovimento<T>;
begin
  Result := Self;
  FIdUsuario := Value;
end;

function TEntidadeCaixaDiarioMovimento<T>.IdUsuario: Integer;
begin
  Result := FIdUsuario;
end;

function TEntidadeCaixaDiarioMovimento<T>.ValorLancamento(Value: Currency): iEntidadeCaixaDiarioMovimento<T>;
begin
  Result := Self;
  FValorLancamento := Value;
end;

function TEntidadeCaixaDiarioMovimento<T>.ValorLancamento: Currency;
begin
  Result := FValorLancamento;
end;

function TEntidadeCaixaDiarioMovimento<T>.CreditoDebito(Value: String): iEntidadeCaixaDiarioMovimento<T>;
begin
  Result := Self;
  FCreditoDebito := Value;
end;

function TEntidadeCaixaDiarioMovimento<T>.CreditoDebito: String;
begin
  Result := FCreditoDebito;
end;

function TEntidadeCaixaDiarioMovimento<T>.DataHoraEmissao: TDateTime;
begin
  Result := FDataHoraEmissao;
end;

function TEntidadeCaixaDiarioMovimento<T>.DataHoraEmissao(Value: TDateTime): iEntidadeCaixaDiarioMovimento<T>;
begin
  Result := Self;
  FDataHoraEmissao := Value;
end;

function TEntidadeCaixaDiarioMovimento<T>.TipoLancamento(Value: String): iEntidadeCaixaDiarioMovimento<T>;
begin
  Result := Self;
  FTipoLancamento := Value;
end;

function TEntidadeCaixaDiarioMovimento<T>.TipoLancamento: String;
begin
  Result := FTipoLancamento;
end;

//Inje��o de depend�ncia
function TEntidadeCaixaDiarioMovimento<T>.Usuario: iEntidadeUsuario<iEntidadeCaixaDiarioMovimento<T>>;
begin
  Result := FUsuario;
end;

function TEntidadeCaixaDiarioMovimento<T>.&End: T;
begin
  Result := FParent;
end;

end.
