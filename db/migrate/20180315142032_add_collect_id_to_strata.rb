class AddCollectIdToStrata < ActiveRecord::Migration[5.1]
  def change
    add_reference :strata, :collect, foreign_key: true
  end
end
