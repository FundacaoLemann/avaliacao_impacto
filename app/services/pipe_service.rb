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
    @collect.contacts.select("DISTINCT ON (school_inep, collect_id) *").each do |contact|
      UpdateCardContactWorker.perform_async(contact.id)
    end
  end

  def update_members
    @collect.collect_entries.find_each do |collect_entry|
      UpdateCardMemberWorker.perform_async(collect_entry.id)
    end
  end

  def self.first_card_update(collect_entry, pipe, params)
    PipefyApi.post(pipe.update_card_label(collect_entry.card_id, :redirected))
    PipefyApi.post(pipe.move_card_to_phase(collect_entry.card_id, :redirected))

    PipefyApi.post(Pipefy::Card.update_school_phone(collect_entry.card_id, params[:school_phone]))
    PipefyApi.post(Pipefy::Card.update_submitter_name(collect_entry.card_id, params[:submitter_name]))
    PipefyApi.post(Pipefy::Card.update_submitter_phone(collect_entry.card_id, params[:submitter_phone]))
    PipefyApi.post(Pipefy::Card.update_submitter_email(collect_entry.card_id, params[:submitter_email]))
  end

  def self.update_card_to_submitted(submission, pipe)
    PipefyApi.post(pipe.update_card_label(submission.card_id, :submitted))
    PipefyApi.post(pipe.move_card_to_phase(submission.card_id, :submitted))
  end
end
