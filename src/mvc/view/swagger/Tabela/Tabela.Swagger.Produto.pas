{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            In�cio do projeto 09/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2023                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Tabela.Swagger.Produto;

interface

uses
  GBSwagger.Model.Attributes;

type
  TProduto = class
    private
      FId                  : Integer;{Bigint->Primary Key Not Null AUTO_INCREMENT}
      FIdEmpresa           : Integer;{Bigint Not Null->Foreign Key->Tabela empresa, Exclu�r(Cascade); Alterar(Cascade)}
      FIdUsuario           : Integer;
      FIdCategoria         : Integer;{Bigint Not Null->Foreign Key ->Tabela categoriaproduto->Id}
      FIdUnidade           : Integer;{Bigint Not Null->Foreign Key ->Tabela unidade->Id}
      FGtin                : String;{Varchar(20) DEFAULT NULL}
      FCeanTrib            : String;{Varchar(20) Not Null 'sera o codigo unitario do produto'}
      FCean                : String;{Varchar(20) Not Null seria o preco(exemplo de um fardo de cerveja)'}
      FNomeProduto         : String;{Varchar(100) Not null->UniqueKey}
      FNCM                 : Integer;{Integer Not Null}
      FValorCusto          : Currency;{decimal(10,4) Not Null}
      FAliquotaLucro       : Currency;{decimal(10,2) Not Null}
      FValorVendaGelado    : Currency;{decimal(10,4) Not Null}
      FValorVendaNatural   : Currency;{decimal(10,4) Not Null}
      FValorVendaPromocional : Currency;{decimal(10,4) Not Null 'Usar esta coluna quanto o estabelecimento queira fazer pre�o promocional'}
      FEstoqueAnterior     : Currency;{decimal(10,4) Not Null}
      FEstoqueMaximo       : Currency;{decimal(10,4) Not Null}
      FEstoqueMinimo       : Currency;{decimal(10,4) Not Null}
      FEstoqueAtual        : Currency;{decimal(10,4) Not Null}
      FOrigem              : Integer;{Integer Not Null 'Coluna informa se este produto foi importado\Usado para calculo tabela IBPT(ufunctioncalculo-calcula_imp_aprox_tab_ibtp-)\r\n0 - 3 - 4 - 5=N�o foi importado ent�o n�o calcular\r\n1 - 2 - 6 - 7=Sim foi importado ent�o calcular'}
      FVolume              : Integer;{Integer Not Null}
      FQuantidadeEmbalagem : Integer;{Integer Not Null}
      FBalanca             : Integer; {Integer Not Null COMMENT 'Informar 0 = este produto n�o � de balan�a; 1 = este produto � de balan�a 2 = todos'}
      FPesoLiquido         : Currency;{decimal(10,2) Not Null}
      FPesoBruto           : Currency;{decimal(10,2) Not Null->Peso total do produto}
      FDataHoraEmissao     : TDate;{Not Null->Data que cadastrou no sistema}
      FAtivo               : Integer;{Integer ->Nnot Null}
    public
      [SwagParamQuery('id', true)]
      [SwagProp('PRIMARY KEY (auto_increment)', True)]
      [SwagProp(False, True)]
      property id                  : Integer  read FId                  write FId;
      [SwagProp('Foreign Key->Tabela (categoriaproduto<-Idempresa=id->Tabela empresa)) Exclu�r=Cascade; Alterar=Cascade', True)]
      property idempresa           : Integer  read FIdEmpresa           write FIdEmpresa;
      [SwagProp('Foreign Key->Tabela (usuario<-Idusuario=id->Tabela usuario))', True)]
      property idusuario           : Integer  read FIdUsuario           write FIdUsuario;
      [SwagProp('Foreign Key->Tabela (categoriaproduto<-Idusuario=id->Tabela usuario))', True)]
      property idcategoria         : Integer  read FIdCategoria         write FIdCategoria;
      [SwagProp('Foreign Key->Tabela (unidadeproduto<-Idusuario=id->Tabela usuario))', True)]
      property idunidade           : Integer  read FIdUnidade           write FIdUnidade;
      [SwagProp(False)]
      property gtin                : String   read FGtin                write FGtin;
      [SwagProp('C�digo do produto vender por unidade Unique Key',True)]
      property ceantrib            : String   read FCeanTrib            write FCeanTrib;
      [SwagProp('C�digo do produto quando vende por fardo(Caso n�o tenha, este c�digo ser� igual o ceanTrib), Unique Key',True)]
      property cean                : String   read FCean                write FCean;
      [SwagProp(True)]
      property nomeproduto         : String   read FNomeProduto         write FNomeProduto;
      [SwagProp('Conferir ao qual o produto pertence na tabela NCM ', True)]
      property ncm                 : Integer  read FNCM                 write FNCM;
      [SwagProp('Caso n�o quiser informar, ent�o precha com (ZERO-0)', True)]
      property valorcusto          : Currency read FValorCusto          write FValorCusto;
      [SwagProp('Caso n�o quiser informar, ent�o precha com (ZERO-0)', True)]
      property aliquotalucro       : Currency read FAliquotaLucro       write FAliquotaLucro;
      [SwagProp('Caso n�o quiser informar, ent�o precha com (ZERO-0)', True)]
      property valorvendagelado    : Currency read FValorVendaGelado    write FValorVendaGelado;
      [SwagProp('Preencher com valor m�nimo de 0,01)', True)]
      property valorvendanatural   : Currency read FValorVendaNatural   write FValorVendaNatural;
      [SwagProp('Caso n�o quiser informar, ent�o precha com (ZERO-0)', True)]
      property valorvendapromocional : Currency read FValorVendaPromocional    write FValorVendaPromocional;
      [SwagProp('Caso n�o quiser informar, ent�o precha com (ZERO-0)', True)]
      property estoqueanterior     : Currency read FEstoqueAnterior     write FEstoqueAnterior;
      [SwagProp('Caso n�o quiser informar, ent�o precha com (ZERO-0)', True)]
      property estoquemaximo       : Currency read FEstoqueMaximo       write FEstoqueMaximo;
      [SwagProp('Caso n�o quiser informar, ent�o precha com (ZERO-0)', True)]
      property estoqueminimo       : Currency read FEstoqueMinimo       write FEstoqueMinimo;
      [SwagProp('Caso n�o quiser informar, ent�o precha com (ZERO-0)', True)]
      property estoqueatual        : Currency read FEstoqueAtual        write FEstoqueAtual;
      [SwagProp('Produto importado ent�o informe 3,4ou 5=N�o foi importado 1,2,6 ou 7', True)]
      property origem              : Integer  read FOrigem              write FOrigem;
      [SwagProp('Informe o volume ', True)]
      property volume              : Integer  read FVolume              write FVolume;
      [SwagProp('Informe o volume ', True)]
      property quantidadeembalagem : Integer  read FQuantidadeEmbalagem write FQuantidadeEmbalagem;
      [SwagProp('Caso pertencer a balan�a informe 1 caso contr�rio 0 ', True)]
      property balanca             : Integer  read FBalanca             write FBalanca;
      [SwagProp('Caso n�o quiser informar, ent�o precha com (ZERO-0)', True)]
      property pesoliquido         : Currency read FPesoLiquido         write FPesoLiquido;
      [SwagProp('Caso n�o quiser informar, ent�o precha com (ZERO-0)', True)]
      property pesobruto           : Currency read FPesoBruto           write FPesoBruto;
      [SwagProp('YYYY-MM-DD hh:mm:ss ', True)]
      property datahoraemissao     : TDate    read FDataHoraEmissao     write FDataHoraEmissao;
      [SwagProp('0-Inativo 1-Ativo', True)]
      property ativo               : Integer  read FAtivo               write FAtivo;
  end;

implementation

end.
