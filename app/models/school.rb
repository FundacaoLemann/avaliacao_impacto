class School < ApplicationRecord
  validates :inep, uniqueness: true
end
