class AddSampleToSchools < ActiveRecord::Migration[5.1]
  def change
    add_column :schools, :sample, :boolean, default: false
  end
end
