class UpdateCardContactWorker
  include Sidekiq::Worker

  def perform(contact_id)
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
  end
end
