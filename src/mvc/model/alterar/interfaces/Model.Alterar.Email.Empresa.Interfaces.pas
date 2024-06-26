{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 30/04/2024 23:48           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Alterar.Email.Empresa.Interfaces;

interface

uses
  System.JSON,
  Model.Entidade.Email.Empresa.Interfaces;

type
  iAlterarEmailEmpresa = Interface
    ['{EE188DBA-8E22-4790-9B5B-019B99CB9264}']
    function JSONObject(Value : TJSONObject) : iAlterarEmailEmpresa; overload;
    function JSONObject                      : TJSONObject;          overload;
    function Put    : iAlterarEmailEmpresa;
    function Found  : Boolean;
    function Error  : Boolean;

    //inje��o de depend�ncia
    function EmailEmpresa : iEntidadeEmailEmpresa<iAlterarEmailEmpresa>;
    function &End         : iAlterarEmailEmpresa;
  End;

implementation

end.
