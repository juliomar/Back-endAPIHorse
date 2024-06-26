{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 05/04/2024 09:19           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2004/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Telefone.Empresa.Interfaces;

interface

type
  iEntidadeTelefoneEmpresa<T> = interface
    ['{CB3C0BC3-B48F-4959-AEB1-2A604EF67D7F}']
    function Id           (Value : Integer)  : iEntidadeTelefoneEmpresa<T>; overload;
    function Id                              : Integer;                     overload;
    function IdEmpresa    (Value : Integer)  : iEntidadeTelefoneEmpresa<T>; overload;
    function IdEmpresa                       : Integer;                     overload;
    function Operadora      (Value : String) : iEntidadeTelefoneEmpresa<T>; overload;
    function Operadora                       : String;                      overload;
    function DDD            (Value : String) : iEntidadeTelefoneEmpresa<T>; overload;
    function DDD                             : String;                      overload;
    function NumeroTelefone(Value : String)  : iEntidadeTelefoneEmpresa<T>; overload;
    function NumeroTelefone                  : String;                      overload;
    function TipoTelefone  (Value : String)  : iEntidadeTelefoneEmpresa<T>; overload;
    function TipoTelefone                    : String;                      overload;
    function Ativo         (Value : Integer) : iEntidadeTelefoneEmpresa<T>; overload;
    function Ativo                           : Integer;                     overload;

    function &End : T;
  end;

implementation

end.
