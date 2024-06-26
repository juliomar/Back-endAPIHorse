{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 18/03/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Categoria.Produto.Interfaces;

interface

type
  iEntidadeCategoriaProduto<T> = interface
    ['{8EAA1FED-0229-492C-B7EB-1FCC725B9C7D}']
    function Id           (Value : Integer)     : iEntidadeCategoriaProduto<T>; overload;
    function Id                                 : Integer;                      overload;
    function IdEmpresa    (Value : Integer)     : iEntidadeCategoriaProduto<T>; overload;
    function IdEmpresa                          : Integer;                      overload;
    function IdUsuario    (Value : Integer)     : iEntidadeCategoriaProduto<T>; overload;
    function IdUsuario                          : Integer;                      overload;
    function NomeCategoria(Value : String)      : iEntidadeCategoriaProduto<T>; overload;
    function NomeCategoria                      : String;                       overload;
    function DataHoraEmissao(Value : TDateTime) : iEntidadeCategoriaProduto<T>; overload;
    function DataHoraEmissao                    : TDateTime;                    overload;
    function Ativo    (Value : Integer)         : iEntidadeCategoriaProduto<T>; overload;
    function Ativo                              : Integer;                      overload;

    function &End : T;
  end;

implementation

end.
