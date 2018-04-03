### Passo a passo para novas coletas

#### Clonagem do questionário
1. Clonar o questionário BASE no Form Assembly (`QUESTIONARIO BASE para Acompanhamento de dados educacionais (NAO APAGAR)`)
2. Pegar o link do questionário clonado
3. Criar o questionário no sistema com um nome identificador e o link do questionário clonado

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
