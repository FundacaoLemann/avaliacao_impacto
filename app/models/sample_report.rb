class SampleReport < ApplicationRecord
  belongs_to :collect

  INITIAL_COUNTS = {
    total_sample_count: 0,
    redirected_count: 0,
    in_progress_count: 0,
    submitted_count: 0,
    quitters_count: 0,
    substitutes_count: 0
  }

  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: false, cascade: false)
  end

  def readonly?
    true
  end

  def self.summary
    self.all.each_with_object(INITIAL_COUNTS) do |report, summary|
      summary[:quitters_count] += report.quitters_count
      summary[:substitutes_count] += report.substitutes_count
      summary[:total_sample_count] += report.sample_count
      summary[:redirected_count] += report.redirected_count
      summary[:in_progress_count] += report.in_progress_count
      summary[:submitted_count] += report.submitted_count
      summary[:sample_total] = report.sample_count - report.quitters_count + report.substitutes_count
    end
  end
end
