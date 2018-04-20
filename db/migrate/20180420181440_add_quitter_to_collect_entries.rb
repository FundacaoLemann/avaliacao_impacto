class AddQuitterToCollectEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :collect_entries, :quitter, :boolean, default: false
  end
end
