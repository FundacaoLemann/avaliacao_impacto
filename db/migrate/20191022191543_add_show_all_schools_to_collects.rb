class AddShowAllSchoolsToCollects < ActiveRecord::Migration[5.1]
  def change
    add_column :collects, :show_all_schools, :boolean, default: false 
  end
end
