{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 26/04/2024 16:08           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Caixa.Pedido.Interfaces;

interface

type
  iEntidadeCaixaPedido<T> = interface
    ['{B5FEFF61-4C34-4B0C-B747-0F84FFC75915}']
    function Id             (Value : Integer)   : iEntidadeCaixaPedido<T>; overload;
    function Id                                 : Integer;                 overload;
    function IdEmpresa      (Value : Integer)   : iEntidadeCaixaPedido<T>; overload;
    function IdEmpresa                          : Integer;                 overload;
    function IdCaixa        (Value : Integer)   : iEntidadeCaixaPedido<T>; overload;
    function IdCaixa                            : Integer;                 overload;
    function IdPedido       (Value : Integer)   : iEntidadeCaixaPedido<T>; overload;
    function IdPedido                           : Integer;                 overload;
    function IdUsuario      (Value : Integer)   : iEntidadeCaixaPedido<T>; overload;
    function IdUsuario                          : Integer;                 overload;
    function DataHoraEmissao(Value : TDateTime) : iEntidadeCaixaPedido<T>; overload;
    function DataHoraEmissao                    : TDateTime;               overload;

    function &End : T;
  end;

implementation

end.
