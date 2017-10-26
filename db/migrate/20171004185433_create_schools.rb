class CreateSchools < ActiveRecord::Migration[5.1]
  def change
    create_table :schools do |t|
      t.string :inep
      t.text :name
      t.integer :tp_dependencia
      t.string :tp_dependencia_desc
      t.string :cod_municipio
      t.text :municipio
      t.string :unidade_federativa
      t.integer :num_estudantes
      t.integer :ano_censo

      t.timestamps
    end
    add_index :schools, :name
  end
end
