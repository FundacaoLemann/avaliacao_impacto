class ChangeCreatedAtOnSubmission < ActiveRecord::Migration[5.1]
  def change
    rename_column :submissions, :created_at, :saved_at
  end
end
