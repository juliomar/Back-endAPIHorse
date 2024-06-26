{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 18/03/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Marca.Produto.Interfaces;

interface

uses
  Data.DB,

  Model.Entidade.Marca.Produto.Interfaces;

type
  iDAOMarcaProduto = interface
    ['{5A39611C-F9E4-4320-A5ED-44A57380FDA6}']
    function DataSet(DataSource : TDataSource) : iDAOMarcaProduto; overload;
    function DataSet                           : TDataSet;         overload;
    function GetAll                            : iDAOMarcaProduto;
    function GetbyId(Id : Variant)             : iDAOMarcaProduto;
    function GetbyParams                       : iDAOMarcaProduto;
    function Post                              : iDAOMarcaProduto;
    function Put                               : iDAOMarcaProduto;
    function Delete                            : iDAOMarcaProduto;

    function QuantidadeRegistro : Integer;
    function This : iEntidadeMarcaProduto<iDAOMarcaProduto>;
  end;

implementation

end.
