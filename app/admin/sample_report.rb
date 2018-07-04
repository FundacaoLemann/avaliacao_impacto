ActiveAdmin.register_page "Gerencial por rede (apenas escolas da amostra)" do
  menu priority: 3, parent: "Relatórios", if: -> { current_admin_user.admin? }
  content do
    SubmissionsReport.refresh
    h2 "População: amostra"
    Collect.all.group_by(&:name).each do |(collect_name, collect_groups)|
      submissions_reports = SubmissionsReport.where(collect_id: collect_groups.map(&:id))
      summary_counts = submissions_reports.summary

      h3 i collect_name
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
          submissions_reports.each do |report|
            tr do
              td { report.adm_name }

              td { report.adm_contact }

              td { report.sample_count }

              td { report.quitters_in_sample_count }

              td { report.substitutes_count }

              td { report.redirected_in_sample_count }

              td { report.in_progress_in_sample_count }

              td { report.answered_count }

              td { report.sample_percent }
            end
          end
        end

        # footer
        tr do
          td { h4 b "Total" }

          td {}

          td { h4 b summary_counts.sample_count }

          td { h4 b "#{summary_counts.quitters_in_sample_count} \
          (#{calculate_submitted_percent(summary_counts.sample_count, summary_counts.quitters_in_sample_count)})" }

          td { h4 b "#{summary_counts.substitutes_count} \
          (#{calculate_submitted_percent(summary_counts.sample_count, summary_counts.substitutes_count)})" }

          td { h4 b "#{summary_counts.redirected_in_sample_count} \
          (#{calculate_submitted_percent(summary_counts.sample_count, summary_counts.redirected_in_sample_count)})" }

          td { h4 b "#{summary_counts.in_progress_in_sample_count} \
          (#{calculate_submitted_percent(summary_counts.sample_count, summary_counts.in_progress_in_sample_count)})" }

          td { h4 b "#{summary_counts.answered_count}" }

          td do
            schools_total = summary_counts.sample_count - summary_counts.quitters_in_sample_count + summary_counts.substitutes_count
            h4 b "#{calculate_submitted_percent(schools_total, summary_counts.answered_count)}"
          end
        end
      end
      hr
    end
  end
end
