{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 03/04/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2004/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Email.Pessoa.Interfaces;

interface

type
   iEntidadeEmailPessoa<T> = interface
     ['{2941293B-1C8A-4576-8BA6-BDA407BC6098}']
     function Id       (Value : Integer) : iEntidadeEmailPessoa<T>; overload;
     function Id                         : Integer;                 overload;
     function IdEmpresa(Value : Integer) : iEntidadeEmailPessoa<T>; overload;
     function IdEmpresa                  : Integer;                 overload;
     function IdPessoa (Value : Integer) : iEntidadeEmailPessoa<T>; overload;
     function IdPessoa                   : Integer;                 overload;
     function Email    (Value : String)  : iEntidadeEmailPessoa<T>; overload;
     function Email                      : String;                  overload;
     function TipoEmail(Value : String)  : iEntidadeEmailPessoa<T>; overload;
     function TipoEMail                  : String;                  overload;
     function Ativo    (Value : Integer) : iEntidadeEmailPessoa<T>; overload;
     function Ativo                      : Integer;                 overload;

     function &End : T;
   end;

implementation


end.
