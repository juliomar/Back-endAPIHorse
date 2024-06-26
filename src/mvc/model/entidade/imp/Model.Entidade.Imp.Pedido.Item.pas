{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 22/04/2024 12:08           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Imp.Pedido.Item;

interface

uses
  Model.Entidade.Pedido.Item.Interfaces,
  Model.Entidade.Produto.Interfaces;

type
  TEntidadePedidoItem<T : iInterface> = class(TInterfacedObject, iEntidadePedidoItem<T>)
    private
      [weak]
      FParent            : T;
      FId                : Integer;
      FIdPedido          : Integer;
      FIdProduto         : Integer;
      FQuantidade        : Currency;
      FValorUnitario     : Currency;
      FValorProduto      : Currency;
      FValorDescontoItem : Currency;
      FValorReceber    : Currency;

      FProduto  : iEntidadeProduto<iEntidadePedidoItem<T>>;
    public
      constructor Create(Parent : T);
      destructor Destroy; override;
      class function New(Parent :T) : iEntidadePedidoItem<T>;

      function Id               (Value : Integer)  : iEntidadePedidoItem<T>; overload;
      function Id                                  : Integer;                overload;
      function IdPedido         (Value : Integer)  : iEntidadePedidoItem<T>; overload;
      function IdPedido                            : Integer;                overload;
      function IdProduto        (Value : Integer)  : iEntidadePedidoItem<T>; overload;
      function IdProduto                           : Integer;                overload;
      function Quantidade       (Value : Currency) : iEntidadePedidoItem<T>; overload;
      function Quantidade                          : Currency;               overload;
      function ValorUnitario    (Value : Currency) : iEntidadePedidoItem<T>; overload;
      function ValorUnitario                       : Currency;               overload;
      function ValorProduto     (Value : Currency) : iEntidadePedidoItem<T>; overload;
      function ValorProduto                        : Currency;               overload;
      function ValorDescontoItem(Value : Currency) : iEntidadePedidoItem<T>; overload;
      function ValorDescontoItem                   : Currency;               overload;
      function ValorReceber     (Value : Currency) : iEntidadePedidoItem<T>; overload;
      function ValorReceber                        : Currency;               overload;

      //Inje��o de depend�ncia
      function Produto  : iEntidadeProduto<iEntidadePedidoItem<T>>;

      function &End : T;
  end;

implementation

uses
  Model.Entidade.Imp.Produto;

{ TEntidadePedidoItem<T> }

constructor TEntidadePedidoItem<T>.Create(Parent: T);
begin
  FParent  := Parent;
  FProduto := TEntidadeProduto<iEntidadePedidoItem<T>>.New(Self);
end;

destructor TEntidadePedidoItem<T>.Destroy;
begin
  inherited;
end;

class function TEntidadePedidoItem<T>.New(Parent: T): iEntidadePedidoItem<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadePedidoItem<T>.Id(Value: Integer): iEntidadePedidoItem<T>;
begin
  Result := Self;
  FId    :=Value;
end;

function TEntidadePedidoItem<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadePedidoItem<T>.IdPedido(Value: Integer): iEntidadePedidoItem<T>;
begin
  Result := Self;
  FIdPedido := Value;
end;

function TEntidadePedidoItem<T>.IdPedido: Integer;
begin
  Result := FIdPedido;
end;

function TEntidadePedidoItem<T>.IdProduto(Value: Integer): iEntidadePedidoItem<T>;
begin
  Result := Self;
  FIdProduto := Value;
end;

function TEntidadePedidoItem<T>.IdProduto: Integer;
begin
  Result := FIdProduto;
end;

function TEntidadePedidoItem<T>.Quantidade(Value: Currency): iEntidadePedidoItem<T>;
begin
  Result := Self;
  FQuantidade := Value;
end;

function TEntidadePedidoItem<T>.Quantidade: Currency;
begin
  Result := FQuantidade;
end;

function TEntidadePedidoItem<T>.ValorUnitario(Value: Currency): iEntidadePedidoItem<T>;
begin
  Result := Self;
  FValorUnitario := Value;
end;

function TEntidadePedidoItem<T>.ValorUnitario: Currency;
begin
  Result := FValorUnitario;
end;

function TEntidadePedidoItem<T>.ValorProduto(Value: Currency): iEntidadePedidoItem<T>;
begin
  Result := Self;
  FValorProduto := Value;
end;

function TEntidadePedidoItem<T>.ValorProduto: Currency;
begin
  Result := FValorProduto;
end;

function TEntidadePedidoItem<T>.ValorDescontoItem(Value: Currency): iEntidadePedidoItem<T>;
begin
  Result := Self;
  FValorDescontoItem := Value;
end;

function TEntidadePedidoItem<T>.ValorDescontoItem: Currency;
begin
  Result := FValorDescontoItem;
end;

function TEntidadePedidoItem<T>.ValorReceber(Value: Currency): iEntidadePedidoItem<T>;
begin
  Result := Self;
  FValorReceber := Value;
end;

function TEntidadePedidoItem<T>.ValorReceber: Currency;
begin
  Result := FValorReceber;
end;

//Inje��o de depend�ncia
function TEntidadePedidoItem<T>.Produto: iEntidadeProduto<iEntidadePedidoItem<T>>;
begin
  Result := FProduto;
end;

function TEntidadePedidoItem<T>.&End: T;
begin
  Result := FParent;
end;

end.
