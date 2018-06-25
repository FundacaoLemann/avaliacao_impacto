class SubmissionsReport < ApplicationRecord
  belongs_to :collect
  belongs_to :administration

  enum collect_entries_group: { recapture: 0, sample: 1 }

  def readonly?
    true
  end

  def collect_entries
    CollectEntry.where(adm_cod: adm_cod, collect_id: collect_id)
  end

  def substitutes_count
    collect_entries.substitutes.count
  end

  def self.summary
    initial_counts = {
      total_sample_count: 0,
      redirected_count: 0,
      in_progress_count: 0,
      submitted_count: 0,
      quitters_count: 0,
      substitutes_count: 0,
      administration_name: "",
      administration_contact_name: ""
    }

    self.all.each_with_object(initial_counts) do |report, summary|
      summary[:quitters_count] += report.quitters_count
      summary[:substitutes_count] += report.substitutes_count
      summary[:total_sample_count] += report.sample_count
      summary[:redirected_count] += report.redirected_count
      summary[:in_progress_count] += report.in_progress_count
      summary[:submitted_count] += report.submitted_count
      summary[:sample_total] = report.sample_count - report.quitters_count + report.substitutes_count
      summary[:administration_name] = report.administration_name
      summary[:administration_contact_name] = report.administration_contact_name
    end
  end

  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: false, cascade: false)
  end
end
