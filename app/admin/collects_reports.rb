ActiveAdmin.register_page "Gerencial por rede" do
  menu priority: 2, parent: "Relatórios", if: -> { current_admin_user.admin? }
  content do
    h2 "População: todas as escolas"
    Collect.all.group_by(&:name).each do |collect_group|
      h3 i collect_group[0]
      schools_count = {total: 0, sample: 0}
      redirected_count = {total: 0, sample: 0}
      in_progress_count = {total: 0, sample: 0}
      submitted_count = {total: 0, sample: 0}
      table do
        thead do
          tr do
            th "Rede"
            th "Responsável"
            th "Escolas da rede"
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
                  current_adm_schools_count = adm.schools.fundamental.count
                  schools_count[:total] += current_adm_schools_count
                  current_adm_sample_count = CollectEntry.where(collect_id: collect.id, adm_cod: adm.cod, group: "Amostra").count
                  schools_count[:sample] += current_adm_sample_count

                  current_adm_schools_count.to_s + " (#{current_adm_sample_count} na amostra)"
                end
                td do
                  submissions = adm.submissions.select("DISTINCT ON (school_inep) *").where(collect_id: collect.id, status: :redirected)
                  redirected_count[:total] += submissions.reload.size
                  sample_count = 0
                  submissions_groups = submissions.map(&:group)
                  submissions_groups.each { |group| sample_count += 1 if group == "Amostra" }
                  redirected_count[:sample] += sample_count

                  submissions.reload.size.to_s + " (#{sample_count} na amostra)"
                end
                td do
                  submissions = adm.submissions.select("DISTINCT ON (school_inep) *").where(collect_id: collect.id, status: :in_progress)
                  in_progress_count[:total] += submissions.reload.size
                  sample_count = 0
                  submissions_groups = submissions.map(&:group)
                  submissions_groups.each { |group| sample_count += 1 if group == "Amostra" }
                  in_progress_count[:sample] += sample_count

                  submissions.reload.size.to_s + " (#{sample_count} na amostra)"
                end
                td do
                  submissions = adm.submissions.select("DISTINCT ON (school_inep) *").where(collect_id: collect.id, status: :submitted)
                  submitted_count[:total] += submissions.reload.size
                  sample_count = 0
                  submissions_groups = submissions.map(&:group)
                  submissions_groups.each { |group| sample_count += 1 if group == "Amostra" }
                  submitted_count[:sample] += sample_count

                  submissions.reload.size.to_s + " (#{sample_count} na amostra)"
                end
                td do
                  submissions = adm.submissions.where(collect_id: collect.id, status: :submitted)
                  b calculate_submitted_percent(adm.schools.fundamental.count, submissions.count)
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
          td do; end
        end
      end
      hr
    end
  end
end
