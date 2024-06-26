{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 22/04/2024 12:08           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Pedido.Interfaces;

interface

uses
  Model.Entidade.Pessoa.Interfaces;


type
  iEntidadePedido<T> = interface
    ['{9ADB11B4-C6A1-4733-BDCC-477527BB9623}']
    function Id                 (Value : Integer)   : iEntidadePedido<T>; overload;
    function Id                                     : Integer;            overload;
    function IdEmpresa          (Value : Integer)   : iEntidadePedido<T>; overload;
    function IdEmpresa                              : Integer;            overload;
    function IdCaixa            (Value : Integer)   : iEntidadePedido<T>; overload;
    function IdCaixa                                : Integer;            overload;
    function IdPessoa           (Value : Integer)   : iEntidadePedido<T>; overload;
    function IdPessoa                               : Integer;            overload;
    function IdCondicaoPagamento(Value : Integer)   : iEntidadePedido<T>; overload;
    function IdCondicaoPagamento                    : Integer;            overload;
    function IdUsuario          (Value : Integer)   : iEntidadePedido<T>; overload;
    function IdUsuario                              : Integer;            overload;
    function ValorProduto       (Value : Currency)  : iEntidadePedido<T>; overload;
    function ValorProduto                           : Currency;           overload;
    function ValorDesconto      (Value : Currency)  : iEntidadePedido<T>; overload;
    function ValorDesconto                          : Currency;           overload;
    function ValorReceber       (Value : Currency)  : iEntidadePedido<T>; overload;
    function ValorReceber                           : Currency;           overload;
    function ValorDescontoItem  (Value : Currency)  : iEntidadePedido<T>; overload;
    function ValorDescontoItem                      : Currency;           overload;
    function DataHoraEmissao    (Value : TDateTime) : iEntidadePedido<T>; overload;
    function DataHoraEmissao                        : TDateTime;          overload;
    function Status             (Value : Integer)   : iEntidadePedido<T>; overload;
    function Status                                 : Integer;            overload;
    function Excluido           (Value : Integer)   : iEntidadePedido<T>; overload;
    function Excluido                               : Integer;            overload;

    //Inje��o de depend�ncia
    function Pessoa  : iEntidadePessoa<iEntidadePedido<T>>;

    function &End : T;
  end;

implementation

end.
