class CreateAdministrations < ActiveRecord::Migration[5.1]
  def change
    create_table :administrations do |t|
      t.integer :adm
      t.references :state, foreign_key: true
      t.references :city, foreign_key: true
      t.string :preposition
      t.string :name

      t.timestamps
    end
    add_index :administrations, :adm
  end
end
