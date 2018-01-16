# README

### Adicionando novos questionários

**Atenção: CLONAR questionário existente no FA para que os ids continuem os mesmos**

Tenha em mãos o link do questionário no seguinte formato: https://www.tfaforms.com/ID_DO_QUESTIONARIO?

Não esquecer o **"?"**, ele é importante para que os parâmetros sejam passados corretamente

Editar o arquivo `.env` com um nome para o novo questionário e o link do mesmo
```
NOME_DO_QUESTIONARIO=https://www.tfaforms.com/ID?
```

A mesma modificação deve ser feita no servidor
`Configuration > Software Configuration > Environment Properties`
Normalmente o servidor reinicia automaticamente após essa mudança, caso contrário, é necessário reiniciá-lo para que essa mudança seja considerada na aplicação.

Editar os seguintes arquivos:

- `app/views/layouts/application.html.erb`

  Adicionar uma entrada com a mesma variável adicionada anteriormente no arquivo `.env`

  `<%= hidden_field_tag :nome_do_questionario, ENV['NOME_DO_QUESTIONARIO'], id: 'nome_do_questionario' %>`


- `app/models/form_option.rb`

  Adicionar uma entrada nas estruturas
  ```
  FORM_NAMES = [
    ['Basline', 'baseline'],
    ['Follow up','follow_up'],
    ['Opção 3', 'option_three'],
    ['Opção 4', 'option_four'],
    ['Opção 5', 'option_five'],
    ['Nome do Questionário', 'nome_do_questionario']
  ]

  FORM_NAMES_HASH = {
    baseline: 'Baseline',
    follow_up: 'Follow up',
    option_three: 'Opção 3',
    option_four: 'Opção 4',
    option_five: 'Opção 5',
    nome_do_questionario: 'Nome do Questionário'
  }
  ```
  Essas estruturas servem apenas para diferenciar os valores que irão/estão no banco de dados e os valores que serão mostrados nas views. Normalmente inserimos no banco valores em inglês e fazemos um parseamento para a língua e formatação desejada.

- `app/assets/javascripts/prefill.js`

  Adicionar uma entrada no objeto

  ```
  formUrls = {
    baseline:     $("#baseline_url").val(),
    follow_up:    $("#follow_up_url").val(),
    option_three: $("#option_three_url").val(),
    option_four:  $("#option_four_url").val(),
    option_five:  $("#option_five_url").val(),
    nome_do_questionario:  $("#nome_do_questionario").val()
  };
  ```

  Lembrando que é muito importante que a nomeação siga uma regra e seja a mesma em todas essas alterações.

Pronto, agora é só criar uma nova restrição com a rede e o novo questionário em `/admin/form_options` que já surgirá efeito na aplicação.


**Lembrando que os questionarios podem ser editados normalmente, não podendo apenas remover os campos listados a seguir.**

Podem mudar os enunciados das seguintes perguntas a vontade, só não podemos perder o id internamente do FA:
- seções
- id da escola
- inep
- nome e telefone da escola
- nome, email e telefone do responsavel
- ambas os campos de secretarias
- prazo

Esses são os ids que não podem mudar dentro do form assembly pois há um mapeamento individual para cada um:
 `tfa_63, tfa_64, tfa_65, tfa_66, tfa_2567, tfa_2568, tfa_3707, tfa_7, tfa_5, tfa_3719, tfa_80, tfa_84, tfa_86, tfa_3707, tfa_3710, tfa_3713, tfa_5734`


### Adicionando um questionário que não foi clonado

Tudo que foi listado anteriormente se aplica para esse caso também. A parte extra que precisa ser feita é basicamente mapear os campos no arquivo `app/assets/javascripts/prefill.js`.

Então provavelmente teríamos que ter uma nova condição para checar o novo form e realizar o mapeamento específico dentro desta condição, juntamente com uma refatoração da função que redireciona o usuário.

Lembrando o mapeamento dos parâmetros deve ter o seguinte formato:
 - `& + id_no_fa + = + valor` _(tudo junto sem espaçamento)_

 O `&` não é necessário para o primeiro parâmetro.

Seria algo como:

```
...
$(function() {
  $("input[type=submit]").on('click', function(e) {
    ...
    if (formName == 'novo_questionario_nao_clonado') {
      // remapear todos os campos seguindo a ideia do que já temos
      newMapping();
    } else {
      faFormMapping();
    }
    ...
    createSubmission(formName);
    openForm(formName);
  });
});

// precisaria refatorar essa função para não ser mais atrelada para um único mapeamento
function openForm(formName) {
  formUrl = formUrls[formName];
  window.open(formUrl + faParams + tfa_3707 + tfa_7 + tfa_5 + tfa_3719 +
              tfa_80 + tfa_84 + tfa_86 + tfa_3707 + tfa_3710 + tfa_3713 +
              tfa_5734);
}

function faFormMapping(){
  // split id, inep and name from school
  id_inep_name = $("#school").val().split(' - ');
  // prefill id
  tfa_3707 = "&tfa_3707=" + $("#school_id").val();
  // prefill inep
  tfa_5 = "&tfa_5=" + id_inep_name[0];
  // prefill school name
  tfa_7 = "&tfa_7=" + id_inep_name[1];
  // prefill person name
  tfa_3719 = "&tfa_3719=" + $("#name").val();
  // prefill person email
  tfa_80 = "&tfa_80=" + $("#email").val();
  // prefill school phone
  tfa_84 = "&tfa_84=" + $("#phone").val();
  // prefill personal phone
  tfa_86 = "&tfa_86=" + $("#personal_phone").val();
  // prefill secretaria
  adm_for_submission = "";
  if(administration == 'Estadual'){
    adm_for_submission = "Rede Estadual" + ' de ' + stateName;
    tfa_3710 = "&tfa_3710=Rede Estadual" + ' de ' + stateName;
    tfa_5734 = "&tfa_5734=Rede Estadual" + ' de ' + stateName;
  }else if (administration == 'Municipal'){
    adm_for_submission = "Rede Municipal" + ' de ' + cityName;
    tfa_3710 = "&tfa_3710=Rede Municipal" + ' de ' + cityName;
    tfa_5734 = "&tfa_5734=Rede Municipal" + ' de ' + cityName;
  }else {
    adm_for_submission = "Rede Federal de Ensino do Brasil";
    tfa_3710 = "&tfa_3710=Rede Federal de Ensino do Brasil";
    tfa_5734 = "&tfa_5734=Rede Federal de Ensino do Brasil";
  }

  // prefill deadline
  tfa_3713 = "";
  if(deadline){
    tfa_3713 = "&tfa_3713=" + deadline;
  }

  if(!faParams){
    faParams = "tfa_63=1&tfa_64=1&tfa_65=1&tfa_66=1&tfa_2567=1&tfa_2568=1&";
  }
}
```
