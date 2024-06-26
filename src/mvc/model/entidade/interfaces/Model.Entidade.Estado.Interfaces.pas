{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 08/04/2024 18:12           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Estado.Interfaces;

interface

uses
  Model.Entidade.Regiao.Estado.Interfaces;

type
  iEntidadeEstado<T> = interface
    ['{4E1147EB-7019-4239-8FB5-9A3CA5EF2252}']
    function Id       (Value : Integer) : iEntidadeEstado<T>; overload;
    function Id                         : Integer;            overload;
    function IdEstado (Value : Integer) : iEntidadeEstado<T>; overload;
    function IdEstado                   : Integer;            overload;
    function IdRegiao (Value : Integer) : iEntidadeEstado<T>; overload;
    function IdRegiao                   : Integer;            overload;
    function Estado   (Value : String)  : iEntidadeEstado<T>; overload;
    function Estado                     : String;             overload;
    function UF       (Value : String)  : iEntidadeEstado<T>; overload;
    function UF                         : String;             overload;

    //Inje��o de depend�ncia
    function RegiaoEstado : iEntidadeRegiaoEstado<iEntidadeEstado<T>>;

    function &End : T;
  end;

implementation

end.
