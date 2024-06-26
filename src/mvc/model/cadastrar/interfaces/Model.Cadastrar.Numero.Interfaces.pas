{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 30/04/2024 14:18           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Cadastrar.Numero.Interfaces;

interface

uses
  System.JSON,
  Model.Entidade.Numero.Interfaces,
  Model.Entidade.Empresa.Interfaces;

type
  iCadastrarNumero = interface
    ['{40F6C611-5163-4937-BABA-641023AB377F}']
    function JSONObjectPai(Value : TJSONObject) : iCadastrarNumero; overload;
    function JSONObjectPai                      : TJSONObject;      overload;
    function Post : iCadastrarNumero;
    function Error     : Boolean;
    //inje��o de depend�ncia
    function Numero  : iEntidadeNumero<iCadastrarNumero>;
    function Empresa : iEntidadeEmpresa<iCadastrarNumero>;
    function &End    : iCadastrarNumero;
  end;

implementation

end.
