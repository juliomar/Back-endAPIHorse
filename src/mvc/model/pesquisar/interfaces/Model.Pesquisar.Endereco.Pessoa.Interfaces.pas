{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 02/05/2024 10:23           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Pesquisar.Endereco.Pessoa.Interfaces;

interface

uses
  Data.DB,
  System.JSON,
  Model.Entidade.Endereco.Pessoa.Interfaces;

type
  iPesquisarEnderecoPessoa = Interface
    ['{69013FE5-EDF9-4A3C-8B01-3EA293F24340}']
    function DataSet(Value : TDataSource)                     : iPesquisarEnderecoPessoa; overload;
    function DataSet                                          : TDataSource;              overload;
    function Getby(IdEmpresa, IdEndereco, IdPessoa : Integer) : iPesquisarEnderecoPessoa;
    function LoopEnderecoPessoa : TJSONValue;
    function Found : Boolean;
    function Error : Boolean;

    function EnderecoPessoa : iEntidadeEnderecoPessoa<iPesquisarEnderecoPessoa>;
    function &End  : iPesquisarEnderecoPessoa;
  End;

implementation

end.
