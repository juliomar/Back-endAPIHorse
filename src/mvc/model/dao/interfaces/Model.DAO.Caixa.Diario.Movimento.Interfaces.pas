{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 22/04/2024 14:46           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Caixa.Diario.Movimento.Interfaces;

interface

uses
  Data.DB,

  Model.Entidade.Caixa.Diario.Movimento.Interfaces;

type
  iDAOCaixaDiarioMovimento = interface
    ['{34E2F218-8023-45CA-B868-2E77D83ACF68}']
    function DataSet    (DataSource : TDataSource) : iDAOCaixaDiarioMovimento; overload;
    function DataSet                               : TDataSet;                 overload;
    function GetAll                                : iDAOCaixaDiarioMovimento;
    function GetbyId    (Id : Variant)             : iDAOCaixaDiarioMovimento;
    function GetbyParams                           : iDAOCaixaDiarioMovimento; overload;
    function GetbyParams(aIdUsuario : Variant)     : iDAOCaixaDiarioMovimento; overload;
    function GetbyParams(aNomeUsuario : String)    : iDAOCaixaDiarioMovimento; overload;
    function GetbyParams(aIdPedido : Integer)      : iDAOCaixaDiarioMovimento; overload;
    function Post                                  : iDAOCaixaDiarioMovimento;
    function Put                                   : iDAOCaixaDiarioMovimento;
    function Delete                                : iDAOCaixaDiarioMovimento;
    function QuantidadeRegistro                    : Integer;

    function This : iEntidadeCaixaDiarioMovimento<iDAOCaixaDiarioMovimento>;
  end;

implementation

end.
