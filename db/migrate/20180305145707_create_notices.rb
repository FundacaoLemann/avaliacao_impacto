class CreateNotices < ActiveRecord::Migration[5.1]
  def change
    create_table :notices do |t|
      t.text :content, null: false, default: ""

      t.timestamps
    end
  end
end
