class MecSchool < ApplicationRecord
  validates :inep, uniqueness: true
  ADMINISTRATIONS = %w(Privada Federal Estadual Municipal).freeze

  def to_s
    inep + ' - ' + name
  end
end