namespace :submission do
  desc 'Update submissions missing administration per school adm'
  task update_submissions_adm: :environment do
    Submission.where(administration: nil).each do |submission|
      school = School.find(submission.school_id)
      submission_adm = ''
      case school.tp_dependencia_desc
      when 'Estadual'
        submission_adm = "Rede Estadual de #{school.unidade_federativa}"
      when 'Municipal'
        submission_adm = "Rede Municipal de #{school.municipio}"
      else
        submission_adm = "Rede Federal de Ensino do Brasil"
      end
      puts "Updating submission #{submission.id} with: #{submission_adm}"
      submission.update(administration: submission_adm)
    end
    puts 'Done!'
  end
end
