class AddCodToAdministrations < ActiveRecord::Migration[5.1]
  def change
    add_column :administrations, :cod, :string
    add_index :administrations, :cod
  end
end
