{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 01/05/2024 00:45           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Alterar.Endereco.Interfaces;

interface

uses
  System.JSON,
  Model.Entidade.Endereco.Interfaces;

type
  iAlterarEndereco = Interface
    ['{EE188DBA-8E22-4790-9B5B-019B99CB9264}']
    function JSONObject(Value : TJSONObject) : iAlterarEndereco; overload;
    function JSONObject                      : TJSONObject;      overload;
    function Put    : iAlterarEndereco;
    function Found  : Boolean;
    function Error  : Boolean;

    //injeção de dependência
    function Endereco : iEntidadeEndereco<iAlterarEndereco>;
    function &End     : iAlterarEndereco;
  End;

implementation

end.
