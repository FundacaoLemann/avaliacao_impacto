class AddAdmCodIndexToSubmissions < ActiveRecord::Migration[5.1]
  def change
    add_index :submissions, :adm_cod
  end
end
