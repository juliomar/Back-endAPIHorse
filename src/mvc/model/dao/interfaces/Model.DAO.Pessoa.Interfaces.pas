{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 03/04/2024 16:03           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Pessoa.Interfaces;

interface

uses
  Data.DB,

  Model.Entidade.Pessoa.Interfaces;

type
  iDAOPessoa = interface
    ['{383D4ADF-3294-4A61-BFB6-5AEC06F959C2}']
    function DataSet(DataSource : TDataSource) : iDAOPessoa; overload;
    function DataSet                           : TDataSet;   overload;
    function GetAll                            : iDAOPessoa;
    function GetbyId(Id : Variant)             : iDAOPessoa;
    function GetbyParams                       : iDAOPessoa; overload;
    function GetbyParams(CPFCNPJ : String)     : iDAOPessoa; overload;
    function GetbyParams(Key: Integer; Value : String) : iDAOPessoa; overload;
    function Post                              : iDAOPessoa;
    function Put                               : iDAOPessoa;
    function Delete                            : iDAOPessoa;

    function QuantidadeRegistro : Integer;
    function This : iEntidadePessoa<iDAOPessoa>;
  end;

implementation

end.
