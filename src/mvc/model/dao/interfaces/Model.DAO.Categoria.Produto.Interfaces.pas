{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 18/03/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Categoria.Produto.Interfaces;

interface

uses
  Data.DB,

  Model.Entidade.Categoria.Produto.Interfaces;

type
  iDAOCategoriaProduto = interface
    ['{7B01BCCF-8F10-4E6B-A895-395190DB4E14}']
    function DataSet(DataSource : TDataSource) : iDAOCategoriaProduto; overload;
    function DataSet                           : TDataSet;             overload;
    function GetAll                            : iDAOCategoriaProduto;
    function GetbyId(Id : Variant)             : iDAOCategoriaProduto;
    function GetbyParams                       : iDAOCategoriaProduto;
    function Post                              : iDAOCategoriaProduto;
    function Put                               : iDAOCategoriaProduto;
    function Delete                            : iDAOCategoriaProduto;

    function QuantidadeRegistro : Integer;
    function This : iEntidadeCategoriaProduto<iDAOCategoriaProduto>;
  end;

implementation

end.
