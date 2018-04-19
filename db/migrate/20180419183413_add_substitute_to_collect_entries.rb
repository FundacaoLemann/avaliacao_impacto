class AddSubstituteToCollectEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :collect_entries, :substitute, :boolean, default: false
  end
end
