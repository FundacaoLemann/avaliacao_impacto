class Pipefy::Pipe < ApplicationRecord
  LABEL_MAPPING = {
    redirected: "Questionário iniciado",
    in_progress: "Questionário salvo",
    submitted: "Resposta enviada"
  }.freeze

  PHASE_MAPPING = {
    redirected: "Quest. em progresso",
    submitted: "Quest. Respondido",
    triagem: "Triagem"
  }.freeze

  def label_id(status)
    raw_string = labels.select { |label| label.include? LABEL_MAPPING[status] }
    parsed_json = JSON.parse raw_string.first.gsub('=>', ':')
    parsed_json["id"]
  end

  def phase_id(status)
    raw_string = phases.select { |phase| phase.include? PHASE_MAPPING[status] }
    parsed_json = JSON.parse raw_string.first.gsub('=>', ':')
    parsed_json["id"]
  end

  def update_pipe_name(name)
    update(name: name)
    {
      "query": "mutation { updatePipe(input: { id: #{pipefy_id} name: \"#{name}\" }) { pipe { id name } } }"
    }
  end

  def update_card_label(card_id, status)
    {
      "query": "mutation{ updateCard(input: {id: #{card_id} label_ids: [#{label_id(status)}] }) { card { id title }}}"
    }
  end

  def move_card_to_phase(card_id, phase)
    {
      "query": "mutation{ moveCardToPhase(input: {card_id: #{card_id} destination_phase_id: #{phase_id(phase)} }){ card{ id current_phase { name } } } }"
    }
  end

  class << self
    def clone_query
      organization_id = ENV['PIPEFY_ORGANIZATION_ID']
      pipe_template_ids = ENV['PIPEFY_PIPE_TEMPLATE_ID']
      {
        "query": "mutation { clonePipes(input: { organization_id: #{organization_id} pipe_template_ids: [#{pipe_template_ids}] }) { pipes { id name } } }"
      }
    end

    def show(id)
      {
        "query": "{ pipe(id: #{id}) { id name labels { name id } phases { name id } } }"
      }
    end

    def create_from_json_response(json_payload)
      Pipefy::Pipe.create(
        pipefy_id: json_payload["data"]["pipe"]["id"].to_i,
        name: json_payload["data"]["pipe"]["name"],
        labels: json_payload["data"]["pipe"]["labels"],
        phases: json_payload["data"]["pipe"]["phases"]
      )
    end
  end
end
