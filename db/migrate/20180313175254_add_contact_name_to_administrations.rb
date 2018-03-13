class AddContactNameToAdministrations < ActiveRecord::Migration[5.1]
  def change
    add_column :administrations, :contact_name, :string
  end
end
