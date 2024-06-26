{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 18/03/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Marca.Produto.Interfaces;

interface

type
  iEntidadeMarcaProduto<T> = interface
    ['{5A8F317C-50F0-4E4D-9FE1-F411B2381E29}']
    function Id       (Value : Integer)         : iEntidadeMarcaProduto<T>; overload;
    function Id                                 : Integer;                  overload;
    function IdEmpresa(Value : Integer)         : iEntidadeMarcaProduto<T>; overload;
    function IdEmpresa                          : Integer;                  overload;
    function IdUsuario(Value : Integer)         : iEntidadeMarcaProduto<T>; overload;
    function IdUsuario                          : Integer;                  overload;
    function NomeMarca(Value : String)          : iEntidadeMarcaProduto<T>; overload;
    function NomeMarca                          : String;                   overload;
    function DataHoraEmissao(Value : TDateTime) : iEntidadeMarcaProduto<T>; overload;
    function DataHoraEmissao                    : TDateTime;                overload;
    function Ativo    (Value : Integer)         : iEntidadeMarcaProduto<T>; overload;
    function Ativo                              : Integer;                  overload;

    function &End : T;
  end;

implementation

end.
