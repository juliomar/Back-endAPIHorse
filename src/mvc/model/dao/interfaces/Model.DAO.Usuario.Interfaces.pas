{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 13/03/2024 10:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Usuario.Interfaces;

interface

uses
  Data.DB,

  Model.Entidade.Usuario.Interfaces;

type
  iDAOUsuario = interface
    ['{634FBF36-237A-41BD-AF97-91B430C8236B}']
    function DataSet(DataSource : TDataSource) : iDAOUsuario; overload;
    function DataSet                           : TDataSet;    overload;
    function GetAll                            : iDAOUsuario;
    function GetbyId(Id : Variant)             : iDAOUsuario;
    function GetbyParams                       : iDAOUsuario;
    function Post                              : iDAOUsuario;
    function Put                               : iDAOUsuario;
    function Delete                            : iDAOUsuario;

    function QuantidadeRegistro : Integer;
    function This : iEntidadeUsuario<iDAOUsuario>;
  end;

implementation

end.
