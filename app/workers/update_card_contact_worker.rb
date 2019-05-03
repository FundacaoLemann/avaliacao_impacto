class UpdateCardContactWorker
  include Sidekiq::Worker

  def perform(contact_id)
    # Before starting, set some context data in case of something going wrong
    Raven.extra_context(
      contact_id: contact_id
    )

    contact = Contact.find(contact_id)
    collect_entry = CollectEntry.where(
      collect: contact.collect,
      school_inep: contact.school_inep
    ).first
    card_id = collect_entry.card_id
    PipefyApi.post(Pipefy::Card.update_school_phone_1(card_id, contact.school_phone))
    PipefyApi.post(Pipefy::Card.update_principal_name(card_id, contact.principal_name))
    PipefyApi.post(Pipefy::Card.update_principal_phone(card_id, contact.principal_phone))
    PipefyApi.post(Pipefy::Card.update_principal_email(card_id, contact.principal_email))

    PipefyApi.post(Pipefy::Card.update_coordinator1_name(card_id, contact.coordinator1_name))
    PipefyApi.post(Pipefy::Card.update_coordinator1_phone(card_id, contact.coordinator1_phone))
    PipefyApi.post(Pipefy::Card.update_coordinator1_email(card_id, contact.coordinator1_email))

    PipefyApi.post(Pipefy::Card.update_coordinator2_name(card_id, contact.coordinator2_name))
    PipefyApi.post(Pipefy::Card.update_coordinator2_phone(card_id, contact.coordinator2_phone))
    PipefyApi.post(Pipefy::Card.update_coordinator2_email(card_id, contact.coordinator2_email))

    PipefyApi.post(Pipefy::Card.update_coordinator3_name(card_id, contact.coordinator3_name))
    PipefyApi.post(Pipefy::Card.update_coordinator3_phone(card_id, contact.coordinator3_phone))
    PipefyApi.post(Pipefy::Card.update_coordinator3_email(card_id, contact.coordinator3_email))

    # Clear the Raven context now, so future errors won't be reported with this data
    Raven::Context.clear!

    # update card member if present
    return if contact.member_email.blank?
    assignee = collect_entry.member.pipefy_id
    PipefyApi.post(
      Pipefy::Card.update_assignee(
        collect_entry.card_id.to_i,
        assignee
      )
    )
  end
end
