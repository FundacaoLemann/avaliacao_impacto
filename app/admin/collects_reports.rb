ActiveAdmin.register_page "Gerencial por rede" do
  menu priority: 2, parent: "Relatórios", if: -> { current_admin_user.admin? }
  content do
    SubmissionsReport.refresh
    h2 "População: todas as escolas"
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

              td { "#{report.total_schools_count} (#{report.sample_count} na amostra)" }

              td { "#{report.quitters_count} (#{report.quitters_in_sample_count} na amostra)" }

              td { report.substitutes_count }

              td { "#{report.redirected_count} (#{report.redirected_in_sample_count} na amostra)" }

              td { "#{report.in_progress_count} (#{report.in_progress_in_sample_count} na amostra)" }

              td { "#{report.submitted_count} (#{report.answered_count} na amostra)" }

              td { "#{report.total_percent}%" }
            end
          end
        end

        # footer
        tr do
          td { h4 b "Total" }

          td {}

          td { h4 b summary_counts.total_schools_count }

          td { h4 b "#{summary_counts.quitters_count} \
          (#{calculate_submitted_percent(summary_counts.total_schools_count, summary_counts.quitters_count)})" }

          td { h4 b "#{summary_counts.substitutes_count} \
          (#{calculate_submitted_percent(summary_counts.total_schools_count, summary_counts.substitutes_count)})" }

          td { h4 b "#{summary_counts.redirected_count} \
          (#{calculate_submitted_percent(summary_counts.total_schools_count, summary_counts.redirected_count)})" }

          td { h4 b "#{summary_counts.in_progress_count} \
          (#{calculate_submitted_percent(summary_counts.total_schools_count, summary_counts.in_progress_count)})" }

          td { h4 b "#{summary_counts.submitted_count}" }

          td do
            h4 b "#{calculate_submitted_percent(summary_counts.total_schools_count, summary_counts.submitted_count)}"
          end
        end
      end
      hr
    end
  end
end
