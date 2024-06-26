{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 30/04/2024 14:18           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Cadastrar.Empresa.Interfaces;

interface

uses
  System.JSON,
  Model.Entidade.Empresa.Interfaces;

type
  iCadastrarEmpresa = interface
    ['{468AD080-8AAC-416F-A3FB-D9060183AAFB}']
    function JSONObject(Value : TJSONObject) : iCadastrarEmpresa; overload;
    function JSONObject                      : TJSONObject;       overload;
    function Post   : Boolean;

    function Error  : Boolean;
    //inje��o de depend�ncia
    function Empresa : iEntidadeEmpresa<iCadastrarEmpresa>;
    function &End    : iCadastrarEmpresa;
  end;

implementation

end.
