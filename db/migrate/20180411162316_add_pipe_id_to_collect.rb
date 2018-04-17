class AddPipeIdToCollect < ActiveRecord::Migration[5.1]
  def change
    add_column :collects, :pipe_id, :bigint
  end
end
