ActiveAdmin.register_page "Gerencial por rede" do
  menu priority: 2, parent: "Relatórios", if: -> { current_admin_user.admin? }
  content do
    SubmissionsReport.refresh
    h2 "População: todas as escolas"
    Collect.all.group_by(&:name).each do |(collect_name, collect_groups)|
      submissions_reports = SubmissionsReport.where(collect_id: collect_groups.map(&:id))
      summary_counts = submissions_reports.summary
      submission_report = ""

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
          submissions_reports.group_by(&:adm_cod).each do |(adm_cod, _)|
            submission_report = SubmissionsReport.where(adm_cod: adm_cod)
            report = submission_report.summary
            tr do
              td { report[:administration_name] }

              td { report[:administration_contact_name] }

              td { report[:total_sample_count] }

              td { report[:quitters_count] }

              td { submission_report.first.substitutes_count }

              td { report[:redirected_count] }

              td { report[:in_progress_count] }

              td { report[:submitted_count] }

              td { b calculate_submitted_percent(report[:total_sample_count], report[:submitted_count]) }
            end
          end
        end

        # footer
        tr do
          td { h4 b "Total" }

          td {}

          td { h4 b summary_counts[:total_sample_count] }

          td { h4 b "#{summary_counts[:quitters_count]} \
          (#{calculate_submitted_percent(summary_counts[:total_sample_count], summary_counts[:quitters_count])})" }

          td { h4 b "#{submission_report.first.substitutes_count_from_collect} \
          (#{calculate_submitted_percent(summary_counts[:total_sample_count], submission_report.first.substitutes_count_from_collect)})" }

          td { h4 b "#{summary_counts[:redirected_count]} \
          (#{calculate_submitted_percent(summary_counts[:total_sample_count], summary_counts[:redirected_count])})" }

          td { h4 b "#{summary_counts[:in_progress_count]} \
          (#{calculate_submitted_percent(summary_counts[:total_sample_count], summary_counts[:in_progress_count])})" }

          td { h4 b "#{summary_counts[:submitted_count]}" }

          td do
            schools_total = summary_counts[:total_sample_count] - summary_counts[:quitters_count] + submission_report.first.substitutes_count_from_collect
            h4 b "#{calculate_submitted_percent(schools_total, summary_counts[:submitted_count])}"
          end
        end
      end
      hr
    end
  end
end
