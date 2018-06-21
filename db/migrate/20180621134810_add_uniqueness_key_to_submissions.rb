require "maintenance/unique_status"

class AddUniquenessKeyToSubmissions < ActiveRecord::Migration[5.1]
  def up
    Maintenance::UniqueStatus.remove_all_double_status

    add_index :submissions, [:school_inep, :collect_id], unique: true, name: "index_submissions_school_inep_and_collect_id"
  end

  def down
    remove_index :submissions, column: [:school_inep, :collect_id]
    Rails.logger.warn("There is an irreversible data adjustment that removes double statuses")
  end
end
