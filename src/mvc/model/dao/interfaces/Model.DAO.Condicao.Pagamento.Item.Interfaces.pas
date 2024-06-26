{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 24/04/2024 10:41           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Condicao.Pagamento.Item.Interfaces;

interface

uses
  Data.DB,
  Model.Entidade.Condicao.Pagamento.Item.Interfaces;

type
  iDAOCondicaoPagamentoItem = interface
    ['{3E6C679D-FF0D-4215-B74E-ECF28B86DD5B}']
    function DataSet    (DataSource : TDataSource)  : iDAOCondicaoPagamentoItem; overload;
    function DataSet                                : TDataSet;                  overload;
    function GetAll                                 : iDAOCondicaoPagamentoItem;
    function GetbyId    (Id : Variant)              : iDAOCondicaoPagamentoItem; overload;
    function GetbyId    (IdParent : Integer)        : iDAOCondicaoPagamentoItem; overload;
    function GetbyParams                            : iDAOCondicaoPagamentoItem; overload;
    function Post                                   : iDAOCondicaoPagamentoItem;
    function Put                                    : iDAOCondicaoPagamentoItem;
    function Delete                                 : iDAOCondicaoPagamentoItem;

    function QuantidadeRegistro : Integer;
    function This : iEntidadeCondicaoPagamentoItem<iDAOCondicaoPagamentoItem>;
  end;

implementation

end.
