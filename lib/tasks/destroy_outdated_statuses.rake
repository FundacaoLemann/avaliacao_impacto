namespace :db do
  desc 'Destroy outdated statuses from submissions'
  task destroy_outdated_statuses: :environment do
    require 'maintenance/unique_status'

    Maintenance::UniqueStatus.remove_all_double_status do |school, to_be_deleted|
      print <<~END
        ----------------------------------------------------------------
        Analisando submissões da escola: #{school.inep} - #{school.name}
        Quantidade de submissoes: #{school.submissions.count}
        Status das submissoes: #{school.submissions.map(&:status)}
        ----------------------------------------------------------------
      END

      puts "Removendo todos com a seguinte condição: #{to_be_deleted.to_sql}"
      puts to_be_deleted.all
    end
  end
end
