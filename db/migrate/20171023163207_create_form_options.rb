class CreateFormOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :form_options do |t|
      t.text :sections_to_show, array: true, default: []
      t.string :dependencia_desc
      t.string :state_or_city
      t.string :form_assembly_params

      t.timestamps
    end
  end
end
