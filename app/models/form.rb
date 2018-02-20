class Form < ApplicationRecord
  validates :name, :link, presence: true
end
