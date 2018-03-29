class AddInepIndexToSchools < ActiveRecord::Migration[5.1]
  def change
    add_index :schools, :inep
  end
end
