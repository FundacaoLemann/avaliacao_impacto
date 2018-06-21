ActiveAdmin.register_page "Gerencial por rede (apenas escolas da amostra)" do
  menu priority: 3, parent: "Relatórios", if: -> { current_admin_user.admin? }
  content do
    h2 "População: amostra"
    Collect.all.group_by(&:name).each do |collect_group|
      h3 i collect_group[0]

      total_sample_count = 0
      redirected_count = 0
      in_progress_count = 0
      submitted_count = 0
      quitters_count = 0
      substitutes_count = 0

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
            SampleReport.refresh
            SampleReport.where(collect_id: collect.id).each do |report|
              tr do
                td do
                  report.administration_name
                end

                td do
                  report.administration_contact_name
                end

                td do
                  total_sample_count += report.sample_count
                  report.sample_count
                end

                td do
                  quitters_count += report.quitters_count
                  report.quitters_count
                end

                td do
                  substitutes_count += report.substitutes_count
                  report.substitutes_count
                end

                td do
                  redirected_count += report.redirected_count
                  report.redirected_count
                end

                td do
                  in_progress_count += report.in_progress_count
                  report.in_progress_count
                end

                td do
                  submitted_count += report.submitted_count
                  report.submitted_count
                end

                td do
                  sample_total = report.sample_count - report.quitters_count + report.substitutes_count
                  b calculate_submitted_percent(sample_total, report.submitted_count)
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
            h4 b total_sample_count
          end
          td do
            h4 b "#{quitters_count} (#{calculate_submitted_percent(total_sample_count, quitters_count)})"
          end
          td do
            h4 b "#{substitutes_count} (#{calculate_submitted_percent(total_sample_count, substitutes_count)})"
          end
          td do
            h4 b "#{redirected_count} (#{calculate_submitted_percent(total_sample_count, redirected_count)})"
          end
          td do
            h4 b "#{in_progress_count} (#{calculate_submitted_percent(total_sample_count, in_progress_count)})"
          end
          td do
            h4 b "#{submitted_count}"
          end
          td do
            schools_total = total_sample_count - quitters_count + substitutes_count
            h4 b "#{calculate_submitted_percent(schools_total, submitted_count)}"
          end
        end
      end
      hr
    end
  end
end
