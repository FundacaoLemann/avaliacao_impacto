class CreateForms < ActiveRecord::Migration[5.1]
  def change
    create_table :forms do |t|
      t.string :name, null: false, default: ""
      t.string :link, null: false, default: ""

      t.timestamps
    end
    add_index :forms, :name
  end
end
