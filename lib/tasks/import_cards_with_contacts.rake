namespace :pipefy do
  desc "Import the 2018.1 schools to pipefy with pre-defined contact information"
  task import_cards: :environment do
    ce_not_found = []

    CSV.foreach("lib/assets/collect_entries_2018.csv", headers: false) do |row|
      binding.pry
      collect_entry = CollectEntry.where(school_inep: row[0], collect_id: row[1])

      if collect_entry
        puts "Creating card"

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
    <<-END
      Telefone da escola: #{row[2]}
      Nome do diretor: #{row[3]}
      Celular do diretor: #{row[4]}
      Email do diretor: #{row[5]}
      Qtde de diretores: #{row[6]}
      Qtde de coordenadores pedagógicos: #{row[7]}
      Nome do coordenador: #{row[8]}
      Celular do coordenador: #{row[9]}
      Email do coordenador: #{row[10]}
      Nome do coordenador: #{row[11]}
      Celular do coordenador: #{row[12]}
      Email do coordenador: #{row[13]}
      Nome do coordenador: #{row[14]}
      Celular do coordenador: #{row[15]}
      Email do coordenador: #{row[16]}
    END
  end
end
