unit Model.DAO.Endereco.Interfaces;

interface

uses
  Data.DB,

  Model.Entidade.Endereco.Interfaces;

type
  iDAOEndereco = interface
    ['{213B7178-A7B4-42C9-A170-66AF362F661B}']
    function DataSet(DataSource : TDataSource) : iDAOEndereco; overload;
    function DataSet                           : TDataSet;     overload;
    function GetAll                            : iDAOEndereco;
    function GetbyId(Id : Variant)             : iDAOEndereco;
    function GetbyParams                       : iDAOEndereco; overload;
    function GetbyParams(Cep : String)         : iDAOEndereco; overload;
    function Post                              : iDAOEndereco;
    function Put                               : iDAOEndereco;
    function Delete                            : iDAOEndereco;

    function QuantidadeRegistro : Integer;
    function This : iEntidadeEndereco<iDAOEndereco>;
  end;

implementation

end.
