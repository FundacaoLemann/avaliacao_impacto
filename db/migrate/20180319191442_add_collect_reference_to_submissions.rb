class AddCollectReferenceToSubmissions < ActiveRecord::Migration[5.1]
  def change
    add_reference :submissions, :collect, foreign_key: true
  end
end
