{*******************************************************}
{                    API PDV - JSON                     }
{                     Be More Web                       }
{            In�cio do projeto 09/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2023                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Tabela.Swagger.Marca.Produto;

interface

uses
  GBSwagger.Model.Attributes;

type
  TMarcaProduto = class
    private
      FId              : Integer;{bigint-Primary Key}
      FIdEmpresa       : Integer;
      FIdUsuario       : Integer;
      FNomeMarca       : String; {Varchar(60)-> Not Null}
      FDataHoraEmissao : TDateTime;
      FAtivo           : Integer; {Varchar(2)}
    public
      [SwagParamQuery('id', true)]
      [SwagProp('PRIMARY KEY (auto_increment)', True)]
      [SwagProp(False, True)]
      property id        : Integer read FId        write FId;
      [SwagProp('Foreign Key->Tabela (marcaproduto<-Idempresa=id->Tabela empresa)) Exclu�r=Cascade; Alterar=Cascade', True)]
      property idempresa : Integer read FIdEmpresa write FIdEmpresa;
      [SwagProp('Foreign Key->Tabela (marcaproduto<-Idusuario=id->Tabela usuario))', True)]
      property idusuario : Integer read FIdUsuario write FIdUsuario;
      [SwagProp('Varchar(60)Max60-Min10, Unique Key', True)]
      property nomemarca : String  read FNomeMarca write FNomeMarca;
      [SwagProp('YYYY.MM.DD hh:mm:ss', True)]
      property datahoraemissao : TDateTime read FDataHoraEmissao write FDataHoraEmissao;
      [SwagProp('No POST n�o precisa precher, somente no PUT-Caso se tornar Ativo=0', True)]
      property ativo     : Integer read FAtivo     write FAtivo;
  end;

implementation

end.
