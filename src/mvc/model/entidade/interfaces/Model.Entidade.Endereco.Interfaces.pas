{*******************************************************}
{                    API PDV - JSON                     }
{                     Be More Web                       }
{          In�cio do projeto 18/03/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Endereco.Interfaces;

interface

uses
  Model.Entidade.Municipio.Interfaces;

type
  iEntidadeEndereco<T> =  interface
    ['{47CC0B6E-D387-45D8-B4D9-389C7867FF68}']
    function Id            (Value : Integer) : iEntidadeEndereco<T>; overload;
    function Id                              : Integer;              overload;
    function Cep           (Value : String)  : iEntidadeEndereco<T>; overload;
    function Cep                             : String;               overload;
    function TipoLogradouro(Value : String)  : iEntidadeEndereco<T>; overload;
    function TipoLogradouro                  : String;               overload;
    function Logradouro    (Value : String)  : iEntidadeEndereco<T>; overload;
    function Logradouro                      : String;               overload;
    function Bairro        (Value : String)  : iEntidadeEndereco<T>; overload;
    function Bairro                          : String;               overload;
    function IBGE          (Value : Integer) : iEntidadeEndereco<T>; overload;
    function IBGE                            : Integer;              overload;
    function UF            (Value : String)  : iEntidadeEndereco<T>; overload;
    function UF                              : String;               overload;
    function GIA           (Value : Integer) : iEntidadeEndereco<T>; overload;
    function GIA                             : Integer;              overload;
    function DDD           (Value : String)  : iEntidadeEndereco<T>; overload;
    function DDD                             : String;               overload;

    //Inje��o de depend�ncia
    function Municipio : iEntidadeMunicipio<iEntidadeEndereco<T>>;
    function &End : T;
  end;

implementation

end.
