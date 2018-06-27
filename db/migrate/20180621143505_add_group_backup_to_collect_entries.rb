class AddGroupBackupToCollectEntries < ActiveRecord::Migration[5.1]
  def up
    casting = <<~END
      CASE "group"
      WHEN 'Repescagem' THEN 0
      WHEN 'Amostra' THEN 1 END
    END

    change_column :collect_entries, :group, :integer, using: casting, null: false
  end

  def down
    casting = <<~END
      CASE "group"
      WHEN 0 THEN 'Repescagem'
      WHEN 1 THEN 'Amostra' END
    END

    change_column :collect_entries, :group, :string, using: casting, null: true
  end
end
