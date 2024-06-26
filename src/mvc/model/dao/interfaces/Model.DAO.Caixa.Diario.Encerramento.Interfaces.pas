{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 22/04/2024 14:46           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Caixa.Diario.Encerramento.Interfaces;

interface

uses
  Data.DB,

  Model.Entidade.Caixa.Diario.Encerramento.Interfaces;

type
  iDAOCaixaDiarioEncerramento = interface
    ['{34E2F218-8023-45CA-B868-2E77D83ACF68}']
    function DataSet    (DataSource : TDataSource) : iDAOCaixaDiarioEncerramento; overload;
    function DataSet                               : TDataSet;                    overload;
    function GetAll                                : iDAOCaixaDiarioEncerramento;
    function GetbyId    (Id : Variant)             : iDAOCaixaDiarioEncerramento;
    function GetbyParams                           : iDAOCaixaDiarioEncerramento; overload;
    function GetbyParams(aIdUsuario : Variant)     : iDAOCaixaDiarioEncerramento; overload;
    function GetbyParams(aNomeUsuario : String)    : iDAOCaixaDiarioEncerramento; overload;
    function GetbyParams(aIdPedido : Integer)      : iDAOCaixaDiarioEncerramento; overload;
    function Post                                  : iDAOCaixaDiarioEncerramento;
    function Put                                   : iDAOCaixaDiarioEncerramento;
    function Delete                                : iDAOCaixaDiarioEncerramento;
    function QuantidadeRegistro                    : Integer;

    function This : iEntidadeCaixaDiarioEncerramento<iDAOCaixaDiarioEncerramento>;
  end;

implementation

end.
