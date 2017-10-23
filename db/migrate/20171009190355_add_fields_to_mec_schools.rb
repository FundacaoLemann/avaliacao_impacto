class AddFieldsToMecSchools < ActiveRecord::Migration[5.1]
  def change
    change_column :mec_schools, :name, :text
    add_column :mec_schools, :tp_dependencia, :integer
    add_column :mec_schools, :tp_dependencia_desc, :string
    add_column :mec_schools, :cod_municipio, :string
    add_column :mec_schools, :municipio, :text
    add_column :mec_schools, :unidade_federativa, :text
    add_column :mec_schools, :num_estudantes, :integer
    add_column :mec_schools, :ano_censo, :integer
  end
end
