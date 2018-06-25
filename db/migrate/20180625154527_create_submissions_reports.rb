class CreateSubmissionsReports < ActiveRecord::Migration[5.1]
  def change
    create_view :submissions_reports, materialized: true
  end
end
