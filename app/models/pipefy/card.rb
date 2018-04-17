module Pipefy::Card
  module_function

  def create_card(pipe_id, school_name, adm_name, adm_contact, ce_group, contacts)
    {
      "query": "mutation{ createCard(input: {pipe_id: #{pipe_id} fields_attributes: [{field_id: \"escola\", field_value: \"#{school_name}\"} {field_id: \"rede_de_ensino\", field_value: \"#{adm_name}\"} {field_id: \"grupo\", field_value: \"#{ce_group}\"} {field_id: \"contato_respons_vel_pela_rede\", field_value: \"#{adm_contact}\"} {field_id: \"contatos\", field_value: \"#{contacts}\"}]}) { card {id title }}}"
    }
  end

  def update_school_phone(id, school_phone)
    {
      "query": "mutation{ updateCardField(input: {card_id: #{id} field_id: \"telefone_da_escola\" new_value: \"#{school_phone}\" }){ card{ id } } }"
    }
  end

  def update_submitter_name(id, submitter_name)
    {
      "query": "mutation{ updateCardField(input: {card_id: #{id} field_id: \"nome_do_gestor\" new_value: \"#{submitter_name}\" }){ card{ id } } }"
    }
  end

  def update_submitter_phone(id, submitter_phone)
    {
      "query": "mutation{ updateCardField(input: {card_id: #{id} field_id: \"email_do_gestor\" new_value: \"#{submitter_phone}\" }){ card{ id } } }"
    }
  end

  def update_submitter_email(id, submitter_email)
    {
      "query": "mutation{ updateCardField(input: {card_id: #{id} field_id: \"telefone_do_gestor\" new_value: \"#{submitter_email}\" }){ card{ id } } }"
    }
  end
end
