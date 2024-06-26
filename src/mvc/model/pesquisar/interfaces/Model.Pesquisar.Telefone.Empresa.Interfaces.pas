{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 01/05/2024 14:52           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Pesquisar.Telefone.Empresa.Interfaces;

interface

uses
  System.JSON,
  Model.Entidade.Telefone.Empresa.Interfaces;

type
  iPesquisarTelefoneEmpresa = Interface
    ['{DA02A509-1EFF-4086-9EDE-0FD4731559D2}']
    function GetBy(IdEmpresa : Integer; DDD, NumeroTelefone: String) :iPesquisarTelefoneEmpresa;
    function LoopTelefoneEmpresa : TJSONValue;
    function Found : Boolean;
    function Error : Boolean;

    //inje��o de depend�ncia
    function TelefoneEmpresa : iEntidadeTelefoneEmpresa<iPesquisarTelefoneEmpresa>;
    function &End : iPesquisarTelefoneEmpresa;
  End;

implementation

end.
