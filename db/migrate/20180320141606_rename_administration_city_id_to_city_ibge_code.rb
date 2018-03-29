class RenameAdministrationCityIdToCityIbgeCode < ActiveRecord::Migration[5.1]
  def change
    rename_column :administrations, :city_id, :city_ibge_code
    remove_foreign_key :administrations, :cities
  end
end
