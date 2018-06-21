class CreateSampleReports < ActiveRecord::Migration[5.1]
  def change
    create_view :sample_reports, materialized: true
  end
end
