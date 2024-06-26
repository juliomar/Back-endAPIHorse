{*******************************************************}
{                    API PDV - JSON                     }
{                      ES Sistemas                      }
{          In�cio do projeto 13/03/2024 07:00           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
program APIpdv;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  Horse.BasicAuthentication,
  Horse.Jhonson,
  Horse.Compression,
  Horse.Paginate,
  Horse.Cors,
  Horse.HandleException,
  Horse.OctetStream,
  Horse.GBSwagger,
  Controller.Interfaces in 'src\mvc\controller\interfaces\Controller.Interfaces.pas',
  Model.Conexao.Firedac.Interfaces in 'src\mvc\model\conexao\interfaces\Model.Conexao.Firedac.Interfaces.pas',
  Model.Conexao.Firedac.MySQL.Imp in 'src\mvc\model\conexao\imp\Model.Conexao.Firedac.MySQL.Imp.pas',
  Model.Conexao.Configuracao.MySQL.Interfaces in 'src\mvc\model\conexao\interfaces\Model.Conexao.Configuracao.MySQL.Interfaces.pas',
  Model.Conexao.Configuracao.MySQL.Imp in 'src\mvc\model\conexao\imp\Model.Conexao.Configuracao.MySQL.Imp.pas',
  Model.Conexao.Query.Interfaces in 'src\mvc\model\conexao\interfaces\Model.Conexao.Query.Interfaces.pas',
  Model.Conexao.Query.Imp in 'src\mvc\model\conexao\imp\Model.Conexao.Query.Imp.pas',
  Model.Entidade.Usuario.Interfaces in 'src\mvc\model\entidade\interfaces\Model.Entidade.Usuario.Interfaces.pas',
  Imp.Controller in 'src\mvc\controller\imp\Imp.Controller.pas',
  Model.Entidade.Imp.Usuario in 'src\mvc\model\entidade\imp\Model.Entidade.Imp.Usuario.pas',
  Model.DAO.Usuario.Interfaces in 'src\mvc\model\dao\interfaces\Model.DAO.Usuario.Interfaces.pas',
  Model.DAO.Imp.Usuario in 'src\mvc\model\dao\imp\Model.DAO.Imp.Usuario.pas',
  Model.Factory.Entidade.Interfaces in 'src\mvc\model\factory\interfaces\Model.Factory.Entidade.Interfaces.pas',
  Model.Factory.Imp.Entidade in 'src\mvc\model\factory\imp\Model.Factory.Imp.Entidade.pas',
  View.Controller.Usuario in 'src\mvc\view\controller\View.Controller.Usuario.pas',
  Model.Entidade.Empresa.Interfaces in 'src\mvc\model\entidade\interfaces\Model.Entidade.Empresa.Interfaces.pas',
  Model.Entidade.Imp.Empresa in 'src\mvc\model\entidade\imp\Model.Entidade.Imp.Empresa.pas',
  Model.DAO.Empresa.Interfaces in 'src\mvc\model\dao\interfaces\Model.DAO.Empresa.Interfaces.pas',
  Model.DAO.Imp.Empresa in 'src\mvc\model\dao\imp\Model.DAO.Imp.Empresa.pas',
  View.Controller.Empresa in 'src\mvc\view\controller\View.Controller.Empresa.pas',
  Uteis in 'src\mvc\uteis\Uteis.pas',
  Uteis.Tratar.Mensagens in 'src\mvc\uteis\Uteis.Tratar.Mensagens.pas',
  View.Controller.Categoria.Produto in 'src\mvc\view\controller\View.Controller.Categoria.Produto.pas',
  Model.Entidade.Marca.Produto.Interfaces in 'src\mvc\model\entidade\interfaces\Model.Entidade.Marca.Produto.Interfaces.pas',
  Model.Entidade.Imp.Marca.Produto in 'src\mvc\model\entidade\imp\Model.Entidade.Imp.Marca.Produto.pas',
  Model.DAO.Marca.Produto.Interfaces in 'src\mvc\model\dao\interfaces\Model.DAO.Marca.Produto.Interfaces.pas',
  Model.DAO.Imp.Marca.Produto in 'src\mvc\model\dao\imp\Model.DAO.Imp.Marca.Produto.pas',
  View.Controller.Marca.Produto in 'src\mvc\view\controller\View.Controller.Marca.Produto.pas',
  Model.Entidade.Unidade.Produto.Interfaces in 'src\mvc\model\entidade\interfaces\Model.Entidade.Unidade.Produto.Interfaces.pas',
  Model.Entidade.Imp.Unidade.Produto in 'src\mvc\model\entidade\imp\Model.Entidade.Imp.Unidade.Produto.pas',
  Model.DAO.Unidade.Produto.Interfaces in 'src\mvc\model\dao\interfaces\Model.DAO.Unidade.Produto.Interfaces.pas',
  Model.DAO.Imp.Unidade.Produto in 'src\mvc\model\dao\imp\Model.DAO.Imp.Unidade.Produto.pas',
  View.Controller.Unidade.Produto in 'src\mvc\view\controller\View.Controller.Unidade.Produto.pas',
  Model.Entidade.Endereco.Interfaces in 'src\mvc\model\entidade\interfaces\Model.Entidade.Endereco.Interfaces.pas',
  Model.Entidade.Imp.Endereco in 'src\mvc\model\entidade\imp\Model.Entidade.Imp.Endereco.pas',
  Model.DAO.Endereco.Interfaces in 'src\mvc\model\dao\interfaces\Model.DAO.Endereco.Interfaces.pas',
  Model.DAO.Imp.Endereco in 'src\mvc\model\dao\imp\Model.DAO.Imp.Endereco.pas',
  View.Controller.Endereco in 'src\mvc\view\controller\View.Controller.Endereco.pas',
  Model.Entidade.Numero.Interfaces in 'src\mvc\model\entidade\interfaces\Model.Entidade.Numero.Interfaces.pas',
  Model.Entidade.Imp.Numero in 'src\mvc\model\entidade\imp\Model.Entidade.Imp.Numero.pas',
  Model.DAO.Numero.Interfaces in 'src\mvc\model\dao\interfaces\Model.DAO.Numero.Interfaces.pas',
  Model.DAO.Imp.Numero in 'src\mvc\model\dao\imp\Model.DAO.Imp.Numero.pas',
  Model.Entidade.Produto.Interfaces in 'src\mvc\model\entidade\interfaces\Model.Entidade.Produto.Interfaces.pas',
  Model.Entidade.Imp.Produto in 'src\mvc\model\entidade\imp\Model.Entidade.Imp.Produto.pas',
  Model.DAO.Produto.Interfaces in 'src\mvc\model\dao\interfaces\Model.DAO.Produto.Interfaces.pas',
  Model.DAO.Imp.Produto in 'src\mvc\model\dao\imp\Model.DAO.Imp.Produto.pas',
  View.Controller.Produto in 'src\mvc\view\controller\View.Controller.Produto.pas',
  Model.DAO.Categoria.Produto.Interfaces in 'src\mvc\model\dao\interfaces\Model.DAO.Categoria.Produto.Interfaces.pas',
  Model.Entidade.Categoria.Produto.Interfaces in 'src\mvc\model\entidade\interfaces\Model.Entidade.Categoria.Produto.Interfaces.pas',
  Model.Entidade.Imp.Categoria.Produto in 'src\mvc\model\entidade\imp\Model.Entidade.Imp.Categoria.Produto.pas',
  Model.DAO.Imp.Categoria.Produto in 'src\mvc\model\dao\imp\Model.DAO.Imp.Categoria.Produto.pas',
  Model.Entidade.Email.Empresa.Interfaces in 'src\mvc\model\entidade\interfaces\Model.Entidade.Email.Empresa.Interfaces.pas',
  Model.Entidade.Email.Pessoa.Interfaces in 'src\mvc\model\entidade\interfaces\Model.Entidade.Email.Pessoa.Interfaces.pas',
  Model.Entidade.Imp.Email.Empresa in 'src\mvc\model\entidade\imp\Model.Entidade.Imp.Email.Empresa.pas',
  Model.Entidade.Imp.Email.Pessoa in 'src\mvc\model\entidade\imp\Model.Entidade.Imp.Email.Pessoa.pas',
  Model.Entidade.Endereco.Empresa.Interfaces in 'src\mvc\model\entidade\interfaces\Model.Entidade.Endereco.Empresa.Interfaces.pas',
  Model.Entidade.Endereco.Pessoa.Interfaces in 'src\mvc\model\entidade\interfaces\Model.Entidade.Endereco.Pessoa.Interfaces.pas',
  Model.Entidade.Imp.Endereco.Empresa in 'src\mvc\model\entidade\imp\Model.Entidade.Imp.Endereco.Empresa.pas',
  Model.Entidade.Imp.Endereco.Pessoa in 'src\mvc\model\entidade\imp\Model.Entidade.Imp.Endereco.Pessoa.pas',
  Model.Entidade.Pessoa.Interfaces in 'src\mvc\model\entidade\interfaces\Model.Entidade.Pessoa.Interfaces.pas',
  Model.Entidade.Imp.Pessoa in 'src\mvc\model\entidade\imp\Model.Entidade.Imp.Pessoa.pas',
  Model.DAO.Email.Empresa.Interfaces in 'src\mvc\model\dao\interfaces\Model.DAO.Email.Empresa.Interfaces.pas',
  Model.DAO.Endereco.Empresa.Interfaces in 'src\mvc\model\dao\interfaces\Model.DAO.Endereco.Empresa.Interfaces.pas',
  Model.DAO.Imp.Endereco.Empresa in 'src\mvc\model\dao\imp\Model.DAO.Imp.Endereco.Empresa.pas',
  Model.DAO.Imp.Endereco.Pessoa in 'src\mvc\model\dao\imp\Model.DAO.Imp.Endereco.Pessoa.pas',
  Model.DAO.Endereco.Pessoa.Interfaces in 'src\mvc\model\dao\interfaces\Model.DAO.Endereco.Pessoa.Interfaces.pas',
  Model.DAO.Imp.Email.Empresa in 'src\mvc\model\dao\imp\Model.DAO.Imp.Email.Empresa.pas',
  Model.DAO.Pessoa.Interfaces in 'src\mvc\model\dao\interfaces\Model.DAO.Pessoa.Interfaces.pas',
  Model.DAO.Email.Pessoa.Interfaces in 'src\mvc\model\dao\interfaces\Model.DAO.Email.Pessoa.Interfaces.pas',
  Model.DAO.Imp.Pessoa in 'src\mvc\model\dao\imp\Model.DAO.Imp.Pessoa.pas',
  Model.DAO.Imp.Email.Pessoa in 'src\mvc\model\dao\imp\Model.DAO.Imp.Email.Pessoa.pas',
  Model.Entidade.Telefone.Empresa.Interfaces in 'src\mvc\model\entidade\interfaces\Model.Entidade.Telefone.Empresa.Interfaces.pas',
  Model.Entidade.Imp.Telefone.Empresa in 'src\mvc\model\entidade\imp\Model.Entidade.Imp.Telefone.Empresa.pas',
  Model.DAO.Telefone.Empresa.Interfaces in 'src\mvc\model\dao\interfaces\Model.DAO.Telefone.Empresa.Interfaces.pas',
  Model.DAO.Imp.Telefone.Empresa in 'src\mvc\model\dao\imp\Model.DAO.Imp.Telefone.Empresa.pas',
  Model.Entidade.Telefone.Pessoa.Interfaces in 'src\mvc\model\entidade\interfaces\Model.Entidade.Telefone.Pessoa.Interfaces.pas',
  Model.Entidade.Imp.Telefone.Pessoa in 'src\mvc\model\entidade\imp\Model.Entidade.Imp.Telefone.Pessoa.pas',
  Model.DAO.Telefone.Pessoa.Interfaces in 'src\mvc\model\dao\interfaces\Model.DAO.Telefone.Pessoa.Interfaces.pas',
  Model.DAO.Imp.Telefone.Pessoa in 'src\mvc\model\dao\imp\Model.DAO.Imp.Telefone.Pessoa.pas',
  View.Controller.Pessoa in 'src\mvc\view\controller\View.Controller.Pessoa.pas',
  Model.Entidade.Municipio.Interfaces in 'src\mvc\model\entidade\interfaces\Model.Entidade.Municipio.Interfaces.pas',
  Model.Entidade.Estado.Interfaces in 'src\mvc\model\entidade\interfaces\Model.Entidade.Estado.Interfaces.pas',
  Model.Entidade.Regiao.Estado.Interfaces in 'src\mvc\model\entidade\interfaces\Model.Entidade.Regiao.Estado.Interfaces.pas',
  Model.Entidade.Imp.Municipio in 'src\mvc\model\entidade\imp\Model.Entidade.Imp.Municipio.pas',
  Model.Entidade.Imp.Estado in 'src\mvc\model\entidade\imp\Model.Entidade.Imp.Estado.pas',
  Model.Entidade.Imp.Regiao.Estado in 'src\mvc\model\entidade\imp\Model.Entidade.Imp.Regiao.Estado.pas',
  Model.DAO.Municipio.Interfaces in 'src\mvc\model\dao\interfaces\Model.DAO.Municipio.Interfaces.pas',
  Model.DAO.Estado.Interfaces in 'src\mvc\model\dao\interfaces\Model.DAO.Estado.Interfaces.pas',
  Model.DAO.Regiao.Estado.Interfaces in 'src\mvc\model\dao\interfaces\Model.DAO.Regiao.Estado.Interfaces.pas',
  Model.DAO.Imp.Municipio in 'src\mvc\model\dao\imp\Model.DAO.Imp.Municipio.pas',
  Model.DAO.Imp.Estado in 'src\mvc\model\dao\imp\Model.DAO.Imp.Estado.pas',
  Model.DAO.Imp.Regiao.Estado in 'src\mvc\model\dao\imp\Model.DAO.Imp.Regiao.Estado.pas',
  Tabela.Swagger.Usuario in 'src\mvc\view\swagger\Tabela\Tabela.Swagger.Usuario.pas',
  Tabela.Swagger.Empresa in 'src\mvc\view\swagger\Tabela\Tabela.Swagger.Empresa.pas',
  Tabela.Swagger.Endereco.Empresa in 'src\mvc\view\swagger\Tabela\Tabela.Swagger.Endereco.Empresa.pas',
  Tabela.Swagger.Email.Empresa in 'src\mvc\view\swagger\Tabela\Tabela.Swagger.Email.Empresa.pas',
  Tabela.Swagger.Telefone.Empresa in 'src\mvc\view\swagger\Tabela\Tabela.Swagger.Telefone.Empresa.pas',
  Tabela.Swagger.Pessoa in 'src\mvc\view\swagger\Tabela\Tabela.Swagger.Pessoa.pas',
  Tabela.Swagger.Endereco.Pessoa in 'src\mvc\view\swagger\Tabela\Tabela.Swagger.Endereco.Pessoa.pas',
  Tabela.Swagger.Email.Pessoa in 'src\mvc\view\swagger\Tabela\Tabela.Swagger.Email.Pessoa.pas',
  Tabela.Swagger.Telefone.Pessoa in 'src\mvc\view\swagger\Tabela\Tabela.Swagger.Telefone.Pessoa.pas',
  Tabela.Swagger.Numero in 'src\mvc\view\swagger\Tabela\Tabela.Swagger.Numero.pas',
  Tabela.Swagger.Endereco in 'src\mvc\view\swagger\Tabela\Tabela.Swagger.Endereco.Pas',
  Tabela.Swagger.Municipio in 'src\mvc\view\swagger\Tabela\Tabela.Swagger.Municipio.pas',
  Tabela.Swagger.Estado in 'src\mvc\view\swagger\Tabela\Tabela.Swagger.Estado.pas',
  Tabela.Swagger.Regiao.Estado in 'src\mvc\view\swagger\Tabela\Tabela.Swagger.Regiao.Estado.pas',
  Tabela.Swagger.Produto in 'src\mvc\view\swagger\Tabela\Tabela.Swagger.Produto.pas',
  Tabela.Swagger.Categoria.Produto in 'src\mvc\view\swagger\Tabela\Tabela.Swagger.Categoria.Produto.pas',
  Tabela.Swagger.Marca.Produto in 'src\mvc\view\swagger\Tabela\Tabela.Swagger.Marca.Produto.pas',
  Tabela.Swagger.Unidade.Produto in 'src\mvc\view\swagger\Tabela\Tabela.Swagger.Unidade.Produto.pas',
  View.Controller.Buscar.Cep in 'src\mvc\view\controller\View.Controller.Buscar.Cep.pas';

begin
  ReportMemoryLeaksOnShutdown := True;

  THorse
    .Use(Compression())
    .Use(Jhonson)
    .Use(Paginate)
    .Use(Cors)
    .Use(OctetStream)
    .Use(HorseSwagger)
    .Use(HandleException);

  TViewControllerUsuario.Create;
  TViewControllerEmpresa.Create;
  TViewControllerPessoa.Create;
  TViewControllerCategoriaProduto.Create;
  TViewControllerMarcaProduto.Create;
  TViewControllerUnidadeProduto.Create;
  TViewControllerEndereco.Create;
  TViewControllerProduto.Create;
  TViewControllerBuscarCep.Create;

  THorse.Listen(9000,
  procedure
  begin
    WriteLn(Format('Servidor rodando na porta %d',[THorse.Port]));
    WriteLn('Recebendo requests');
  end);
end.
