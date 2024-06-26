{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 03/04/2024 16:03           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Endereco.Empresa.Interfaces;

interface

uses
  Data.DB,
  Model.Entidade.Endereco.Empresa.Interfaces;

type
  iDAOEnderecoEmpresa = interface
    ['{5195D011-1B48-4BB1-A9DA-9DDA65EC38AC}']
    function DataSet(DataSource : TDataSource)            : iDAOEnderecoEmpresa; overload;
    function DataSet                                      : TDataSet;            overload;
    function GetAll                                       : iDAOEnderecoEmpresa;
    function GetbyId(Id : Variant)                        : iDAOEnderecoEmpresa;
    function GetbyParams                                  : iDAOEnderecoEmpresa; overload;
    function GetbyParams(const iDAOEnderecoEmpresa)       : iDAOEnderecoEmpresa; overload;
    function GetbyParams(IdEmpresa, IdEndereco : Variant) : iDAOEnderecoEmpresa; overload;
    function Post                                         : iDAOEnderecoEmpresa;
    function Put                                          : iDAOEnderecoEmpresa;
    function Delete                                       : iDAOEnderecoEmpresa;

    function QuantidadeRegistro : Integer;
    function This : iEntidadeEnderecoEmpresa<iDAOEnderecoEmpresa>;
  end;

implementation

end.
