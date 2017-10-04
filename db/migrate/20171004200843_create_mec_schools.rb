class CreateMecSchools < ActiveRecord::Migration[5.1]
  def change
    create_table :mec_schools do |t|
      t.string :inep
      t.string :name

      t.timestamps
    end
  end
end
