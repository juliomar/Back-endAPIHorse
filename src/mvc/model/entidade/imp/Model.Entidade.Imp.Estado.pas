{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 08/04/2024 18:12           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Imp.Estado;

interface

uses
  Model.Entidade.Estado.Interfaces,
  Model.Entidade.Regiao.Estado.Interfaces;

type
  TEntidadeEstado<T : iInterface> = class(TInterfacedObject, iEntidadeEstado<T>)
    private
      [weak]
      FParent       : T;
      FId           : Integer;
      FIdEstado     : Integer;
      FIdRegiao     : Integer;
      FEstado       : String;
      FUF           : String;

      //Inje��o de depend�ncia
      FRegiaoEstado : iEntidadeRegiaoEstado<iEntidadeEstado<T>>;
    public
      constructor Create(Parent : T);
      destructor Destroy; override;
      class function New(Parent : T) : iEntidadeEstado<T>;

      function Id       (Value : Integer) : iEntidadeEstado<T>; overload;
      function Id                         : Integer;            overload;
      function IdEstado (Value : Integer) : iEntidadeEstado<T>; overload;
      function IdEstado                   : Integer;            overload;
      function IdRegiao (Value : Integer) : iEntidadeEstado<T>; overload;
      function IdRegiao                   : Integer;            overload;
      function Estado   (Value : String)  : iEntidadeEstado<T>; overload;
      function Estado                     : String;             overload;
      function UF       (Value : String)  : iEntidadeEstado<T>; overload;
      function UF                         : String;             overload;

      //Inje��o de depend�ncia
      function RegiaoEstado : iEntidadeRegiaoEstado<iEntidadeEstado<T>>;
      function &End : T;
  end;

implementation

Uses
  Model.Entidade.Imp.Regiao.Estado;

{ TEntidadeEstado<T> }

constructor TEntidadeEstado<T>.Create(Parent: T);
begin
  FParent       := Parent;
  FRegiaoEstado := TEntidadeRegiaoEstado<iEntidadeEstado<T>>.New(Self);
end;

destructor TEntidadeEstado<T>.Destroy;
begin
  inherited;
end;

class function TEntidadeEstado<T>.New(Parent: T): iEntidadeEstado<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeEstado<T>.Id(Value: Integer): iEntidadeEstado<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadeEstado<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeEstado<T>.IdEstado(Value: Integer): iEntidadeEstado<T>;
begin
  Result := Self;
  FIdEstado := Value;
end;

function TEntidadeEstado<T>.IdEstado: Integer;
begin
  Result := FIdEstado;
end;

function TEntidadeEstado<T>.IdRegiao(Value: Integer): iEntidadeEstado<T>;
begin
  Result := Self;
  FIdRegiao := Value;
end;

function TEntidadeEstado<T>.IdRegiao: Integer;
begin
  Result := FIdRegiao;
end;

function TEntidadeEstado<T>.Estado(Value: String): iEntidadeEstado<T>;
begin
  Result := Self;
  FEstado := Value;
end;

function TEntidadeEstado<T>.Estado: String;
begin
  Result := FEstado;
end;

function TEntidadeEstado<T>.UF(Value: String): iEntidadeEstado<T>;
begin
  Result := Self;
  FUF    := Value;
end;

function TEntidadeEstado<T>.UF: String;
begin
  Result := FUF;
end;

//inje��o de depend�ncia
function TEntidadeEstado<T>.RegiaoEstado: iEntidadeRegiaoEstado<iEntidadeEstado<T>>;
begin
  Result := FRegiaoEstado;
end;

function TEntidadeEstado<T>.&End: T;
begin
  Result := FParent;
end;

end.
