{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 30/04/2024 14:18           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Pesquisar.Pessoa.Interfaces;

interface

uses
  Data.DB,
  Model.Entidade.Pessoa.Interfaces;

type
  iPesquisarPessoa = Interface
    ['{0AE00A62-BC4C-4015-8263-35A3DA732392}']
    function DataSet(Value : TDataSource)         : iPesquisarPessoa; overload;
    function DataSet                              : TDataSource;      overload;
    function GetbyId        (Id : Variant)        : iPesquisarPessoa;
    function GetbyCPFCNPJ   (CPFCNPJ    : String) : iPesquisarPessoa;
    function GetbyNomePessoa(NomePessoa : String) : iPesquisarPessoa;
    function GetbySobreNome (SobreNome  : String) : iPesquisarPessoa;
    function GetAll                               : iPesquisarPessoa;
    function LoopPessoa                           : iPesquisarPessoa;
    function Found  : Boolean;
    function Error  : Boolean;
    function Pessoa : iEntidadePessoa<iPesquisarPessoa>;
    function &End   : iPesquisarPessoa;
  End;

implementation

end.
