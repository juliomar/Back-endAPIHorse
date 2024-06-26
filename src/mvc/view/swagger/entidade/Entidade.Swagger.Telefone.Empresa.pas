{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            In�cio do projeto 09/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2023                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Entidade.Swagger.Telefone.Empresa;

interface

Uses
  GBSwagger.Model.Attributes;

type
  TTelefoneEmpresa = class
    private
      FId             : Integer;{bigint ->Primary Key}
      FIdEmpresa      : Integer;{bigint-> Foreign Key->Tabela Empresa(Id)-Exclu�r=Cascade; Alterar=Cascade}
      FOperadora      : String; {Char(3)->015;021 c�digo da operadora}
      FDDD            : String; {Char(3)->17; �rea do n�mero->Not Null}
      FNumeroTelefone : String; {Varchar(15)n�mero da linha->Not Null}
      FTipoTelefone   : String; {Char(1) F-Fixo; C-Celular}
      FAtivo          : Integer;{Integer-Not Null 0-Inativo; 1-Ativo}
    public
      [SwagProp('PRIMARY KEY (auto_increment)', True)]
      property id             : Integer read FId           write FId;
      [SwagProp('Foreign Key->Tabela (telefoneempresa<-Idempresa=id->Tabela empresa)) Exclu�r=Cascade; Alterar=Cascade', True)]
      property idempresa      : Integer read FIdEmpresa    write FIdEmpresa;
      [SwagProp('Operadoro (015->Vivo; 021->Claro/Nextel/NET/Embratel; 041->Tim; 031->OI)', True)]
      property operadora      : String  read FOperadora    write FOperadora;
      [SwagProp('17->S�o jos� do rio preto e regi�o)', True)]
      property ddd            : String  read FDDD            write FDDD;
      [SwagProp(True)]
      property numerotelefone : String  read FNumeroTelefone write FNumeroTelefone;
      [SwagProp('C->Celular; F->Fixo', True)]
      property tipotelefone   : String  read FTipoTelefone   write FTipoTelefone;
      [SwagProp('0->Inativo; 1->Ativo', True)]
      property ativo          : Integer read FAtivo          write FAtivo;
  end;

implementation

end.
