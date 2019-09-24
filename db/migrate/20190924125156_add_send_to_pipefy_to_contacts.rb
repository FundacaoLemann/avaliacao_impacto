class AddSendToPipefyToContacts < ActiveRecord::Migration[5.1]
  def change
    add_column :contacts, :send_to_pipefy, :boolean, default: false
  end
end
