class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.references :collect, foreign_key: true
      t.string :school_inep

      t.string :school_phone
      t.string :principal_name
      t.string :principal_phone
      t.string :principal_email

      t.string :coordinator1_name
      t.string :coordinator1_phone
      t.string :coordinator1_email

      t.string :coordinator2_name
      t.string :coordinator2_phone
      t.string :coordinator2_email

      t.string :coordinator3_name
      t.string :coordinator3_phone
      t.string :coordinator3_email

      t.string :member_email

      t.timestamps
    end
  end
end
