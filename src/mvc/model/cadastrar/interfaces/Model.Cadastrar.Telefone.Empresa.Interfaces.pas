{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 30/04/2024 14:18           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Cadastrar.Telefone.Empresa.Interfaces;

interface

uses
  System.JSON,
  Model.Entidade.Telefone.Empresa.Interfaces;

type
  iCadastrarTelefoneEmpresa = interface
    ['{18F2B473-3D39-45BE-A3B3-9070069929D9}']
    function JSONObjectPai(Value : TJSONObject) : iCadastrarTelefoneEmpresa; overload;
    function JSONObjectPai                      : TJSONObject;               overload;
    function Post  : iCadastrarTelefoneEmpresa;
    function Error : Boolean;
    //inje��o de depend�ncia
    function TelefoneEmpresa : iEntidadeTelefoneEmpresa<iCadastrarTelefoneEmpresa>;
    function &End : iCadastrarTelefoneEmpresa;
  end;

implementation

end.
