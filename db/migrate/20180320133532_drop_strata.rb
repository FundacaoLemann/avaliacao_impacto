class DropStrata < ActiveRecord::Migration[5.1]
  def change
    drop_table :strata
  end
end
