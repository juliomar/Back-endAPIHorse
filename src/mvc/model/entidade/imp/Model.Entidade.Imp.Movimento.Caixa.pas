{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 22/04/2024 12:08           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Imp.Movimento.Caixa;

interface

uses
  Model.Entidade.Movimento.Caixa.Interfaces,
  Model.Entidade.Usuario.Interfaces;

type
  TEntidadeMovimentoCaixa<T : iInterface> = class(TInterfacedObject, iEntidadeMovimentoCaixa<T>)
    private
      [weak]
      FParent           : T;
      FId               : Integer;
      FIdCaixa          : Integer;
      FIdPedido         : Integer;
      FIdFormaPagamento : Integer;
      FIdUsuario        : Integer;
      FValorLancado     : Currency;
      FCreditoDebito    : String;
      FDataHoraEmissao  : TDateTime;
      FTipoLancamento   : String;

      FUsuario  : iEntidadeUsuario<iEntidadeMovimentoCaixa<T>>;
    public
      constructor Create(Parent : T);
      destructor Destroy; override;
      class function New(Parent : T) : iEntidadeMovimentoCaixa<T>;

      function Id              (Value : Integer)   : iEntidadeMovimentoCaixa<T>; overload;
      function Id                                  : Integer;                    overload;
      function IdCaixa         (Value : Integer)   : iEntidadeMovimentoCaixa<T>; overload;
      function IdCaixa                             : Integer;                    overload;
      function IdPedido        (Value : Integer)   : iEntidadeMovimentoCaixa<T>; overload;
      function IdPedido                            : Integer;                    overload;
      function IdFormaPagamento(Value : Integer)   : iEntidadeMovimentoCaixa<T>; overload;
      function IdFormaPagamento                    : Integer;                    overload;
      function IdUsuario       (Value : Integer)   : iEntidadeMovimentoCaixa<T>; overload;
      function IdUsuario                           : Integer;                    overload;
      function ValorLancado    (Value : Currency)  : iEntidadeMovimentoCaixa<T>; overload;
      function ValorLancado                        : Currency;                   overload;
      function CreditoDebito   (Value : String)    : iEntidadeMovimentoCaixa<T>; overload;
      function CreditoDebito                       : String;                     overload;
      function DataHoraEmissao (Value : TDateTime) : iEntidadeMovimentoCaixa<T>; overload;
      function DataHoraEmissao                     : TDateTime;                  overload;
      function TipoLancamento  (Value : String)    : iEntidadeMovimentoCaixa<T>; overload;
      function TipoLancamento                      : String;                     overload;

      //Inje��o de deped�ncia
      function Usuario  : iEntidadeUsuario<iEntidadeMovimentoCaixa<T>>;
      function &End : T;
  end;

implementation

{ TEntidadeMovimentoCaixa<T> }

constructor TEntidadeMovimentoCaixa<T>.Create(Parent: T);
begin
  FParent := Parent;
end;

destructor TEntidadeMovimentoCaixa<T>.Destroy;
begin
  inherited;
end;

class function TEntidadeMovimentoCaixa<T>.New(Parent: T): iEntidadeMovimentoCaixa<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeMovimentoCaixa<T>.Id(Value: Integer): iEntidadeMovimentoCaixa<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadeMovimentoCaixa<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeMovimentoCaixa<T>.IdCaixa(Value: Integer): iEntidadeMovimentoCaixa<T>;
begin
  Result := Self;
  FIdCaixa := Value;
end;

function TEntidadeMovimentoCaixa<T>.IdCaixa: Integer;
begin
  Result := FIdCaixa;
end;

function TEntidadeMovimentoCaixa<T>.IdPedido(Value: Integer): iEntidadeMovimentoCaixa<T>;
begin
  Result := Self;
  FIdPedido := Value;
end;

function TEntidadeMovimentoCaixa<T>.IdPedido: Integer;
begin
  Result := FIdPedido;
end;

function TEntidadeMovimentoCaixa<T>.IdFormaPagamento(Value: Integer): iEntidadeMovimentoCaixa<T>;
begin
  Result := Self;
  FIdFormaPagamento :=Value;
end;

function TEntidadeMovimentoCaixa<T>.IdFormaPagamento: Integer;
begin
  Result := FIdFormaPagamento;
end;

function TEntidadeMovimentoCaixa<T>.IdUsuario(Value: Integer): iEntidadeMovimentoCaixa<T>;
begin
  Result := Self;
  FIdUsuario := Value;
end;

function TEntidadeMovimentoCaixa<T>.IdUsuario: Integer;
begin
  Result := FIdUsuario;
end;

function TEntidadeMovimentoCaixa<T>.ValorLancado(Value: Currency): iEntidadeMovimentoCaixa<T>;
begin
  Result := Self;
  FValorLancado := Value;
end;

function TEntidadeMovimentoCaixa<T>.ValorLancado: Currency;
begin
  Result := FValorLancado;
end;

function TEntidadeMovimentoCaixa<T>.CreditoDebito(Value: String): iEntidadeMovimentoCaixa<T>;
begin
  Result := Self;
  FCreditoDebito := Value;
end;

function TEntidadeMovimentoCaixa<T>.CreditoDebito: String;
begin
  Result := FCreditoDebito;
end;

function TEntidadeMovimentoCaixa<T>.DataHoraEmissao: TDateTime;
begin
  Result := FDataHoraEmissao;
end;

function TEntidadeMovimentoCaixa<T>.DataHoraEmissao(Value: TDateTime): iEntidadeMovimentoCaixa<T>;
begin
  Result := Self;
  FDataHoraEmissao := Value;
end;

function TEntidadeMovimentoCaixa<T>.TipoLancamento(Value: String): iEntidadeMovimentoCaixa<T>;
begin
  Result := Self;
  FTipoLancamento := Value;
end;

function TEntidadeMovimentoCaixa<T>.TipoLancamento: String;
begin
  Result := FTipoLancamento;
end;

//Inje��o de depend�ncia
function TEntidadeMovimentoCaixa<T>.Usuario: iEntidadeUsuario<iEntidadeMovimentoCaixa<T>>;
begin
  Result := FUsuario;
end;

function TEntidadeMovimentoCaixa<T>.&End: T;
begin
  Result := FParent;
end;

end.
