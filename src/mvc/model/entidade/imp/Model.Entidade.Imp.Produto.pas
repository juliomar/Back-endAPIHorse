{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 19/03/2024 13:58           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Imp.Produto;

interface

uses
  Model.Entidade.Produto.Interfaces;

type
  TEntidadeProduto<T : iInterface>= class(TInterfacedObject, iEntidadeProduto<T>)
    private
      [weak]
      FParent                : T;
      FId                    : Integer;
      FIdEmpresa             : Integer;
      FIdUsuario             : INteger;
      FIdCategoria           : Integer;
      FIdUnidade             : Integer;
      FGtin                  : String;
      FcEanTrib              : String;
      FcEan                  : String;
      FNomeProduto           : String;
      FNCM                   : Integer;
      FValorCusto            : Currency;
      FALiquotaLucro         : Currency;
      FValorVendaGelado      : Currency;
      FValorVendaNatural     : Currency;
      FValorVendaPromocional : Currency;
      FEstoqueAnterior       : Currency;
      FEstoqueMaximo         : Currency;
      FEstoqueMinimo         : Currency;
      FEstoqueAtual          : Currency;
      FOrigem                : Integer;
      FVolume                : Integer;
      FQuantidadeEmbalagem   : Integer;
      FBalanca               : Integer;
      FPesoLiquido           : Currency;
      FPesoBruto             : Currency;
      FDataHoraEmissao       : TDateTime;
      FAtivo                 : Integer;
    public
      constructor Create(Parent : T);
      destructor Destroy; override;
      class function New(Parent : T) : iEntidadeProduto<T>;

      function Id                   (Value : Integer)  : iEntidadeProduto<T>; overload;
      function Id                                      : Integer;             overload;
      function IdEmpresa            (Value : Integer)  : iEntidadeProduto<T>; overload;
      function IdEmpresa                               : Integer;             overload;
      function IdUsuario            (Value : Integer)  : iEntidadeProduto<T>; overload;
      function IdUsuario                               : Integer;             overload;
      function IdCategoria          (Value : Integer)  : iEntidadeProduto<T>; overload;
      function IdCategoria                             : Integer;             overload;
      function IdUnidade            (Value : Integer)  : iEntidadeProduto<T>; overload;
      function IdUnidade                               : Integer;             overload;
      function Gtin                 (Value : String)   : iEntidadeProduto<T>; overload;
      function Gtin                                    : String;              overload;
      function cEanTrib             (Value : String)   : iEntidadeProduto<T>; overload;
      function cEanTrib                                : String;              overload;
      function cEan                 (Value : String)   : iEntidadeProduto<T>; overload;
      function cEan                                    : String;              overload;
      function NomeProduto          (Value : String)   : iEntidadeProduto<T>; overload;
      function NomeProduto                             : String;              overload;
      function NCM                  (Value : integer)  : iEntidadeProduto<T>; overload;
      function NCM                                     : Integer;             overload;
      function ValorCusto           (Value : Currency) : iEntidadeProduto<T>; overload;
      function ValorCusto                              : Currency;            overload;
      function AliquotaLucro        (Value : Currency) : iEntidadeProduto<T>; overload;
      function AliquotaLucro                           : Currency;            overload;
      function ValorVendaGelado     (Value : Currency) : iEntidadeProduto<T>; overload;
      function ValorVendaGelado                        : Currency;            overload;
      function ValorVendaNatural    (Value : Currency) : iEntidadeProduto<T>; overload;
      function ValorVendaNatural                       : Currency;            overload;
      function ValorVendaPromocional(Value : Currency) : iEntidadeProduto<T>; overload;
      function ValorVendaPromocional                   : Currency;            overload;
      function EstoqueAnterior      (Value : Currency) : iEntidadeProduto<T>; overload;
      function EstoqueAnterior                         : Currency;            overload;
      function EstoqueMaximo        (Value : Currency) : iEntidadeProduto<T>; overload;
      function EstoqueMaximo                           : Currency;            overload;
      function EstoqueMinimo        (Value : Currency) : iEntidadeProduto<T>; overload;
      function EstoqueMinimo                           : Currency;            overload;
      function EstoqueAtual         (Value : Currency) : iEntidadeProduto<T>; overload;
      function EstoqueAtual                            : Currency;            overload;
      function Origem               (Value : Integer)  : iEntidadeProduto<T>; overload;
      function Origem                                  : Integer;             overload;
      function Volume               (Value : Integer)  : iEntidadeProduto<T>; overload;
      function Volume                                  : Integer;             overload;
      function QuantidadeEmbalagem  (Value : Integer)  : iEntidadeProduto<T>; overload;
      function QuantidadeEmbalagem                     : Integer;             overload;
      function Balanca              (Value : Integer)  : iEntidadeProduto<T>; overload;
      function Balanca                                 : Integer;             overload;
      function PesoLiquido          (Value : Currency) : iEntidadeProduto<T>; overload;
      function PesoLiquido                             : Currency;            overload;
      function PesoBruto            (Value : Currency) : iEntidadeProduto<T>; overload;
      function PesoBruto                               : Currency;            overload;
      function DataHoraEmissao      (Value : TDateTime) : iEntidadeProduto<T>; overload;
      function DataHoraEmissao                          : TDateTime;           overload;
      function Ativo                (Value : Integer)  : iEntidadeProduto<T>; overload;
      function Ativo                                   : Integer;             overload;

      function &End : T;
  end;

implementation

{ TEntidadeProduto<T> }

constructor TEntidadeProduto<T>.Create(Parent: T);
begin
  FParent := Parent;
end;

destructor TEntidadeProduto<T>.Destroy;
begin
  inherited;
end;

class function TEntidadeProduto<T>.New(Parent: T): iEntidadeProduto<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeProduto<T>.Id(Value: Integer): iEntidadeProduto<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadeProduto<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeProduto<T>.IdEmpresa(Value: Integer): iEntidadeProduto<T>;
begin
  Result := Self;
  FIdEmpresa := Value;
end;

function TEntidadeProduto<T>.IdEmpresa: Integer;
begin
  Result := FIdEmpresa;
end;

function TEntidadeProduto<T>.IdUsuario(Value: Integer): iEntidadeProduto<T>;
begin
  Result := Self;
  FIdUsuario := Value;
end;

function TEntidadeProduto<T>.IdUsuario: Integer;
begin
  Result := FIdUsuario;
end;

function TEntidadeProduto<T>.IdCategoria(Value: Integer): iEntidadeProduto<T>;
begin
  Result := Self;
  FIdCategoria := Value;
end;

function TEntidadeProduto<T>.IdCategoria: Integer;
begin
  Result := FIdCategoria;
end;

function TEntidadeProduto<T>.IdUnidade(Value: Integer): iEntidadeProduto<T>;
begin
  Result := Self;
  FIdUnidade := Value;
end;

function TEntidadeProduto<T>.IdUnidade: Integer;
begin
  Result := FIdUnidade;
end;

function TEntidadeProduto<T>.Gtin(Value: String): iEntidadeProduto<T>;
begin
  Result := Self;
  FGtin  := Value;
end;

function TEntidadeProduto<T>.Gtin: String;
begin
  Result := FGtin;
end;

function TEntidadeProduto<T>.cEanTrib(Value: String): iEntidadeProduto<T>;
begin
  Result := Self;
  FcEanTrib := Value;
end;

function TEntidadeProduto<T>.cEanTrib: String;
begin
  Result := FcEanTrib;
end;

function TEntidadeProduto<T>.cEan(Value: String): iEntidadeProduto<T>;
begin
  Result := Self;
  FcEan   := Value;
end;

function TEntidadeProduto<T>.cEan: String;
begin
  Result := FcEan;
end;

function TEntidadeProduto<T>.NomeProduto(Value: String): iEntidadeProduto<T>;
begin
  Result := Self;
  FNomeProduto := Value;
end;

function TEntidadeProduto<T>.NomeProduto: String;
begin
  Result := FNomeProduto;
end;

function TEntidadeProduto<T>.NCM(Value: integer): iEntidadeProduto<T>;
begin
  Result := Self;
  FNCM   := Value;
end;

function TEntidadeProduto<T>.NCM: Integer;
begin
  Result := FNCM;
end;

function TEntidadeProduto<T>.ValorCusto(Value: Currency): iEntidadeProduto<T>;
begin
  Result := Self;
  FValorCusto := Value;
end;

function TEntidadeProduto<T>.ValorCusto: Currency;
begin
  Result := FValorCusto;
end;

function TEntidadeProduto<T>.AliquotaLucro(Value: Currency): iEntidadeProduto<T>;
begin
  Result := Self;
  FAliquotaLucro := Value;
end;

function TEntidadeProduto<T>.AliquotaLucro: Currency;
begin
  Result := FAliquotaLucro;
end;

function TEntidadeProduto<T>.ValorVendaGelado(Value: Currency): iEntidadeProduto<T>;
begin
  Result := Self;
  FValorVendaGelado := Value;
end;

function TEntidadeProduto<T>.ValorVendaGelado: Currency;
begin
  Result := FValorVendaGelado;
end;

function TEntidadeProduto<T>.ValorVendaNatural(Value: Currency): iEntidadeProduto<T>;
begin
  Result := Self;
  FValorVendaNatural := Value;
end;

function TEntidadeProduto<T>.ValorVendaNatural: Currency;
begin
  Result := FValorVendaNatural;
end;


function TEntidadeProduto<T>.ValorVendaPromocional(Value: Currency): iEntidadeProduto<T>;
begin
  Result := Self;
  FValorVendaPromocional := Value;
end;

function TEntidadeProduto<T>.ValorVendaPromocional: Currency;
begin
  Result := FValorVendaPromocional;
end;

function TEntidadeProduto<T>.EstoqueAnterior(Value: Currency): iEntidadeProduto<T>;
begin
  Result := Self;
  FEstoqueAnterior := Value;
end;

function TEntidadeProduto<T>.EstoqueAnterior: Currency;
begin
  Result := FEstoqueAnterior;
end;

function TEntidadeProduto<T>.EstoqueMaximo(Value: Currency): iEntidadeProduto<T>;
begin
  Result := Self;
  FEstoqueMaximo := Value;
end;

function TEntidadeProduto<T>.EstoqueMaximo: Currency;
begin
  Result := FEstoqueMaximo;
end;

function TEntidadeProduto<T>.EstoqueMinimo(Value: Currency): iEntidadeProduto<T>;
begin
  Result := Self;
  FEstoqueMinimo := Value;
end;

function TEntidadeProduto<T>.EstoqueMinimo: Currency;
begin
  Result := FEstoqueMinimo;
end;

function TEntidadeProduto<T>.EstoqueAtual(Value: Currency): iEntidadeProduto<T>;
begin
  Result := Self;
  FEstoqueAtual := Value;
end;

function TEntidadeProduto<T>.EstoqueAtual: Currency;
begin
  Result := FEstoqueAtual;
end;

function TEntidadeProduto<T>.Origem(Value: Integer): iEntidadeProduto<T>;
begin
  Result := Self;
  FOrigem := Value;
end;

function TEntidadeProduto<T>.Origem: Integer;
begin
  Result := FOrigem;
end;

function TEntidadeProduto<T>.Volume(Value: Integer): iEntidadeProduto<T>;
begin
  Result := Self;
  FVolume := Value;
end;

function TEntidadeProduto<T>.Volume: Integer;
begin
  Result := FVolume;
end;

function TEntidadeProduto<T>.QuantidadeEmbalagem(Value: Integer): iEntidadeProduto<T>;
begin
  Result := Self;
  FQuantidadeEmbalagem := Value;
end;

function TEntidadeProduto<T>.QuantidadeEmbalagem: Integer;
begin
  Result := FQuantidadeEmbalagem;
end;

function TEntidadeProduto<T>.Balanca(Value: Integer): iEntidadeProduto<T>;
begin
  Result := Self;
  FBalanca := Value;
end;

function TEntidadeProduto<T>.Balanca: Integer;
begin
  Result := FBalanca;
end;

function TEntidadeProduto<T>.PesoLiquido(Value: Currency): iEntidadeProduto<T>;
begin
  Result := Self;
  FPesoLiquido := Value;
end;

function TEntidadeProduto<T>.PesoLiquido: Currency;
begin
  Result := FPesoLiquido;
end;

function TEntidadeProduto<T>.PesoBruto(Value: Currency): iEntidadeProduto<T>;
begin
  Result := Self;
  FPesoBruto := Value;
end;

function TEntidadeProduto<T>.PesoBruto: Currency;
begin
  Result := FPesoBruto;
end;

function TEntidadeProduto<T>.DataHoraEmissao(Value: TDateTime): iEntidadeProduto<T>;
begin
  Result := Self;
  FDataHoraEmissao := Value;
end;

function TEntidadeProduto<T>.DataHoraEmissao: TDateTime;
begin
  Result := FDataHoraEmissao;
end;

function TEntidadeProduto<T>.Ativo(Value: Integer): iEntidadeProduto<T>;
begin
  Result := Self;
  FAtivo := Value;
end;

function TEntidadeProduto<T>.Ativo: Integer;
begin
  Result := FAtivo;
end;

function TEntidadeProduto<T>.&End: T;
begin
  Result := FParent;
end;

end.
