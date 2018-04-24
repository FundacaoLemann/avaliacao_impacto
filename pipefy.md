criar uma pagina para fazer trigger na task que
  itera sobre coletas que nao tenham o pipe_id
    clona pipe e edita coleta
    cria os cards daquela coleta

callback no post de submissions


ao criar coleta
 clonar pipe template
 pegar o id do piple clonado
 editar coleta com o id do pipe
 editar nome do pipe com o nome da coleta
 iterar sobre os estratos e adicionar cards com info sobre a escola/rede para cada estrato na phase de triagem(default)
  se a escola já passou por coletas anteriormente, mandar os contatos existentes nas submissões

escola inicia questionario
 atualizar o card com as informações de contato
 atualizar label para "Aguardando resposta do questionário"
 mover card para "Aguardando Resposta"

escola salva questionario
 atualizar label para "Questionário salvo"

escola submete questionario
 atualizar label para "Questionário Respondido"
 mover card para "Questionário Respondido"



pipe clone
{
  "query": "mutation { clonePipes(input: { organization_id: 112528 pipe_template_ids: [430319] }) { pipes { id name } } }"
}

pipe edit
{
  "query": "mutation { updatePipe(input: { id: 430563 name: \"coleta teste\" }) { pipe { id name } } }"
}

create card
{
  "query": "mutation{ createCard(input: {pipe_id: 219739 fields_attributes: [{field_id: \"escola\", field_value: \"value\"} {field_id: \"rede_de_ensino\", field_value: \"value\"} {field_id: \"grupo\", field_value: \"value\"} {field_id: \"contato_respons_vel_pela_rede\", field_value: \"value\"}]}) { card {id title }}}"
}

move card to phases
{
  "query": "mutation{ moveCardToPhase(input: {card_id: 2750027 destination_phase_id: 1624317 }){ card{ id current_phase { name } } } }"
}

update card label
{
  "query": "mutation{ updateCard(input: {id: 2762646 label_ids: [890073] }) { card { id title }}}"
}

update card fields from submission data
{
  "query": "mutation{ updateCardField(input: {card_id: 2750027 field_id: \"telefone_da_escola\" new_value: \"Telefone da escola from api\" }){ card{ id } } }"
}
{
  "query": "mutation{ updateCardField(input: {card_id: 2750027 field_id: \"nome_do_gestor\" new_value: \"Telefone da escola from api\" }){ card{ id } } }"
}
{
  "query": "mutation{ updateCardField(input: {card_id: 2750027 field_id: \"email_do_gestor\" new_value: \"Telefone da escola from api\" }){ card{ id } } }"
}
{
  "query": "mutation{ updateCardField(input: {card_id: 2750027 field_id: \"telefone_do_gestor\" new_value: \"Telefone da escola from api\" }){ card{ id } } }"
}

"phases": [
  {
    "name": "Triagem",
    "id": "2967899"
  },
  {
    "name": "Atendimento",
    "id": "2967900"
  },
  {
    "name": "Aguardando resposta do questionário",
    "id": "2967901"
  },
  {
    "name": "Questionário Respondido",
    "id": "2967902"
  },
  {
    "name": "Desistentes",
    "id": "2967903"
  }
]

"labels": [
  {
    "name": "Questionário iniciado",
    "id": "1679631"
  },
  {
    "name": "Questionário salvo",
    "id": "1679637"
  },
  {
    "name": "Resposta enviada",
    "id": "1679638"
  }
]

      "phases": [
        {
        "name": "Aguardando resposta do questionário",
        "fields": [
          {
            "label": "Status da resposta",
            "id": "status_da_resposta_1"
          },
          {
            "label": "Telefone da escola",
            "id": "telefone_da_escola"
          },
          {
            "label": "Nome do gestor",
            "id": "nome_do_gestor"
          },
          {
            "label": "Email do gestor",
            "id": "email_do"
          },
          {
            "label": "Telefone do gestor",
            "id": "telefone_do_gestor"
          }
        ],
        },
        {
          "name": "Questionário Respondido",
          "fields": [
            {
              "label": "Status da resposta",
              "id": "status_da_resposta"
            }
          ],
          "cards": {
            "edges": []
          }
        }
      ]
    }
  }
}
