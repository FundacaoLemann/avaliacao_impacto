class RenameSubmissionAdministrationToAdmCod < ActiveRecord::Migration[5.1]
  def change
    rename_column :submissions, :administration, :adm_cod
  end
end
