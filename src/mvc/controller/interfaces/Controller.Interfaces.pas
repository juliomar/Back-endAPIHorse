{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 13/03/2024 10:26           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Controller.Interfaces;

interface

uses
  Model.Factory.DAO.Interfaces,
  Model.Factory.Cadastrar.Interfaces,
  Model.Factory.Pesquisar.Interfaces,
  Model.Factory.Alterar.Interfaces,
  Model.Factory.Deletar.Interfaces,
  Model.Factory.Consultar.API.Interfaces,
  Model.Factory.Uteis.Interfaces,
  Model.Factory.De.Para.Interfaces;

type
  iController = interface
    ['{611C46ED-61F0-4331-A949-B58E8B473AF0}']
    function FactoryDAO          : iFactoryDAO;
    function FactoryCadastrar    : iFactoryCadastrar;
    function FactoryPesquisar    : iFactoryPesquisar;
    function FactoryAlterar      : iFactoryAlterar;
    function FactoryDeletar      : iFactoryDeletar;
    function FactoryConsultarAPI : iFactoryConsultarAPI;
    function FactoryUteis        : iFactoryUteis;
    function FactoryDePara       : iFactoryDePara;
  end;

implementation

end.
