class AddStatusBackupToSubmissions < ActiveRecord::Migration[5.1]
  def up
    casting = <<~END
      CASE status
      WHEN 'redirected' THEN 0
      WHEN 'in_progress' THEN 1
      WHEN 'submitted' THEN 2
      WHEN 'quitter' THEN 3 END
    END

    change_column :submissions, :status, :integer, using: casting
  end

  def down
    casting = <<~END
      CASE status
      WHEN 0 THEN 'redirected'
      WHEN 1 THEN 'in_progress'
      WHEN 2 THEN 'submitted'
      WHEN 3 THEN 'quitter' END
    END

    change_column :submissions, :status, :string, using: casting
  end
end
