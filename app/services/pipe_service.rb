class PipeService
  def initialize(collect)
    @collect = collect
  end

  def clone
    clone_response = PipefyApi.post(Pipefy::Pipe.clone_query)
    sleep 2 # without the wait the pipe was returning without the labels and phases
    cloned_pipe = fetch_cloned_pipe(clone_response)

    Pipefy::Pipe.create_from_json_response(cloned_pipe)
  end

  def fetch_cloned_pipe(clone_response)
    parsed_response = JSON.parse(clone_response.body)
    cloned_pipe_id = parsed_response["data"]["clonePipes"]["pipes"][0]["id"]

    JSON.parse(PipefyApi.post(Pipefy::Pipe.show(cloned_pipe_id)))
  end

  def create_cards(pipe_id)
    @collect.collect_entries.find_each do |collect_entry|
      CreatePipefyCardWorker.perform_async(collect_entry.id, pipe_id)
    end
  end

  def update_cards
    @collect.contacts.find_each do |contact|
      UpdateCardContactWorker.perform_async(contact.id)
    end
  end
end
