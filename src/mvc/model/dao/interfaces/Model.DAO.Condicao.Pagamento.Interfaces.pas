{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 24/04/2024 10:41           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Condicao.Pagamento.Interfaces;

interface

uses
  Data.DB,
  Model.Entidade.Condicao.Pagamento.Interfaces;

type
  iDAOCondicaoPagamento = interface
    ['{3E6C679D-FF0D-4215-B74E-ECF28B86DD5B}']
    function DataSet    (DataSource : TDataSource) : iDAOCondicaoPagamento; overload;
    function DataSet                               : TDataSet;              overload;
    function GetAll                                : iDAOCondicaoPagamento;
    function GetbyId    (Id : Variant)             : iDAOCondicaoPagamento;
    function GetbyParams                           : iDAOCondicaoPagamento; overload;
    function Post                                  : iDAOCondicaoPagamento;
    function Put                                   : iDAOCondicaoPagamento; overload;
    function Put(const iDAOCondicaoPagamento)      : iDAOCondicaoPagamento; overload;
    function Delete                                : iDAOCondicaoPagamento;

    function QuantidadeRegistro                    : Integer;
    function This : iEntidadeCondicaoPagamento<iDAOCondicaoPagamento>;
  end;

implementation

end.
