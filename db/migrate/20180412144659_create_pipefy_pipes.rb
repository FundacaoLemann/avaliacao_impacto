class CreatePipefyPipes < ActiveRecord::Migration[5.1]
  def change
    create_table :pipefy_pipes do |t|
      t.bigint :pipefy_id
      t.string :name
      t.text :labels, array: true, default: []
      t.text :phases, array: true, default: []

      t.timestamps
    end
  end
end
