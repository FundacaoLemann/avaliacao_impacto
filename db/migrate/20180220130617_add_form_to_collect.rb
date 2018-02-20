class AddFormToCollect < ActiveRecord::Migration[5.1]
  def change
    add_reference :collects, :form, foreign_key: true
  end
end
