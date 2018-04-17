class AddCardIdToCollectEntry < ActiveRecord::Migration[5.1]
  def change
    add_column :collect_entries, :card_id, :bigint
  end
end
