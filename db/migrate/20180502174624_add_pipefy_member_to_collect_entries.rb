class AddPipefyMemberToCollectEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :collect_entries, :member_email, :string
  end
end
