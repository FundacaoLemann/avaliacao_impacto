class CreateCollects < ActiveRecord::Migration[5.1]
  def change
    create_table :collects do |t|
      t.string :name
      t.string :phase
      t.text :administrations, array: true, default: []
      t.string :form
      t.text :form_sections, array: true, default: []
      t.string :form_assembly_params
      t.datetime :deadline

      t.timestamps
    end
  end
end
