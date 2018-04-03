ActiveAdmin.register_page "Relatório Gerencial de Coletas por Amostra" do
  content do
    h2 "População: amostra"
    Collect.find_each do |collect|
      h3 i collect.name
      h5 "Status: #{Collect.human_attribute_name(collect.status)} - Questionário: #{collect.form.name} - Prazo: #{collect.deadline}"
      schools_count = 0
      repescagem_count = 0
      redirected_count = 0
      in_progress_count = 0
      submitted_count = 0
      table do
        thead do
          tr do
            th 'Rede'
            th 'Responsável'
            th 'Escolas na amostra'
            th 'Escolas substituídas'
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
                current_adm_sample_count = CollectEntry.where(collect_id: collect.id, adm_cod: adm.cod, group: "Amostra").count
                schools_count += current_adm_sample_count

                current_adm_sample_count
              end
              td do
                current_adm_repescagem_count = CollectEntry.where(collect_id: collect.id, adm_cod: adm.cod, group: "Repescagem").count
                repescagem_count += current_adm_repescagem_count

                current_adm_repescagem_count
              end
              td do
                submissions = adm.submissions.where(collect_id: collect.id, status: :redirected)
                sample_count = 0
                submissions_groups = submissions.map(&:group)
                submissions_groups.each { |group| sample_count += 1 if group == "Amostra" }
                redirected_count += sample_count

                sample_count
              end
              td do
                submissions = adm.submissions.where(collect_id: collect.id, status: :in_progress)
                sample_count = 0
                submissions_groups = submissions.map(&:group)
                submissions_groups.each { |group| sample_count += 1 if group == "Amostra" }
                in_progress_count += sample_count

                sample_count
              end
              td do
                submissions = adm.submissions.where(collect_id: collect.id, status: :submitted)
                sample_count = 0
                submissions_groups = submissions.map(&:group)
                submissions_groups.each { |group| sample_count += 1 if group == "Amostra" }
                submitted_count += sample_count

                sample_count
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
            h4 b schools_count
          end
          td do
            h4 b "#{repescagem_count} (#{calculate_submitted_percent(schools_count, repescagem_count)})"
          end
          td do
            h4 b "#{redirected_count} (#{calculate_submitted_percent(schools_count, redirected_count)})"
          end
          td do
            h4 b "#{in_progress_count} (#{calculate_submitted_percent(schools_count, in_progress_count)})"
          end
          td do
            h4 b "#{submitted_count}"
          end
          td do
            h4 b "#{calculate_submitted_percent(schools_count, submitted_count)}"
          end
        end
      end
      hr
    end
  end
end
