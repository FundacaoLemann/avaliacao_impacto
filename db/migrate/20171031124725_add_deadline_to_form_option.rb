class AddDeadlineToFormOption < ActiveRecord::Migration[5.1]
  def change
    add_column :form_options, :deadline, :string
  end
end
