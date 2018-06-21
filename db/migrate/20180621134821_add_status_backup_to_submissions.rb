class AddStatusBackupToSubmissions < ActiveRecord::Migration[5.1]
  def up
    add_column :submissions, :status_backup, :string
    copy_statuses
    remove_column :submissions, :status
  end

  def down
    Rails.logger.warn("There is an irreversible status column removal")
  end

  def copy_statuses
    Submission.find_each do |submission|
      submission.update(status_backup: submission.status)
    end
  end
end
