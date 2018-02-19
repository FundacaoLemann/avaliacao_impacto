class CreateStrata < ActiveRecord::Migration[5.1]
  def change
    create_table :strata do |t|
      t.string :name
      t.string :administration
      t.string :phase
      t.integer :size
      t.integer :sample_size
      t.string :school
      t.integer :school_sequence
      t.string :group

      t.timestamps
    end
  end
end
