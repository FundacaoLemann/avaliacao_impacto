class ChangeCollectEntriesGroupToEnum < ActiveRecord::Migration[5.1]
  def change
    add_column :collect_entries, :group, :integer
    transform_group_to_enum
    remove_column :collect_entries, :group_backup
  end

  def transform_group_to_enum
    group_map = {
      repescagem: 0,
      amostra: 1
    }.freeze

    CollectEntry.find_each do |collect_entry|
      collect_entry.update(group: group_map[collect_entry.group_backup.downcase.to_sym])
    end
  end
end
