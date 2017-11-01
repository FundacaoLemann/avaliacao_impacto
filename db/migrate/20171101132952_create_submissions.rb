class CreateSubmissions < ActiveRecord::Migration[5.1]
  def change
    create_table :submissions do |t|
      t.references :school, foreign_key: true
      t.string :status
      t.string :school_phone
      t.string :submitter_name
      t.string :submitter_email
      t.string :submitter_phone
      t.integer :response_id
      t.string :redirected_at
      t.string :created_at
      t.string :modified_at
      t.string :submitted_at
    end
  end
end
