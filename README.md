### Passo a passo para novas coletas

#### Clonagem do questionário
1. Clonar o questionário BASE no Form Assembly (`QUESTIONARIO BASE para Acompanhamento de dados educacionais (NAO APAGAR)`)
2. Habilitar opção de salvar respostas no Form Assembly, o clone não traz a opção por padrão
3. Criar o `connector` de `Form progress saved` no Form Assembly
4. Habilitar os `connectors` no Form Assembly para que as respostas sejam mandadas para o sistema
5. Editar o campo `form_name` no Form Assembly com o nome do questionário desejado
6. Editar a mensagem de agradecimentos do questionário
7. Pegar o link do questionário clonado
8. Criar o questionário no sistema com o mesmo nome que foi colocado no form assembly e o link do questionário clonado

#### Inserção das redes de ensino da coleta
1. Checar se as redes de ensino onde a coleta irá ser aplicada já existem no sistema
2. Criar as redes que não estão no sistema

#### Criação da coleta
1. Criar uma coleta com o questionário e as redes desejadas
2. Mudar o status para `em progresso` caso a coleta já esteja em execução
3. Selecionar as seções do questionário que se apliquem as redes selecionadas
4. Definir o prazo de execução da coleta
5. Após a criação da coleta, copiar o `id` da mesma, na página de listagem das coletas

#### Importação dos estratos
1. Acessar a planilha base/template de estratos
2. Inserir todos os dados das escolas que fazem parte da coleta
3. Colocar o `id` da coleta para todas as escolas na última coluna
4. Exportar a planilha como arquivo `.csv`
5. Acessar a página de estratos no sistema
6. Importar o arquivo `.csv`

#### Texto inicial
1. Editar texto inicial do sistema

### Variáveis de ambiente

#### Específicas do Rails
Variáveis específicas do framework para gerenciamento de assets, segurança, autenticação e deploy.
Não vejo cenário onde elas precisariam ser modificadas.
```
BUNDLE_WITHOUT
DEVISE_SECRET_KEY
RACK_ENV
RAILS_SKIP_ASSET_COMPILATION
RAILS_SKIP_MIGRATIONS
SECRET_KEY_BASE
```

#### Variáveis para depuração

`SENTRY_DSN`: Opcional. Indica a DSN de acesso a uma instalação Sentry para enviar relatórios de erros da aplicação.

#### Integração com o Pipefy
Variáveis específicas à integração com o Pipefy.

```
PIPEFY_GRAPHQL_ENDPOINT
especifica o endpoint para as chamadas
valor padrão: https://app.pipefy.com/queries
```

```
PIPEFY_ORGANIZATION_ID
o ID da organização Lemann no Pipefy
ao fazer login no pipefy o id está presente na própria url
https://app.pipefy.com/organizations/PIPEFY_ORGANIZATION_ID
```

```
PIPEFY_PIPE_TEMPLATE_ID
o ID de um pipe que servirá de template para clone de novas coletas
o pipe template precisa ter todas as fases, campos iniciais, labels e permissões desejadas
```

```
PIPEFY_TOKEN
token de algum usuário da organização no pipefy para autorização das requisições para a API
```
