{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 13/03/2024 17:18           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Usuario.Interfaces;

interface

type
  iEntidadeUsuario<T> = interface
    ['{D91381EF-2D7A-46E6-BFBE-9C697B9633BF}']
    function Id             (Value : Integer)   : iEntidadeUsuario<T>; overload;
    function Id                                 : Integer;             overload;
    function IdEmpresa      (Value : Integer)   : iEntidadeUsuario<T>; overload;
    function IdEmpresa                          : Integer;             overload;
    function NomeUsuario    (Value : String)    : iEntidadeUsuario<T>; overload;
    function NomeUsuario                        : String;              overload;
    function Email          (Value : String)    : iEntidadeUsuario<T>; overload;
    function Email                              : String;              overload;
    function Senha          (Value : String)    : iEntidadeUsuario<T>; overload;
    function Senha                              : String;              overload;
    function DataHoraEmissao(Value : TDateTime) : iEntidadeUsuario<T>; overload;
    function DataHoraEmissao                    : TDateTime;           overload;
    function Ativo          (Value : Integer)   : iEntidadeUsuario<T>; overload;
    function Ativo                              : Integer;             overload;

    function &End : T;
  end;

implementation

end.
