class ChangeSubmissionsStatusToEnum < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :status, :integer
    transform_statuses_to_enum
    remove_column :submissions, :status_backup
  end

  def transform_statuses_to_enum
    statuses_map = {
      redirected: 0,
      in_progress: 1,
      submitted: 2
    }.freeze

    Submission.find_each do |submission|
      submission.update(status: statuses_map[submission.status_backup&.to_sym])
    end
  end
end
