class SubmissionsReport < ApplicationRecord
  belongs_to :collect
  belongs_to :administration

  scope :summarize, -> {
    select(*
      [
        :total_schools_count,
        :sample_count,
        :quitters_count,
        :quitters_in_sample_count,
        :substitutes_count,
        :redirected_count,
        :redirected_in_sample_count,
        :in_progress_count,
        :in_progress_in_sample_count,
        :submitted_count,
        :answered_count,
        :submitted_in_sample_count
      ].map{ |field| "sum(#{field}::integer) as #{field}" }
    )
  }

  def readonly?
    true
  end

  def self.summary
    summarize.first
  end

  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: false, cascade: false)
  end
end
