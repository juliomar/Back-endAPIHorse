{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 03/04/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2004/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Email.Empresa.Interfaces;

interface

type
   iEntidadeEmailEmpresa<T> = interface
     ['{AE1D7552-359F-4F2E-930F-6EF8244AB0A2}']
     function Id       (Value : Integer) : iEntidadeEmailEmpresa<T>; overload;
     function Id                         : Integer;                  overload;
     function IdEmpresa(Value : Integer) : iEntidadeEmailEmpresa<T>; overload;
     function IdEmpresa                  : Integer;                  overload;
     function Email    (Value : String)  : iEntidadeEmailEmpresa<T>; overload;
     function Email                      : String;                   overload;
     function TipoEmail(Value : String)  : iEntidadeEmailEmpresa<T>; overload;
     function TipoEmail                  : String;                   overload;
     function Ativo    (Value : Integer) : iEntidadeEmailEmpresa<T>; overload;
     function Ativo                      : Integer;                  overload;

     function &End : T;
   end;

implementation

end.
