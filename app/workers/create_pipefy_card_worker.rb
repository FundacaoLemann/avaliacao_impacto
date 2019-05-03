class CreatePipefyCardWorker
  include Sidekiq::Worker

  def perform(collect_entry_id, pipe_id)
    # Before starting, set some context data in case of something going wrong
    Raven.extra_context(
      collect_entry_id: collect_entry_id,
      pipe_id: pipe_id
    )

    collect_entry = CollectEntry.find(collect_entry_id)
    return if collect_entry.card_id

    school_name = collect_entry.school.to_s
    adm_name = collect_entry.administration.name
    adm_contact = collect_entry.administration.contact_name
    ce_group = collect_entry.grupo

    response = PipefyApi.post(
      Pipefy::Card.create_card(
        pipe_id,
        school_name,
        adm_name,
        adm_contact,
        ce_group,
        []
      )
    )
    parsed_response = JSON.parse(response.body)
    card_id = parsed_response["data"]["createCard"]["card"]["id"]
    collect_entry.update(card_id: card_id.to_i)

    PipefyApi.post(collect_entry.collect.pipe.move_card_to_phase(card_id.to_i, :triagem)) if ce_group == "Amostra"

    # Clear the Raven context now, so future errors won't be reported with this data
    Raven::Context.clear!
  end
end
