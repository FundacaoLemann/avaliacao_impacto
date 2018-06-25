class AddGroupBackupToCollectEntries < ActiveRecord::Migration[5.1]
  def up
    add_column :collect_entries, :group_backup, :string
    copy_group
    remove_column :collect_entries, :group
  end

  def down
    Rails.logger.warn("There is an irreversible group column removal")
  end

  def copy_group
    CollectEntry.find_each do |collect_entry|
      collect_entry.update(group_backup: collect_entry.group)
    end
  end
end
