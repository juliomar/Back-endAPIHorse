unit Model.Imp.Pesquisar.Email.Pessoa;

interface

uses
  Data.DB,
  System.JSON,
  DataSet.Serialize,
  Model.Pesquisar.Email.Pessoa.Interfaces,
  Controller.Interfaces,
  Model.Entidade.Email.Pessoa.Interfaces;

type
  TPesquisarEmailPessoa = class(TInterfacedObject, iPesquisarEmailPessoa)
    private
      FController  : iController;
      FEmailPessoa : iEntidadeEmailPessoa<iPesquisarEmailPessoa>;
      FDSEmailPessoa : TDataSource;

      FJSONObject : TJSONObject;
      FJSONArray  : TJSONArray;

      FFound : Boolean;
      FError : Boolean;

      FQuantidadeRegistro : Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iPesquisarEmailPessoa;

      function GetBy(IdPessoa : Integer; Email: String) : iPesquisarEmailPessoa;
      function LoopEmailPessoa : TJSONValue;
      function Found : Boolean;
      function Error : Boolean;

      function EmailPessoa : iEntidadeEmailPessoa<iPesquisarEmailPessoa>;
      function &End  : iPesquisarEmailPessoa;
  end;


implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Email.Pessoa;

{ TPesquisarEmailPessoa }

constructor TPesquisarEmailPessoa.Create;
begin
  FController    := TController.New;
  FEmailPessoa   := TEntidadeEmailPessoa<iPesquisarEmailPessoa>.New(Self);
  FDSEmailPessoa := TDataSource.Create(nil);

  FFound := False;
  FError := False;

  FQuantidadeRegistro := 0;
end;

destructor TPesquisarEmailPessoa.Destroy;
begin
  inherited;
end;

class function TPesquisarEmailPessoa.New: iPesquisarEmailPessoa;
begin
  Result := Self.Create;
end;

function TPesquisarEmailPessoa.GetBy(IdPessoa: Integer; Email: String): iPesquisarEmailPessoa;
begin
  Result := Self;

end;

function TPesquisarEmailPessoa.LoopEmailPessoa: TJSONValue;
begin
  FQuantidadeRegistro := FController
                           .FactoryDAO
                             .DAOEmailPessoa
                             .GetbyId(FEmailPessoa.IdPessoa)
                             .DataSet(FDSEmailPessoa)
                             .QuantidadeRegistro;
   if not FDSEmailPessoa.DataSet.IsEmpty then
   begin
     FJSONArray := TJSONArray.Create;
     FDSEmailPessoa.DataSet.First;
     while not FDSEmailPessoa.DataSet.Eof do
     begin
       FJSONObject := TJSONObject.Create;
       FJSONObject := FDSEmailPessoa.DataSet.ToJSONObject;
       Result := FJSONObject;
       if FQuantidadeRegistro > 1 then
       begin
         FJSONArray.Add(FJSONObject);
         Result := FJSONArray;
       end;

       FDSEmailPessoa.DataSet.Next;
     end;
   end;
end;

function TPesquisarEmailPessoa.Found: Boolean;
begin
  Result := FFound;
end;

function TPesquisarEmailPessoa.Error: Boolean;
begin
  Result := FError;
end;

//Inje��o de depend�ncia
function TPesquisarEmailPessoa.EmailPessoa: iEntidadeEmailPessoa<iPesquisarEmailPessoa>;
begin
  Result := FEmailPessoa;
end;

function TPesquisarEmailPessoa.&End: iPesquisarEmailPessoa;
begin
  Result := Self;
end;

end.
