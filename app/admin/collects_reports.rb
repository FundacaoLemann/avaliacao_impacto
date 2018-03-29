ActiveAdmin.register_page "Relatório Gerencial de Coletas" do
  content do
    h2 "População: todas as escolas"
    Collect.find_each do |collect|
      h3 i collect.name
      h5 "Status: #{Collect.human_attribute_name(collect.status)} - Formulário: #{collect.form.name} - Prazo: #{collect.deadline}"
      schools_count = {total: 0, sample: 0}
      redirected_count = {total: 0, sample: 0}
      in_progress_count = {total: 0, sample: 0}
      submitted_count = {total: 0, sample: 0}
      table do
        thead do
          tr do
            th 'Rede'
            th 'Responsável'
            th 'Escolas da rede'
            th 'Iniciaram'
            th 'Salvas'
            th 'Enviadas'
            th '% de envio'
          end
        end
        tbody do
          collect.administrations.each do |adm|
            tr do
              td do
                adm.name
              end
              td do
                adm.contact_name
              end
              td do
                current_adm_schools_count = adm.schools.count
                schools_count[:total] += current_adm_schools_count
                current_adm_sample_count = CollectEntry.where(collect_id: collect.id, adm_cod: adm.cod, group: "Amostra").count
                schools_count[:sample] += current_adm_sample_count

                current_adm_schools_count.to_s + " (#{current_adm_sample_count} na amostra)"
              end
              td do
                submissions = adm.submissions.where(collect_id: collect.id, status: :redirected)
                redirected_count[:total] += submissions.count
                sample_count = 0
                submissions_groups = submissions.map(&:group)
                submissions_groups.each { |group| sample_count += 1 if group == "Amostra" }
                redirected_count[:sample] += sample_count

                submissions.count.to_s + " (#{sample_count} na amostra)"
              end
              td do
                submissions = adm.submissions.where(collect_id: collect.id, status: :in_progress)
                in_progress_count[:total] += submissions.count
                sample_count = 0
                submissions_groups = submissions.map(&:group)
                submissions_groups.each { |group| sample_count += 1 if group == "Amostra" }
                in_progress_count[:sample] += sample_count

                submissions.count.to_s + " (#{sample_count} na amostra)"
              end
              td do
                submissions = adm.submissions.where(collect_id: collect.id, status: :submitted)
                submitted_count[:total] += submissions.count
                sample_count = 0
                submissions_groups = submissions.map(&:group)
                submissions_groups.each { |group| sample_count += 1 if group == "Amostra" }
                submitted_count[:sample] += sample_count

                submissions.count.to_s + " (#{sample_count} na amostra)"
              end
              td do
                submissions = adm.submissions.where(collect_id: collect.id, status: :submitted)
                b calculate_submitted_percent(adm.schools.count, submissions.count)
              end
            end
          end
        end

        # footer
        tr do
          td do
            h4 b 'Total'
          end
          td do;end
          td do
            h4 b "#{schools_count[:total]} (#{calculate_submitted_percent(schools_count[:total], schools_count[:sample])} na amostra)"
          end
          td do
            h4 b "#{redirected_count[:total]} (#{calculate_submitted_percent(redirected_count[:total], redirected_count[:sample])} na amostra)"
          end
          td do
            h4 b "#{in_progress_count[:total]} (#{calculate_submitted_percent(in_progress_count[:total], in_progress_count[:sample])} na amostra)"
          end
          td do
            h4 b "#{submitted_count[:total]} (#{calculate_submitted_percent(submitted_count[:total], submitted_count[:sample])} na amostra)"
          end
          td do;end
        end
      end
      hr
    end
  end
end
