module Maintenance
  module UniqueStatus
    def self.all_schools
      School.includes(:submissions).where.not(submissions: { id: nil })
    end

    def self.remove_all_double_status
      all_schools.each do |school|
        if school.submissions.any?
          to_be_deleted = all_to_be_deleted(school.submissions)
          yield(school, to_be_deleted) if block_given?
          to_be_deleted.destroy_all
        end
      end
    end

    STATUS_SIZES = {
      redirected: 0,
      in_progress: 1,
      submitted: 2
    }.freeze

    STATUSES_DATES = {
      redirected:  :redirected_at,
      in_progress: :saved_at,
      submitted:   :submitted_at
    }.freeze

    def self.all_to_be_deleted(submissions)
      statuses = submissions.pluck(:status)
      current_status = statuses.sort_by{|v| STATUS_SIZES[v] }.last
      current_submission = submissions.order(STATUSES_DATES[current_status]).first
      submissions.where.not(id: current_submission.id)
    end
  end
end
