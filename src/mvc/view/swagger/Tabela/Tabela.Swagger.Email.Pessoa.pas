{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            In�cio do projeto 09/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2023                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Tabela.Swagger.Email.Pessoa;

interface

Uses
  GBSwagger.Model.Attributes;

type
  TEmailPessoa = class
    private
      FId        : Integer;{bigint ->Primary Key}
      FIdEmpresa : Integer;{bigint-> Foreign Key->Tabela empresa(Id)-Exclu�r=Cascade; Alterar=Cascade}
      FIdPessoa  : Integer;{bigint-> Foreign Key->Tabela pessoa(Id)-Exclu�r=Cascade; Alterar=Cascade}
      FEmail     : String; {Varchar(20)->Unique Key(Idpessoa+EMail)}
      FTipoEmail : String; {Varchar(100)->Salvar(Pessoal, Comercial, Faturamento, Financeiro, Compras, Telemarketing)}
      FAtivo     : Integer;{Integer-Not Null 0-Inativo; 1-Ativo}
    public
      [SwagProp('PRIMARY KEY (auto_increment)', False)]
      property id        : Integer read FId        write FId;
      [SwagProp('Foreign Key->Tabela (emailpessoa<-Idempresa=id->Tabela empresa)) Exclu�r=Cascade; Alterar=Cascade', True)]
      property idempresa : Integer read FIdEmpresa write FIdEmpresa;
      [SwagProp('Foreign Key->Tabela (emailpessoa<-Idempresa=id->Tabela pessoa)) Exclu�r=Cascade; Alterar=Cascade', True)]
      property idpessoa  : Integer read FIdPessoa  write FIdPessoa;
      [SwagProp(True)]
      property email     : String  read FEMail     write FEMail;
      [SwagProp('Comercial, Pessoal, Financeiro, Vendas, Telemarketing', True)]
      property tipoemail : String  read FTipoEmail write FTipoEmail;
      [SwagProp('0->Inativo; 1->Ativo', True)]
      property ativo     : Integer read FAtivo     write FAtivo;
  end;

implementation

end.
