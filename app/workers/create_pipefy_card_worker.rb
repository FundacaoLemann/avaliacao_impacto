class CreatePipefyCardWorker
  include Sidekiq::Worker

  def perform(collect_entry_id, pipe_id)
    collect_entry = CollectEntry.find(collect_entry_id)
    return if collect_entry.card_id

    school_name = collect_entry.school.to_s
    adm_name = collect_entry.administration.name
    adm_contact = collect_entry.administration.contact_name
    ce_group = collect_entry.grupo

    contacts = Submission.where(school_inep: collect_entry.school.inep).map(&:contacts)

    response = PipefyApi.post(
      Pipefy::Card.create_card(
        pipe_id,
        school_name,
        adm_name,
        adm_contact,
        ce_group,
        contacts
      )
    )
    parsed_response = JSON.parse(response.body)
    card_id = parsed_response["data"]["createCard"]["card"]["id"]
    collect_entry.update(card_id: card_id.to_i)

    PipefyApi.post(collect_entry.collect.pipe.move_card_to_phase(card_id.to_i, :triagem)) if ce_group == "Amostra"
  end
end
