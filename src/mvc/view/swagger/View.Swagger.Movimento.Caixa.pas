{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            In�cio do projeto 15/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Swagger.Movimento.Caixa;

interface

uses
  Horse.GBSwagger,
  Entidade.Swagger.Movimento.Caixa;
type
  TSwaggerMovimentoCaixa = class
   private
   public
     class procedure SwaggerMovimentoCaixa;
  end;

implementation

{ TSwaggerMovimentoCaixa }

class procedure TSwaggerMovimentoCaixa.SwaggerMovimentoCaixa;
begin
  Swagger
    .Path('movimento-caixa')//nome do meu Path
      .Tag('Movimento caixa')//agrupando meus Endpoint Tag do Path Movimento caixa
        .GET('Listar todos', 'Listo todos os movimentos do caixa')
          .AddResponse(201, 'lista dos Movimento caixa encontrada com sucesso!')//Aqui passo a resposta do Path
            .Schema(TMovimentoCaixa)//A resposta seria do objeto CaixaDiario
            .IsArray(True)//Como � um GET ALL passo um Array=True
      .&End
          .AddResponse(400).&End
          .AddResponse(404).&End
          .AddResponse(500).&End
    .&End
    .POST('Adicionar um novo Movimento caixa!')
      .AddParamBody('Dados do Movimento caixa')
        .Schema(TMovimentoCaixa)
      .&End
          .AddResponse(201)
          .Schema(TMovimentoCaixa)
        .&End
          .AddResponse(400).&End
          .AddResponse(404).&End
          .AddResponse(500).&End
      .&End
    .&End
    .Path('movimento-caixa/{id}')
      .Tag('Movimento caixa')
        .GET('encontrar movimento caixa por id')
          .AddParamPath('id', 'Id do Movimento caixa')
            .Schema(SWAG_INTEGER)
          .&End
          .AddResponse(201, 'Registro encontrada com sucesso!').&End
          .AddResponse(400).&End//erro de valida��o
          .AddResponse(404).&End//id inv�lido
          .AddResponse(500).&End//erro banco de dados
    .&End
    .PUT('Update movimento-caixa')
      .AddParamPath('Update Movimento caixa', 'id do Movimento caixa')
        .Schema(SWAG_INTEGER)
      .&End
      .AddParamBody('CaixaDiario', 'Dados do Movimento caixa')
        .Schema(TMovimentoCaixa)
      .&End
      .AddResponse(204,'Altera��o realizada com sucesso!').&End//sucesso na altera��o
      .AddResponse(400).&End//erro de valida��o
      .AddResponse(404).&End//id inv�lido
      .AddResponse(500).&End//erro banco
    .&End
    .DELETE('Delete movimento-caixa')
      .AddParamPath('id', 'id do Movimento caixa')
        .Schema(SWAG_INTEGER)
    .&End
      .AddResponse(204,'Registro exclu�do com sucesso!').&End//sucesso na exclus�o
      .AddResponse(400).&End//erro de valida��o
      .AddResponse(404).&End//id inv�lido
      .AddResponse(500).&End//erro banco
    .&End
    .&End
    .&End
    .Path('movimento-caixa?nomeusuario')
      .Tag('Movimento caixa')
        .GET('encontrar Movimento caixa por Nome usu�rio')
          .AddParamQuery('nomeusuario','Nome usu�rio')
          .Schema(SWAG_STRING)
          .&End
          .AddResponse(201, 'Registro encontrada com sucesso!').&End
          .AddResponse(400).&End//erro de valida��o
          .AddResponse(404).&End//id inv�lido
          .AddResponse(500).&End//erro banco de dados
    .&End;
end;

end.
