module ActiveAdmin::ViewsHelper
  def calculate_submitted_percent(total_submissions, submitted_count)
    return 0 unless submitted_count > 0 || total_submissions > 0
    (submitted_count.to_f / total_submissions.to_f * 100.0).round(2).to_s << "%"
  end

  def i18n_for(model, attribute)
    I18n.t("activerecord.attributes.#{model}.#{attribute}")
  end
end
