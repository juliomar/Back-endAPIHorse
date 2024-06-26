{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            In�cio do projeto 15/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Swagger.Marca_Produto;

interface

uses
  Horse.GBSwagger,
  Entidade.Swagger.Marca.Produto;
type
  TSwaggerMarcaProduto = class
   private
   public
     class procedure SwaggerMarcaProduto;
  end;

implementation

{ TSwaggerMarcaProduto }

class procedure TSwaggerMarcaProduto.SwaggerMarcaProduto;
begin
  Swagger
    .Path('marca-produto')//nome do meu Path
      .Tag('Marca do produto')//agrupando meus Endpoint Tag do Path marcaproduto
        .GET('Listar todos', 'Listo todas as marcas dos produtos')
          .AddResponse(201, 'lista de todas marcas dos produtos encontrada com sucesso!')//Aqui passo a resposta do Path
            .Schema(TMarcaProduto)//A resposta seria do objeto marcaproduto
            .IsArray(True)//Como � um GET ALL passo um Array=True
      .&End
          .AddResponse(400).&End
          .AddResponse(404).&End
          .AddResponse(500).&End
    .&End
    .POST('Adicionar uma nova marca de produto!')
      .AddParamBody('Dados da marca dos produtos')
        .Schema(TMarcaProduto)
      .&End
          .AddResponse(201)
          .Schema(TMarcaProduto)
        .&End
          .AddResponse(400).&End
          .AddResponse(404).&End
          .AddResponse(500).&End
      .&End
    .&End
    .Path('marca-produto/{id}')
      .Tag('Marca do produto')
        .GET('encontrar marca do produto por id')
          .AddParamPath('id', 'Id da marca do produto')
            .Schema(SWAG_INTEGER)
          .&End
          .AddResponse(201, 'Marca do produto encontrado com sucesso!').&End
          .AddResponse(400).&End//erro de valida��o
          .AddResponse(404).&End//id inv�lido
          .AddResponse(500).&End//erro banco de dados
    .&End
    .PUT('Update marcaproduto')
      .AddParamPath('Update marcaproduto', 'id da marca do produto')
        .Schema(SWAG_INTEGER)
      .&End
      .AddParamBody('marcaproduto', 'Dados da marca do produto')
        .Schema(TMarcaProduto)
      .&End
      .AddResponse(204,'Altera��o realizada com sucesso!').&End//sucesso na altera��o
      .AddResponse(400).&End//erro de valida��o
      .AddResponse(404).&End//id inv�lido
      .AddResponse(500).&End//erro banco
    .&End
    .DELETE('Delete marcaproduto')
      .AddParamPath('id', 'id da marca do produto')
        .Schema(SWAG_INTEGER)
    .&End
      .AddResponse(204,'Exclus�o realizada com sucesso!').&End//sucesso na exclus�o
      .AddResponse(400).&End//erro de valida��o
      .AddResponse(404).&End//id inv�lido
      .AddResponse(500).&End//erro banco
    .&End
    .&End
    .Path('marca-produto?nomemarca')
      .Tag('Marca do produto')
        .GET('encontrar marca do produto pelo nome da marca')
          .AddParamQuery('nomemarca', 'Nome da marca do produto a ser filtrado')//, TSwagStringFormat.FormatString);
           .Schema(SWAG_STRING)
          .&End
          .AddResponse(201, 'Registro encontrado com sucesso!').&End
          .AddResponse(400).&End//erro de valida��o
          .AddResponse(404).&End//id inv�lido
          .AddResponse(500).&End//erro banco de dados
    .&End;
end;

end.
