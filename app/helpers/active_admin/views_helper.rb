module ActiveAdmin::ViewsHelper #camelized file name
  def submissions_count_for(adm_name, status)
    School.where(sample: true).includes(:submissions).
      where(submissions: { administration: adm_name, status: status }).
      select('distinct school_id').count
  end

  def calculate_submitted_percent(total_submissions, submitted_count)
    return 0 unless submitted_count > 0 || total_submissions > 0
    (submitted_count.to_f / total_submissions.to_f * 100.0).round(2).to_s << '%'
  end
end
