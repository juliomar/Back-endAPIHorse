{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 01/05/2024 15:11           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Pesquisar.Usuario.Interfaces;

interface

uses
  Model.Entidade.Usuario.Interfaces;

type
  iPesquisarUsuario = Interface
    ['{0361D670-A9D0-443E-AFD2-ED12226FD748}']
    function Getby(Email, Senha: String) : iPesquisarUsuario;
    function Found : Boolean;
    function Error : Boolean;

    function Usuario : iEntidadeUsuario<iPesquisarUsuario>;
    function &End   : iPesquisarUsuario;
  End;

implementation

end.
