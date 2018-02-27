class RemoveFormFromCollect < ActiveRecord::Migration[5.1]
  def change
    remove_column :collects, :form
  end
end
