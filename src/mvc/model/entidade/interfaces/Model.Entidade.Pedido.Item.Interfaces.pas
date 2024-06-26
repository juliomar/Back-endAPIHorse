{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 22/04/2024 12:08           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Pedido.Item.Interfaces;

interface

uses
  Model.Entidade.Produto.Interfaces;

type
  iEntidadePedidoItem<T> = interface
    ['{0F6C0C30-FBCC-4E65-B28A-2958D3F1020D}']
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
    function Produto : iEntidadeProduto<iEntidadePedidoItem<T>>;

    function &End : T;
  end;

implementation

end.
