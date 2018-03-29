class AddCollectEntryReferenceToSubmissions < ActiveRecord::Migration[5.1]
  def change
    add_reference :submissions, :collect_entry, foreign_key: true
  end
end
