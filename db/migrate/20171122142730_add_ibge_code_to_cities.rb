class AddIbgeCodeToCities < ActiveRecord::Migration[5.1]
  def change
    add_column :cities, :ibge_code, :string
  end
end
