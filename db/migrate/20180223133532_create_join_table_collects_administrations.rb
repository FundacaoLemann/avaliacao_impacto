class CreateJoinTableCollectsAdministrations < ActiveRecord::Migration[5.1]
  def change
    create_join_table :collects, :administrations do |t|
    end
  end
end
