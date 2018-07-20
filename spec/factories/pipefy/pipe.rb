FactoryBot.define do
  factory :pipe, class: Pipefy::Pipe do
    pipefy_id { rand(1..1000) }
    name { FFaker::Company.name }
    labels do
      [
        "{\"name\"=>\"Substituir esta escola\", \"id\"=>\"1\"}",
        "{\"name\"=>\"Tentei falar, os contatos estão corretos, mas fui ignorada\", \"id\"=>\"2\"}",
        "{\"name\"=>\"Questionário iniciado\", \"id\"=>\"3\"}",
        "{\"name\"=>\"Resposta enviada\", \"id\"=>\"4\"}",
        "{\"name\"=>\"Questionário salvo\", \"id\"=>\"5\"}",
        "{\"name\"=>\"Consegui falar, acho que vai dar certo\", \"id\"=>\"6\"}",
        "{\"name\"=>\"Preciso de outro contato para falar com esta escola\", \"id\"=>\"7\"}"
      ]
    end
    phases do
      [
        "{\"name\"=>\"Repescagem\", \"id\"=>\"1\"}",
        "{\"name\"=>\"Triagem\", \"id\"=>\"2\"}",
        "{\"name\"=>\"Contato Realizado com Gestor\", \"id\"=>\"3\"}",
        "{\"name\"=>\"Nenhum Retorno\", \"id\"=>\"4\"}",
        "{\"name\"=>\"Quest. em progresso\", \"id\"=>\"5\"}",
        "{\"name\"=>\"Quest. Respondido\", \"id\"=>\"6\"}",
        "{\"name\"=>\"Desistentes\", \"id\"=>\"7\"}"
      ]
    end
  end
end
