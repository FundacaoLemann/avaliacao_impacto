class UpdateSubmissionsReportsToVersion3 < ActiveRecord::Migration[5.1]
  def change
    update_view :submissions_reports,
      version: 3,
      revert_to_version: 2,
      materialized: true
  end
end
