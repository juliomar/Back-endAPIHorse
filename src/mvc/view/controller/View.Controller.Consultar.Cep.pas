{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 11/04/2024 20:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Controller.Consultar.Cep;

interface

uses
  System.SysUtils,
  System.JSON,
  Data.DB,

  ViaCEP.Intf,
  ViaCEP.Core,
  ViaCEP.Model,

  DataSet.Serialize,
  Horse,
  Horse.BasicAuthentication,
  Controller.Interfaces;

type
  TViewControllerConsultarCep = class
    private
      FController : iController;
      FDataSource : TDataSource;
      FJSONObject : TJSONObject;
      FCep        : String;

      function  BuscoCepBaseDadosServidorLocal(Cep : String) : Boolean;
      procedure GetAll (Req: THorseRequest; Res: THorseResponse; Next : TProc);
      procedure Registry;
    public
      constructor Create;
      destructor Destroy; override;
  end;

implementation

uses
  Imp.Controller;

{ TViewControllerConsultarCep }

constructor TViewControllerConsultarCep.Create;
begin
  FController := TController.New;
  FDataSource := TDataSource.Create(nil);
  Registry;
end;

destructor TViewControllerConsultarCep.Destroy;
begin
  inherited;
end;

function TViewControllerConsultarCep.BuscoCepBaseDadosServidorLocal(Cep : String): Boolean;
begin
  Result := False;
  try
    FController
      .FactoryDAO
        .DAOEndereco
          .GetbyParams(Cep)
          .DataSet(FDataSource);
    except
      on E : Exception do
      begin
        Writeln('Ocorreu um erro interno no servidor'+E.Message);
        Exit;
      end;
  end;

  Result := not FDataSource.DataSet.IsEmpty;
  if Result then
  begin
    FJSONObject := TJSONObject.Create;
    FJSONObject.AddPair('cep'         , FDataSource.DataSet.FieldByName('cep').AsString);
    FJSONObject.AddPair('endereco'    , FDataSource.DataSet.FieldByName('logradouro').AsString);
    FJSONObject.AddPair('numero'      , FDataSource.DataSet.FieldByName('numeroendereco').AsString);
    FJSONObject.AddPair('complemento' , FDataSource.DataSet.FieldByName('complementoendereco').AsString);
    FJSONObject.AddPair('bairro'      , FDataSource.DataSet.FieldByName('bairro').AsString);
    FJSONObject.AddPair('municipio'   , FDataSource.DataSet.FieldByName('municipio').AsString);
    FJSONObject.AddPair('estado'      , FDataSource.DataSet.FieldByName('uf').AsString);
    FJSONObject.AddPair('ibge'        , FDataSource.DataSet.FieldByName('ibge').AsString);
    FJSONObject.AddPair('gia'         , FDataSource.DataSet.FieldByName('gia').AsString);
    FJSONObject.AddPair('ddd'         , FDataSource.DataSet.FieldByName('ddd').AsString);
  end;
end;

procedure TViewControllerConsultarCep.GetAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LJSONObject : TJSONObject;
  LViaCEP     : IViaCEP;
  LCEP        : TViaCEPClass;
begin
  FCep := StringReplace(Req.Query.Field('cep').AsString,'-','',[rfReplaceAll]);
  LViaCEP  := TViaCEP.Create;
  if LViaCEP.Validate(FCep) then
  begin
    if not BuscoCepBaseDadosServidorLocal(StringReplace(Req.Query.Field('cep').AsString,'','-',[rfReplaceAll])) then
    begin
      LCEP := LViaCEP.Get(StringReplace(FCep,'-','',[rfReplaceAll]));
      if not Assigned(LCEP) then
      begin// Aqui voc� pode exibir uma mensagem para o usu�rio falando que o CEP n�o foi encontrado.
        Res.Status(500).Send('Cep n�o encontrado');
        Exit;
      end;

      // Crie ou obtenha os dados que deseja enviar para o frontend
      LJSONObject := TJSONObject.Create;
      try
        LJSONObject.AddPair('cep'         , LCEP.CEP);
        LJSONObject.AddPair('endereco'    , LCep.Logradouro);
        LJSONObject.AddPair('complemento' , LCep.Complemento);
        LJSONObject.AddPair('bairro'      , LCep.Bairro);
        LJSONObject.AddPair('municipio'   , LCep.Localidade);
        LJSONObject.AddPair('estado'      , LCep.UF);
        LJSONObject.AddPair('ibge'        , LCep.IBGE);
        LJSONObject.AddPair('gia'         , LCep.GIA);
        LJSONObject.AddPair('ddd'         , LCep.DDD);
        // Converta os dados para JSON
        Res.Send(LJSONObject);
      finally
        FreeAndNil(LCep);
      end;
    end
    else
      Res.Send(FJSONObject);
  end
  else
    Res.Status(500).Send('Cep inv�lido');
end;

procedure TViewControllerConsultarCep.Registry;
begin
  THorse
      .Group
        .Prefix('bmw')
          .Get ('/cep' , GetAll);
end;

end.
