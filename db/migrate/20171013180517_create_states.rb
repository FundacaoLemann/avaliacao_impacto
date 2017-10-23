class CreateStates < ActiveRecord::Migration[5.1]
  def change
    create_table :states do |t|
      t.string :acronym
      t.string :name

      t.timestamps
    end
    add_index :states, :name
  end
end
