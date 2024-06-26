{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 13/03/2024 10:43           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Factory.Imp.Entidade;

interface

uses
  Uteis.Interfaces,
  Model.Factory.Entidade.Interfaces,
  Model.DAO.Usuario.Interfaces,
  Model.DAO.Empresa.Interfaces,
  Model.DAO.Categoria.Produto.Interfaces,
  Model.DAO.Marca.Produto.Interfaces,
  Model.DAO.Unidade.Produto.Interfaces,
  Model.DAO.Endereco.Interfaces,
  Model.DAO.Numero.Interfaces,
  Model.DAO.Produto.Interfaces,
  Model.DAO.Endereco.Empresa.Interfaces,
  Model.DAO.Email.Empresa.Interfaces,
  Model.DAO.Pessoa.Interfaces,
  Model.DAO.Endereco.Pessoa.Interfaces,
  Model.DAO.Email.Pessoa.Interfaces,
  Model.DAO.Telefone.Empresa.Interfaces,
  Model.DAO.Telefone.Pessoa.Interfaces,
  Model.DAO.Municipio.Interfaces,
  Model.DAO.Estado.Interfaces,
  Model.DAO.Regiao.Estado.Interfaces,
  Model.DAO.Natureza.Juridica.Interfaces,
  Model.DAO.Caixa.Interfaces,
  Model.DAO.Movimento.Caixa.Interfaces,
  Model.DAO.Fechar.Caixa.Interfaces;
type
  TFactoryEntidade = class(TInterfacedObject, iFactoryEntidade)
    private
      FUteis                      : iUteis;
      FDAOUsuario                 : iDAOUsuario;
      FDAOEmpresa                 : iDAOEmpresa;
      FDAOEnderecoEmpresa         : iDAOEnderecoEmpresa;
      FDAOEmailEmpresa            : iDAOEmailEmpresa;
      FDAOTelefoneEmpresa         : iDAOTelefoneEmpresa;
      FDAOPessoa                  : iDAOPessoa;
      FDAOEnderecoPessoa          : iDAOEnderecoPessoa;
      FDAOEmailPessoa             : iDAOEmailPessoa;
      FDAOTelefonePessoa          : iDAOTelefonePessoa;
      FDAOCategoriaProduto        : iDAOCategoriaProduto;
      FDAOMarcaProduto            : iDAOMarcaProduto;
      FDAOUnidadeProduto          : iDAOUnidadeProduto;
      FDAOProduto                 : iDAOProduto;
      FDAOEndereco                : iDAOEndereco;
      FDAONumero                  : iDAONumero;
      FDAOMunicipio               : iDAOMunicipio;
      FDAOEstado                  : iDAOEstado;
      FDAORegiaoEstado            : iDAORegiaoEstado;
      FDAONaturezaJuridica        : iDAONaturezaJuridica;
      FDAOCaixaDiario             : iDAOCaixa;
      FDAOMovimentoCaixa          : iDAOMovimentoCaixa;
      FDAOFecharCaixa             : iDAOFecharCaixa;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iFactoryEntidade;

      function Uteis               : iUteis;
      function DAOUsuario          : iDAOUsuario;
      function DAOEmpresa          : iDAOEmpresa;
      function DAOEnderecoEmpresa  : iDAOEnderecoEmpresa;
      function DAOEmailEmpresa     : iDAOEmailEmpresa;
      function DAOTeleFoneEmpresa  : iDAOTelefoneEmpresa;
      function DAOPessoa           : iDAOPessoa;
      function DAOEnderecoPessoa   : iDAOEnderecoPessoa;
      function DAOEmailPessoa      : iDAOEmailPessoa;
      function DAOTelefonePessoa   : iDAOTelefonePessoa;
      function DAOCategoriaProduto : iDAOCategoriaProduto;
      function DAOMarcaProduto     : iDAOMarcaProduto;
      function DAOUnidadeProduto   : iDAOUnidadeProduto;
      function DAOProduto          : iDAOProduto;
      function DAOEndereco         : iDAOEndereco;
      function DAONumero           : iDAONumero;
      function DAOMunicipio        : iDAOMunicipio;
      function DAOEstado           : iDAOEstado;
      function DAORegiaoEstado     : iDAORegiaoEstado;
      function DAONaturezaJuridica : iDAONaturezaJuridica;
      function DAOCaixa            : iDAOCaixa;
      function DAOMovimentoCaixa   : iDAOMovimentoCaixa;
      function DAOFecharCaixa      : iDAOFecharCaixa;
  end;

implementation

uses
  Uteis,
  Model.DAO.Imp.Usuario,
  Model.DAO.Imp.Empresa,
  Model.DAO.Imp.Categoria.Produto,
  Model.DAO.Imp.Marca.Produto,
  Model.DAO.Imp.Unidade.Produto,
  Model.DAO.Imp.Endereco,
  Model.DAO.Imp.Numero,
  Model.DAO.Imp.Produto,
  Model.DAO.Imp.Email.Empresa,
  Model.DAO.Imp.Endereco.Empresa,
  Model.DAO.Imp.Pessoa,
  Model.DAO.Imp.Endereco.Pessoa,
  Model.DAO.Imp.Email.Pessoa,
  Model.DAO.Imp.Telefone.Empresa,
  Model.DAO.Imp.Municipio,
  Model.DAO.Imp.Estado,
  Model.DAO.Imp.Regiao.Estado,
  Model.DAO.Imp.Natureza.Juridica,
  Model.DAO.Imp.Caixa,
  Model.DAO.Imp.Movimento.Caixa,
  Model.DAO.Imp.Fechar.Caixa,
  Model.DAO.Imp.Telefone.Pessoa;

{ TFactoryEntidade }

constructor TFactoryEntidade.Create;
begin
  //
end;

destructor TFactoryEntidade.Destroy;
begin
  //
  inherited;
end;

function TFactoryEntidade.Uteis: iUteis;
begin
  if not Assigned(FUteis) then
    FUteis := TUteis.New;

  Result := FUteis;
end;

class function TFactoryEntidade.New: iFactoryEntidade;
begin
  Result := Self.Create;
end;

function TFactoryEntidade.DAOUsuario: iDAOUsuario;
begin
  if not Assigned(FDAOUsuario) then
    FDAOUsuario := TDAOUsuario.New;

  Result := FDAOUsuario;
end;

function TFactoryEntidade.DAOEmpresa: iDAOEmpresa;
begin
  if not Assigned(FDAOEmpresa) then
    FDAOEmpresa := TDAOEmpresa.New;

  Result := FDAOEmpresa;
end;

function TFactoryEntidade.DAOEnderecoEmpresa: iDAOEnderecoEmpresa;
begin
  if not Assigned(FDAOEnderecoEmpresa) then
    FDAOEnderecoEmpresa := TDAOEnderecoEmpresa.New;

  Result := FDAOEnderecoEmpresa;
end;

function TFactoryEntidade.DAOEmailEmpresa: iDAOEmailEmpresa;
begin
  if not Assigned(FDAOEmailEmpresa) then
    FDAOEmailEmpresa := TDAOEmailEmpresa.New;

  Result := FDAOEmailEmpresa;
end;

function TFactoryEntidade.DAOTelefoneEmpresa: iDAOTelefoneEmpresa;
begin
  if not Assigned(FDAOTelefoneEmpresa) then
    FDAOTelefoneEmpresa := TDAOTelefoneEmpresa.New;

  Result := FDAOTelefoneEmpresa;
end;

function TFactoryEntidade.DAOPessoa: iDAOPessoa;
begin
  if not Assigned(FDAOPessoa) then
    FDAOPessoa := TDAOPessoa.New;

  Result := FDAOPessoa;
end;

function TFactoryEntidade.DAOEnderecoPessoa: iDAOEnderecoPessoa;
begin
  if not Assigned(FDAOEnderecoPessoa) then
    FDAOEnderecoPessoa := TDAOEnderecoPessoa.New;

  Result := FDAOEnderecoPessoa;
end;

function TFactoryEntidade.DAOEmailPessoa: iDAOEmailPessoa;
begin
  if not Assigned(FDAOEmailPessoa) then
    FDAOEmailPessoa := TDAOEmailPessoa.New;

  Result := FDAOEmailPessoa;
end;

function TFactoryEntidade.DAOTelefonePessoa: iDAOTelefonePessoa;
begin
  if not Assigned(FDAOTelefonePessoa) then
    FDAOTelefonePessoa := TDAOTelefonePessoa.New;

  Result := FDAOTelefonePessoa;
end;

function TFactoryEntidade.DAOCategoriaProduto: iDAOCategoriaProduto;
begin
  if not Assigned(FDAOCategoriaProduto) then
    FDAOCategoriaProduto := TDAOCategoriaProduto.New;

  Result := FDAOCategoriaProduto;
end;

function TFactoryEntidade.DAOMarcaProduto: iDAOMarcaProduto;
begin
  if not Assigned(FDAOMarcaProduto) then
    FDAOMarcaProduto := TDAOMarcaProduto.New;

  Result := FDAOMarcaProduto;
end;

function TFactoryEntidade.DAOUnidadeProduto: iDAOUnidadeProduto;
begin
  if not Assigned(FDAOUnidadeProduto) then
    FDAOUnidadeProduto := TDAOUnidadeProduto.New;

  Result := FDAOUnidadeProduto;
end;

function TFactoryEntidade.DAOEndereco: iDAOEndereco;
begin
  if not Assigned(FDAOEndereco) then
    FDAOEndereco := TDAOEndereco.New;

  Result := FDAOEndereco;
end;

function TFactoryEntidade.DAONumero: iDAONumero;
begin
  if not Assigned(FDAONumero) then
    FDAONumero := TDAONumero.New;

  Result := FDAONumero;
end;

function TFactoryEntidade.DAOProduto: iDAOProduto;
begin
  if not Assigned(FDAOProduto) then
    FDAOProduto := TDAOProduto.New;

  Result := FDAOProduto;
end;

function TFactoryEntidade.DAOMunicipio: iDAOMunicipio;
begin
  if not Assigned(FDAOMunicipio) then
    FDAOMunicipio := TDAOMunicipio.New;

  Result := FDAOMunicipio;
end;

function TFactoryEntidade.DAOEstado: iDAOEstado;
begin
  if not Assigned(FDAOEstado) then
    FDAOEstado := TDAOEstado.New;

  Result := FDAOEstado;
end;

function TFactoryEntidade.DAORegiaoEstado: iDAORegiaoEstado;
begin
  if not Assigned(FDAORegiaoEstado) then
    FDAORegiaoEstado := TDAORegiaoEstado.New;

  Result := FDAORegiaoEstado;
end;

function TFactoryEntidade.DAONaturezaJuridica: iDAONaturezaJuridica;
begin
  if not Assigned(FDAONaturezaJuridica) then
    FDAONaturezaJuridica := TDAONaturezaJuridica.New;

  Result := FDAONaturezaJuridica;
end;

function TFactoryEntidade.DAOCaixa: iDAOCaixa;
begin
  if not Assigned(FDAOCaixaDiario) then
    FDAOCaixaDiario := TDAOCaixa.New;

  Result := FDAOCaixaDiario;
end;

function TFactoryEntidade.DAOMovimentoCaixa: iDAOMovimentoCaixa;
begin
  if not Assigned(FDAOMovimentoCaixa) then
    FDAOMovimentoCaixa := TDAOMovimentoCaixa.New;

  Result := FDAOMovimentoCaixa;
end;

function TFactoryEntidade.DAOFecharCaixa: iDAOFecharCaixa;
begin
  if not Assigned(FDAOFecharCaixa) then
    FDAOFecharCaixa := TDAOFecharCaixa.New;

  Result := FDAOFecharCaixa;
end;

end.
