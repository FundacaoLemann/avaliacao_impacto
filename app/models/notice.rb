class Notice < ApplicationRecord
  validates :content, presence: true
end
