class CreateCollectEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :collect_entries do |t|
      t.references :collect, foreign_key: true
      t.string :name
      t.string :school_inep
      t.string :adm_cod
      t.string :phase
      t.integer :size
      t.integer :sample_size
      t.integer :school_sequence
      t.string :group

      t.timestamps
    end
  end
end
