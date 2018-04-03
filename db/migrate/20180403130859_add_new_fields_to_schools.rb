class AddNewFieldsToSchools < ActiveRecord::Migration[5.1]
  def change
    add_column :schools, :region, :string
    add_column :schools, :num_students_fund, :integer
    add_column :schools, :location, :string
  end
end
