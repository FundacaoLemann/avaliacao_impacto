class AddStateToCities < ActiveRecord::Migration[5.1]
  def change
    add_reference :cities, :state, foreign_key: true
  end
end
