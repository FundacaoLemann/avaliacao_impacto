class AddAdmCodToSchools < ActiveRecord::Migration[5.1]
  def change
    add_column :schools, :adm_cod, :string
    add_index :schools, :adm_cod
  end
end
