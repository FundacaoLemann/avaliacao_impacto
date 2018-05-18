module Pipefy::Card
  module_function

  def create_card(pipe_id, school_name, adm_name, adm_contact, ce_group, contacts)
    {
      "query": "mutation{ createCard(input: {pipe_id: #{pipe_id} fields_attributes: [{field_id: \"escola\", field_value: \"#{school_name}\"} {field_id: \"rede_de_ensino\", field_value: \"#{adm_name}\"} {field_id: \"grupo\", field_value: \"#{ce_group}\"} {field_id: \"contato_respons_vel_pela_rede\", field_value: \"#{adm_contact}\"} {field_id: \"contatos_de_outras_coletas\", field_value: \"#{contacts}\"}]}) { card {id title }}}"
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

  def update_school_phone_1(id, school_phone)
    {
      "query": "mutation{ updateCardField(input: {card_id: #{id} field_id: \"telefone_da_escola_1\" new_value: \"#{school_phone}\" }){ card{ id } } }"
    }
  end

  def update_principal_name(id, principal_name)
    {
      "query": "mutation{ updateCardField(input: {card_id: #{id} field_id: \"nome_do_diretor\" new_value: \"#{principal_name}\" }){ card{ id } } }"
    }
  end

  def update_principal_phone(id, principal_phone)
    {
      "query": "mutation{ updateCardField(input: {card_id: #{id} field_id: \"telefone_do_diretor\" new_value: \"#{principal_phone}\" }){ card{ id } } }"
    }
  end

  def update_principal_email(id, principal_email)
    {
      "query": "mutation{ updateCardField(input: {card_id: #{id} field_id: \"email_do_diretor\" new_value: \"#{principal_email}\" }){ card{ id } } }"
    }
  end

  def update_coordinator1_name(id, coordinator1_name)
    {
      "query": "mutation{ updateCardField(input: {card_id: #{id} field_id: \"nome_do_coordenador\" new_value: \"#{coordinator1_name}\" }){ card{ id } } }"
    }
  end

  def update_coordinator1_phone(id, coordinator1_phone)
    {
      "query": "mutation{ updateCardField(input: {card_id: #{id} field_id: \"telefone_do_coordenador\" new_value: \"#{coordinator1_phone}\" }){ card{ id } } }"
    }
  end

  def update_coordinator1_email(id, coordinator1_email)
    {
      "query": "mutation{ updateCardField(input: {card_id: #{id} field_id: \"email_do_coordenador\" new_value: \"#{coordinator1_email}\" }){ card{ id } } }"
    }
  end

  def update_coordinator2_name(id, coordinator2_name)
    {
      "query": "mutation{ updateCardField(input: {card_id: #{id} field_id: \"nome_do_coordenador_2\" new_value: \"#{coordinator2_name}\" }){ card{ id } } }"
    }
  end

  def update_coordinator2_phone(id, coordinator2_phone)
    {
      "query": "mutation{ updateCardField(input: {card_id: #{id} field_id: \"telefone_do_coordenador_2\" new_value: \"#{coordinator2_phone}\" }){ card{ id } } }"
    }
  end

  def update_coordinator2_email(id, coordinator2_email)
    {
      "query": "mutation{ updateCardField(input: {card_id: #{id} field_id: \"email_do_coordenador_2\" new_value: \"#{coordinator2_email}\" }){ card{ id } } }"
    }
  end

  def update_coordinator3_name(id, coordinator3_name)
    {
      "query": "mutation{ updateCardField(input: {card_id: #{id} field_id: \"nome_do_coordenador_3\" new_value: \"#{coordinator3_name}\" }){ card{ id } } }"
    }
  end

  def update_coordinator3_phone(id, coordinator3_phone)
    {
      "query": "mutation{ updateCardField(input: {card_id: #{id} field_id: \"telefone_do_coordenador_3\" new_value: \"#{coordinator3_phone}\" }){ card{ id } } }"
    }
  end

  def update_coordinator3_email(id, coordinator3_email)
    {
      "query": "mutation{ updateCardField(input: {card_id: #{id} field_id: \"email_do_coordenador_3\" new_value: \"#{coordinator3_email}\" }){ card{ id } } }"
    }
  end

  def update_assignee(id, member_id)
    {
      "query": "mutation{ updateCard(input: {id: #{id} assignee_ids: [#{member_id}] }) { card { id title }}}"
    }
  end
end
