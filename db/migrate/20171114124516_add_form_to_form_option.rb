class AddFormToFormOption < ActiveRecord::Migration[5.1]
  def change
    add_column :form_options, :form_name, :string
  end
end
