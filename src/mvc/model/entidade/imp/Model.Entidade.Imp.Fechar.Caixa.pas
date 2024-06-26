{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 22/04/2024 12:08           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Imp.Fechar.Caixa;

interface

uses
  Model.Entidade.Fechar.Caixa.Interfaces,
  Model.Entidade.Usuario.Interfaces;

type
  TEntidadeFecharCaixa<T : iInterface> = class(TInterfacedObject, iEntidadeFecharCaixa<T>)
    private
      [weak]
      FParent          : T;
      FId              : Integer;
      FIdCaixa         : Integer;
      FIdUsuario       : Integer;
      FValorLancado    : Currency;
      FDataHoraEmissao : TDateTime;
      FObservacao      : String;
      FUsuario         : iEntidadeUsuario<iEntidadeFecharCaixa<T>>;
    public
      constructor Create(Parent : T);
      destructor Destroy; override;
      class function New(Parent : T) : iEntidadeFecharCaixa<T>;

      function Id              (Value : Integer)   : iEntidadeFecharCaixa<T>; overload;
      function Id                                  : Integer;                             overload;
      function IdCaixa         (Value : Integer)   : iEntidadeFecharCaixa<T>; overload;
      function IdCaixa                             : Integer;                             overload;
      function IdUsuario       (Value : Integer)   : iEntidadeFecharCaixa<T>; overload;
      function IdUsuario                           : Integer;                             overload;
      function ValorLancado    (Value : Currency)  : iEntidadeFecharCaixa<T>; overload;
      function ValorLancado                        : Currency;                            overload;
      function DataHoraEmissao (Value : TDateTime) : iEntidadeFecharCaixa<T>; overload;
      function DataHoraEmissao                     : TDateTime;                           overload;
      function Observacao      (Value : String)    : iEntidadeFecharCaixa<T>; overload;
      function Observacao                          : String;                              overload;

      //Inje��o de depend�ncia
      function Usuario  : iEntidadeUsuario<iEntidadeFecharCaixa<T>>;

      function &End : T;
  end;

implementation

{ TEntidadeFecharCaixa<T> }

constructor TEntidadeFecharCaixa<T>.Create(Parent: T);
begin
  FParent := Parent;
end;

destructor TEntidadeFecharCaixa<T>.Destroy;
begin
  inherited;
end;

class function TEntidadeFecharCaixa<T>.New(Parent: T): iEntidadeFecharCaixa<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeFecharCaixa<T>.Id(Value: Integer): iEntidadeFecharCaixa<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadeFecharCaixa<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeFecharCaixa<T>.IdCaixa(Value: Integer): iEntidadeFecharCaixa<T>;
begin
  Result := Self;
  FIdCaixa := Value;
end;

function TEntidadeFecharCaixa<T>.IdCaixa: Integer;
begin
  Result := FIdCaixa;
end;

function TEntidadeFecharCaixa<T>.IdUsuario(Value: Integer): iEntidadeFecharCaixa<T>;
begin
  Result := Self;
  FIdUsuario := Value;
end;

function TEntidadeFecharCaixa<T>.IdUsuario: Integer;
begin
  Result := FIdUsuario;
end;

function TEntidadeFecharCaixa<T>.ValorLancado(Value: Currency): iEntidadeFecharCaixa<T>;
begin
  Result := Self;
  FValorLancado := Value;
end;

function TEntidadeFecharCaixa<T>.ValorLancado: Currency;
begin
  Result := FValorLancado;
end;

function TEntidadeFecharCaixa<T>.DataHoraEmissao(Value: TDateTime): iEntidadeFecharCaixa<T>;
begin
  Result := Self;
  FDataHoraEmissao := Value;
end;

function TEntidadeFecharCaixa<T>.DataHoraEmissao: TDateTime;
begin
  Result := FDataHoraEmissao;
end;

function TEntidadeFecharCaixa<T>.Observacao(Value: String): iEntidadeFecharCaixa<T>;
begin
  Result := Self;
  FObservacao := Value;
end;

function TEntidadeFecharCaixa<T>.Observacao: String;
begin
  Result := FObservacao;
end;

//Inje��o de depend�ncia
function TEntidadeFecharCaixa<T>.Usuario: iEntidadeUsuario<iEntidadeFecharCaixa<T>>;
begin
  Result := FUsuario
end;

function TEntidadeFecharCaixa<T>.&End: T;
begin
  Result := FParent;
end;

end.
