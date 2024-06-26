{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 22/04/2024 11:12           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Caixa.Diario.Movimento.Interfaces;

interface

uses
  Model.Entidade.Usuario.Interfaces;

type
  iEntidadeCaixaDiarioMovimento<T> = interface
    ['{DB6E00D2-0959-44D7-B8F8-6505417F743F}']
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

    //Inje��o de depend�ncia
    function Usuario  : iEntidadeUsuario<iEntidadeCaixaDiarioMovimento<T>>;

    function &End : T;
  end;

implementation

end.
