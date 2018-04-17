namespace :pipefy do
  desc "Import the 2018.1 schools to pipefy with pre-defined contact information"
  task import_cards: :environment do
    ce_not_found = []

    CSV.foreach("lib/assets/collect_entries_2018.csv", headers: false) do |row|
      collect_entry = CollectEntry.where(school_inep: row[0], collect_id: row[1]).first

      if collect_entry
        school_name = collect_entry.school.to_s
        adm_name = collect_entry.administration.name
        adm_contact = collect_entry.administration.contact_name
        ce_group = collect_entry.group
        contacts = parse_contacts(row)

        response = PipefyApi.post(
          Pipefy::Card.create_card(
            "441228",
            school_name,
            adm_name,
            adm_contact,
            ce_group,
            contacts
          )
        )
        parsed_response = JSON.parse(response.body)
        while parsed_response.nil?
          puts "=========================================RETRYING CARD"
          response = PipefyApi.post(
            Pipefy::Card.create_card(
              "441228",
              school_name,
              adm_name,
              adm_contact,
              ce_group,
              contacts
            )
          )
          parsed_response = JSON.parse(response.body)
        end
        card_id = parsed_response["data"]["createCard"]["card"]["id"]
        collect_entry.update(card_id: card_id.to_i)
      else
        ce_not_found << row
      end
    end

    p 'Done!'
    p 'Not found Collect Entries'
    p ce_not_found
  end

  def parse_contacts(row)
    return "sem contato" if row[2] == "PARALISADA" || row[2] == "#N/A"
    contacts = ""
    contacts << "Telefone da escola: #{row[2]}\n" if row[2] != "0" || row[2] == ""
    contacts << "Nome do diretor: #{row[3]}\n" if row[3] != "0" || row[3] == ""
    contacts << "Celular do diretor: #{row[4]}\n" if row[4] != "0" || row[4] == ""
    contacts << "Email do diretor: #{row[5]}\n" if row[5] != "0" || row[5] == ""
    contacts << "Qtde de diretores: #{row[6]}\n" if row[6] != "0" || row[6] == ""
    contacts << "Qtde de coordenadores pedagógicos: #{row[7]}\n" if row[7] != "0" || row[7] == ""
    contacts << "Nome do coordenador: #{row[8]}\n" if row[8] != "0" || row[8] == ""
    contacts << "Celular do coordenador: #{row[9]}\n" if row[9] != "0" || row[9] == ""
    contacts << "Email do coordenador: #{row[10]}\n" if row[10] != "0" || row[10] == ""
    contacts << "Nome do coordenador: #{row[11]}\n" if row[11] != "0" || row[11] == ""
    contacts << "Celular do coordenador: #{row[12]}\n" if row[12] != "0" || row[12] == ""
    contacts << "Email do coordenador: #{row[13]}\n" if row[13] != "0" || row[13] == ""
    contacts << "Nome do coordenador: #{row[14]}\n" if row[14] != "0" || row[14] == ""
    contacts << "Celular do coordenador: #{row[15]}\n" if row[15] != "0" || row[15] == ""
    contacts << "Email do coordenador: #{row[16]}\n" if row[16] != "0" || row[16] == ""
    contacts
  end
end
