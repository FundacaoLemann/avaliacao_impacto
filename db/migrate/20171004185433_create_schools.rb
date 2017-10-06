class CreateSchools < ActiveRecord::Migration[5.1]
  def change
    create_table :schools do |t|
      t.string :inep
      t.string :name

      t.timestamps
    end
    add_index :schools, :name
  end
end
