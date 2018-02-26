class RemoveAdministrationsFromCollect < ActiveRecord::Migration[5.1]
  def change
    remove_column :collects, :administrations
  end
end
