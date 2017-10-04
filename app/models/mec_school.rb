class MecSchool < ApplicationRecord
  validates :inep, uniqueness: true
end
