ActiveAdmin.register_page "Relatório Gerencial" do
  menu priority: 1
  content do
    table do
      thead do
        tr do
          th 'Rede'
          th 'Escolas na amostra'
          th 'Iniciaram'
          th 'Salvas'
          th 'Enviadas'
          th '% de envio'
        end
      end

      tbody do
        total_adm_submissions, submitted_adm_count = 0, 0

        School.municipal_on_sample_grouped_by_adm.each do |adm|
          adm_name = "Rede #{adm[0][0]} de #{adm[0][1]}"
          tr do
            td do
              adm_name
            end
            td do
              total_adm_submissions = adm[1].count
            end
            td do
              submissions_count_for(adm_name, 'redirected')
            end
            td do
              submissions_count_for(adm_name, 'in_progress')
            end
            td do
              submitted_adm_count = submissions_count_for(adm_name, 'submitted')
            end
            td do
              calculate_submitted_percent(total_adm_submissions, submitted_adm_count)
            end
          end
        end
        School.estadual_on_sample_grouped_by_adm.each do |adm|
          adm_name = "Rede #{adm[0][0]} de #{adm[0][1]}"
          tr do
            td do
              adm_name
            end
            td do
              total_adm_submissions = adm[1].count
            end
            td do
              submissions_count_for(adm_name, 'redirected')
            end
            td do
              submissions_count_for(adm_name, 'in_progress')
            end
            td do
              submitted_adm_count = submissions_count_for(adm_name, 'submitted')
            end
            td do
              calculate_submitted_percent(total_adm_submissions, submitted_adm_count)
            end
          end
        end
        School.federal_on_sample_grouped_by_adm.each do |school|
          adm_name = "Rede Federal de Ensino do Brasil"
          tr do
            td do
              adm_name
            end
            td do
              total_adm_submissions = School.federal_on_sample_grouped_by_adm.count
            end
            td do
              submissions_count_for(adm_name, 'redirected')
            end
            td do
              submissions_count_for(adm_name, 'in_progress')
            end
            td do
              submitted_adm_count = submissions_count_for(adm_name, 'submitted')
            end
            td do
              calculate_submitted_percent(total_adm_submissions, submitted_adm_count)
            end
          end
        end
        # footer
        tr do
          td do
            h4 b 'Total'
          end
          td do
            h4 b School.count_on_sample
          end
          td do
            h4 b School.count_by_status('redirected')
          end
          td do
            h4 b School.count_by_status('in_progress')
          end
          td do
            h4 b School.count_by_status('submitted')
          end
        end
      end
    end
  end
  # School.on_sample_grouped_by_adm.each do |group|
    # table_for group[1], class: 'index_table' do
    #   column :id
    #   column :inep
    #   column 'Nome da escola', :name
    #   column 'Rede de ensino', :tp_dependencia_desc
    #   column :unidade_federativa
    #   column :municipio
    #   column 'Código IBGE do municipio', :cod_municipio
    # end
  # end

end
