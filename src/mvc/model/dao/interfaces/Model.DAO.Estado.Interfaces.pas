{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 08/04/2024 18:12           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Estado.Interfaces;

interface

uses
  Data.DB,

  Model.Entidade.Estado.Interfaces;

type
  iDAOEstado = interface
    ['{3D9750A4-40A4-441D-9E12-068D60F81FE0}']
    function DataSet(DataSource : TDataSource) : iDAOEstado; overload;
    function DataSet                           : TDataSet;      overload;
    function GetAll                            : iDAOEstado;
    function GetbyId(Id : Variant)             : iDAOEstado;
    function GetbyParams                       : iDAOEstado;
    function Post                              : iDAOEstado;
    function Put                               : iDAOEstado;
    function Delete                            : iDAOEstado;

    function QuantidadeRegistro : Integer;
    function This : iEntidadeEstado<iDAOEstado>;
  end;

implementation

end.
