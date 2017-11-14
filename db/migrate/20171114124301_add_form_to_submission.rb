class AddFormToSubmission < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :form_name, :string
  end
end
