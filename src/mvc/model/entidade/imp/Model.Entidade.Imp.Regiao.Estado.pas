{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 08/04/2024 18:12           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Imp.Regiao.Estado;

interface

uses
  Model.Entidade.Regiao.Estado.Interfaces;

type
  TEntidadeRegiaoEstado<T : iInterface> = class(TInterfacedObject, iEntidadeRegiaoEstado<T>)
    private
      [weak]
      FParent : T;
      FId     : Integer;
      FRegiao : String;
    public
      constructor Create(Parent : T);
      destructor Destroy; override;
      class function New(Parent : T) : iEntidadeRegiaoEstado<T>;

      function Id       (Value : Integer) : iEntidadeRegiaoEstado<T>; overload;
      function Id                         : Integer;                  overload;
      function Regiao    (Value : String) : iEntidadeRegiaoEstado<T>; overload;
      function Regiao                     : String;                   overload;

      function &End : T;
  end;

implementation

{ TEntidadeRegiaoEstado<T> }

constructor TEntidadeRegiaoEstado<T>.Create(Parent: T);
begin
  FParent := Parent;
end;

destructor TEntidadeRegiaoEstado<T>.Destroy;
begin
  inherited;
end;

class function TEntidadeRegiaoEstado<T>.New(Parent: T): iEntidadeRegiaoEstado<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeRegiaoEstado<T>.Id(Value: Integer): iEntidadeRegiaoEstado<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadeRegiaoEstado<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeRegiaoEstado<T>.Regiao(Value: String): iEntidadeRegiaoEstado<T>;
begin
  Result := Self;
  FRegiao := Value;
end;

function TEntidadeRegiaoEstado<T>.Regiao: String;
begin
  Result := FRegiao;
end;

function TEntidadeRegiaoEstado<T>.&End: T;
begin
  Result := FParent;
end;

end.
