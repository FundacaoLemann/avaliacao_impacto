namespace :db do
  desc 'Destroy outdated statuses from submissions'
  task destroy_outdated_statuses: :environment do
    School.includes(:submissions).where.not(submissions: { id: nil }).each do |school|
      if school.submissions.count > 1
        print <<~END
          ----------------------------------------------------------------
          Analisando submissões da escola: #{school.inep} - #{school.name}
          Quantidade de submissoes: #{school.submissions.count}
          Status das submissoes: #{school.submissions.map(&:status)}
          ----------------------------------------------------------------
        END

        [:redirected, :in_progress, :submitted].each do |status|
          destroy_all_but_the_last(school.submissions, status)
        end

        destroy_outdated(school.submissions)

        print '----------------------------------------------------------------'
      end
    end
  end

  STATUSES_HASH = {
    redirected:  :redirected_at,
    in_progress: :saved_at,
    submitted:   :submitted_at
  }.freeze

  def destroy_all_but_the_last(submissions, status)
    puts "Removendo todos menos o ultimo com status: #{status}"
    all_by_status = submissions.where(status: status)
    last_by_status = all_by_status.order(STATUSES_HASH[status]).first
    all_by_status = all_by_status.reject { |s| s.id == last_by_status.id }
    all_by_status.each.map(&:destroy)
    puts " + Ficando apenas: #{last_by_status.to_s}"
  end

  def destroy_outdated(submissions)
    if submissions.count > 1
      ['submitted', 'in_progress'].each do |status|
        puts 'Removendo todos menos o status mais recente'
        puts submissions.map(&:to_s)
        current_status = submissions.where(status: status)
        if current_status.any?
          puts " removendo todos menos o status: #{status}"
          submissions.where.not(status: status).destroy_all
        end
      end
    end
  end
end
