ActiveAdmin.register_page "Gerencial por rede (apenas escolas da amostra)" do
  menu priority: 3, parent: "Relatórios", if: -> { current_admin_user.admin? }
  content do
    h2 "População: amostra"
    Collect.all.group_by(&:name).each do |collect_group|
      h3 i collect_group[0]
      schools_count = 0
      repescagem_count = 0
      redirected_count = 0
      in_progress_count = 0
      submitted_count = 0
      quitter_count = 0
      substitutes_count = 0
      submitted_sample_count = 0

      current_adm_sample_count = 0
      current_adm_substitutes_count = 0
      current_adm_quitter_count = 0
      table do
        thead do
          tr do
            th "Rede"
            th "Responsável"
            th "Escolas na amostra"
            th "Escolas desistentes"
            th "Escolas substitutas"
            th "Iniciaram"
            th "Salvas"
            th "Enviadas"
            th "% de envio"
          end
        end
        tbody do
          collect_group[1].each do |collect|
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
                  submissions = adm.submissions.where(collect_id: collect.id, status: :quitter)
                  current_adm_quitter_count = 0
                  submissions_groups = submissions.map(&:group)
                  submissions_groups.each { |group| current_adm_quitter_count += 1 if group == "Amostra" }
                  current_quitter_ce = CollectEntry.where(collect_id: collect.id, adm_cod: adm.cod, quitter: true).count
                  current_adm_quitter_count += current_quitter_ce
                  quitter_count += current_adm_quitter_count

                  current_adm_quitter_count
                end
                td do
                  current_adm_substitutes_count = CollectEntry.where(collect_id: collect.id, adm_cod: adm.cod, substitute: true, quitter: false).count
                  substitutes_count += current_adm_substitutes_count

                  current_adm_substitutes_count
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
                  submitted_sample_count = 0
                  submissions_groups = submissions.map(&:group)
                  submissions_groups.each { |group| submitted_sample_count += 1 if group == "Amostra" }
                  substitutes = submissions.map(&:substitute)
                  substitutes.each { |substitute| submitted_sample_count += 1 if substitute }

                  submitted_count += submitted_sample_count

                  submitted_sample_count
                end
                td do
                  schools_total = current_adm_sample_count - current_adm_quitter_count + current_adm_substitutes_count
                  b calculate_submitted_percent(schools_total, submitted_sample_count)
                end
              end
            end
          end
        end

        # footer
        tr do
          td do
            h4 b "Total"
          end
          td do; end
          td do
            h4 b schools_count
          end
          td do
            h4 b "#{quitter_count} (#{calculate_submitted_percent(schools_count, quitter_count)})"
          end
          td do
            h4 b "#{substitutes_count} (#{calculate_submitted_percent(schools_count, substitutes_count)})"
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
            schools_total = schools_count - quitter_count + substitutes_count
            h4 b "#{calculate_submitted_percent(schools_total, submitted_count)}"
          end
        end
      end
      hr
    end
  end
end
