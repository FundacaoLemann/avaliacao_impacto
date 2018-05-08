require "rails_helper"

RSpec.describe Pipefy::Card, type: :model do
  describe ".create_card" do
    it "returns the correct query for the given params" do
      pipe_id = 1
      school_name = "school name"
      adm_name = "adm name"
      adm_contact = "adm contact"
      ce_group = "Amostra"
      contacts = "contatcs"

      expected_query = {
        "query": "mutation{ createCard(input: {pipe_id: #{pipe_id} fields_attributes: [{field_id: \"escola\", field_value: \"#{school_name}\"} {field_id: \"rede_de_ensino\", field_value: \"#{adm_name}\"} {field_id: \"grupo\", field_value: \"#{ce_group}\"} {field_id: \"contato_respons_vel_pela_rede\", field_value: \"#{adm_contact}\"} {field_id: \"contatos\", field_value: \"#{contacts}\"}]}) { card {id title }}}"
      }

      expect(Pipefy::Card.create_card(pipe_id, school_name, adm_name, adm_contact, ce_group, contacts)).to eq(expected_query)
    end
  end

  describe ".update_school_phone" do
    it "returns the correct query for the given params" do
      id = 1
      school_phone = "school phone"

      expected_query = {
        "query": "mutation{ updateCardField(input: {card_id: #{id} field_id: \"telefone_da_escola\" new_value: \"#{school_phone}\" }){ card{ id } } }"
      }

      expect(Pipefy::Card.update_school_phone(id, school_phone)).to eq(expected_query)
    end
  end

  describe ".update_submitter_name" do
    it "returns the correct query for the given params" do
      id = 1
      submitter_name = "submitter name"

      expected_query = {
        "query": "mutation{ updateCardField(input: {card_id: #{id} field_id: \"nome_do_gestor\" new_value: \"#{submitter_name}\" }){ card{ id } } }"
      }

      expect(Pipefy::Card.update_submitter_name(id, submitter_name)).to eq(expected_query)
    end
  end

  describe ".update_submitter_phone" do
    it "returns the correct query for the given params" do
      id = 1
      submitter_phone = "submitter phone"

      expected_query = {
        "query": "mutation{ updateCardField(input: {card_id: #{id} field_id: \"email_do_gestor\" new_value: \"#{submitter_phone}\" }){ card{ id } } }"
      }

      expect(Pipefy::Card.update_submitter_phone(id, submitter_phone)).to eq(expected_query)
    end
  end

  describe ".update_submitter_email" do
    it "returns the correct query for the given params" do
      id = 1
      submitter_email = "submitter email"

      expected_query = {
        "query": "mutation{ updateCardField(input: {card_id: #{id} field_id: \"telefone_do_gestor\" new_value: \"#{submitter_email}\" }){ card{ id } } }"
      }

      expect(Pipefy::Card.update_submitter_email(id, submitter_email)).to eq(expected_query)
    end
  end

  describe ".update_assignee" do
    it "returns the correct query for the given params" do
      card_id = 1
      assignee_id = 2

      expected_query = {
        "query": "mutation{ updateCard(input: {id: #{card_id} assignee_ids: [#{assignee_id}] }) { card { id title }}}"
      }

      expect(Pipefy::Card.update_assignee(card_id, assignee_id)).to eq(expected_query)
    end
  end
end
