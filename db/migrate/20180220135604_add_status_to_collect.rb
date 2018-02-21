class AddStatusToCollect < ActiveRecord::Migration[5.1]
  def change
    add_column :collects, :status, :integer, null: false, default: 0
  end
end
