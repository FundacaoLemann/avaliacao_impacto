class CreatePipefyMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :pipefy_members do |t|
      t.bigint :pipefy_id
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
