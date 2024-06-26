{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 30/04/2024 14:18           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Cadastrar.Usuario.Interfaces;

interface

uses
  System.JSON,
  Model.Entidade.Usuario.Interfaces;

type
  iCadastrarUsuario = interface
    ['{DEE79202-9492-4C6B-8862-8BAAB3D93ACE}']
    function JSONObjectPai(Value : TJSONObject) : iCadastrarUsuario; overload;
    function JSONObjectPai                      : TJSONObject;       overload;
    function Post  : iCadastrarUsuario;
    function Error : Boolean;
    //inje��o de depend�ncia
    function Usuario : iEntidadeUsuario<iCadastrarUsuario>;
    function &End : iCadastrarUsuario;
  end;


implementation

end.
