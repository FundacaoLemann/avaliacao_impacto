require "rails_helper"

RSpec.describe Pipefy::Pipe, type: :model do
  let(:pipe) do
    Pipefy::Pipe.create_from_json_response(
      {"data"=>
        {"pipe"=>
          {"id"=>"441228",
            "name"=>"Acompanhamento de resultados educacionais 2018.1",
            "labels"=>
              [
                {"name"=>"Crítico", "id"=>"1719803"},
                {"name"=>"Alta prioridade", "id"=>"1719804"},
                {"name"=>"Média prioridade", "id"=>"1719805"},
                {"name"=>"Baixa prioridade", "id"=>"1719806"},
                {"name"=>"Indefinido", "id"=>"1719807"},
                {"name"=>"Questionário iniciado", "id"=>"1719808"},
                {"name"=>"Questionário salvo", "id"=>"1719809"},
                {"name"=>"Resposta enviada", "id"=>"1719810"}
              ],
            "phases"=>
              [
                {"name"=>"Repescagem", "id"=>"3065929"},
                {"name"=>"Triagem", "id"=>"3039319"},
                {"name"=>"Nenhum Retorno", "id"=>"3039320"},
                {"name"=>"Algum retorno", "id"=>"3039321"},
                {"name"=>"Quest. em progresso", "id"=>"3039322"},
                {"name"=>"Quest. Respondido", "id"=>"3039323"},
                {"name"=>"Desistentes", "id"=>"3039324"}
              ]
          }
        }
      }
    )
  end

  describe "#label_id" do
    it "returns the corret label for the given status" do
      expect(pipe.label_id(:redirected)).to eq("1719808")
    end

    it "returns the corret label for the given status" do
      expect(pipe.label_id(:in_progress)).to eq("1719809")
    end

    it "returns the corret label for the given status" do
      expect(pipe.label_id(:submitted)).to eq("1719810")
    end
  end

  describe "#phase_id" do
    it "returns the corret label for the given status" do
      expect(pipe.phase_id(:redirected)).to eq("3039322")
    end

    it "returns the corret label for the given status" do
      expect(pipe.phase_id(:submitted)).to eq("3039323")
    end
  end

  describe "#update_pipe_name" do
    it "returns the corret query for the given param" do
      expected_query = {
        "query": "mutation { updatePipe(input: { id: 441228 name: \"name\" }) { pipe { id name } } }"
      }

      expect(pipe.update_pipe_name("name")).to eq(expected_query)
    end
  end

  describe "#update_card_label" do
    it "returns the corret query for the given params" do
      expected_query = {
        "query": "mutation{ updateCard(input: {id: 1 label_ids: [1719810] }) { card { id title }}}"
      }

      expect(pipe.update_card_label(1, :submitted)).to eq(expected_query)
    end
  end

  describe "#move_card_to_phase" do
    it "returns the corret query for the given params" do
      expected_query = {
        "query": "mutation{ moveCardToPhase(input: {card_id: 1 destination_phase_id: 3039323 }){ card{ id current_phase { name } } } }"
      }

      expect(pipe.move_card_to_phase(1, :submitted)).to eq(expected_query)
    end
  end

  describe ".clone_query" do
    it "returns the correct query with the ENV values" do
      allow(ENV).to receive(:[]).with("PIPEFY_ORGANIZATION_ID").and_return(1)
      allow(ENV).to receive(:[]).with("PIPEFY_PIPE_TEMPLATE_ID").and_return(2)

      organization_id = ENV["PIPEFY_ORGANIZATION_ID"]
      pipe_template_ids = ENV["PIPEFY_PIPE_TEMPLATE_ID"]

      expected_query = {
        "query": "mutation { clonePipes(input: { organization_id: #{organization_id} pipe_template_ids: [#{pipe_template_ids}] }) { pipes { id name } } }"
      }

      expect(Pipefy::Pipe.clone_query).to eq(expected_query)
    end
  end

  describe ".show" do
    it "returns the correct query for the given value" do
      id = 1
      expected_query = {
        "query": "{ pipe(id: #{id}) { id name labels { name id } phases { name id } } }"
      }

      expect(Pipefy::Pipe.show(id)).to eq(expected_query)
    end
  end

  describe ".create_from_json_response" do
    subject { pipe }

    it "returns the correct pipefy_id" do
      expect(subject.pipefy_id).to eq(441228)
    end

    it "returns the correct name" do
      expect(subject.name).to eq("Acompanhamento de resultados educacionais 2018.1")
    end

    it "returns the correct labels" do
      expected_labels = [
        "{\"name\"=>\"Crítico\", \"id\"=>\"1719803\"}",
        "{\"name\"=>\"Alta prioridade\", \"id\"=>\"1719804\"}",
        "{\"name\"=>\"Média prioridade\", \"id\"=>\"1719805\"}",
        "{\"name\"=>\"Baixa prioridade\", \"id\"=>\"1719806\"}",
        "{\"name\"=>\"Indefinido\", \"id\"=>\"1719807\"}",
        "{\"name\"=>\"Questionário iniciado\", \"id\"=>\"1719808\"}",
        "{\"name\"=>\"Questionário salvo\", \"id\"=>\"1719809\"}",
        "{\"name\"=>\"Resposta enviada\", \"id\"=>\"1719810\"}"
      ]

      expect(subject.labels).to eq(expected_labels)
    end

    it "returns the correct phases" do
      expected_phases = [
        "{\"name\"=>\"Repescagem\", \"id\"=>\"3065929\"}",
        "{\"name\"=>\"Triagem\", \"id\"=>\"3039319\"}",
        "{\"name\"=>\"Nenhum Retorno\", \"id\"=>\"3039320\"}",
        "{\"name\"=>\"Algum retorno\", \"id\"=>\"3039321\"}",
        "{\"name\"=>\"Quest. em progresso\", \"id\"=>\"3039322\"}",
        "{\"name\"=>\"Quest. Respondido\", \"id\"=>\"3039323\"}",
        "{\"name\"=>\"Desistentes\", \"id\"=>\"3039324\"}"
      ]

      expect(subject.phases).to eq(expected_phases)
    end
  end
end
