class AddSchoolInepToSubmissions < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :school_inep, :string
    add_index :submissions, :school_inep
  end
end
