class AddCardIdToSubmission < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :card_id, :bigint
  end
end
