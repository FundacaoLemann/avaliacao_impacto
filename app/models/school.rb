class School < ApplicationRecord
  validates :inep, uniqueness: true
  ADMINISTRATIONS = %w[Privada Federal Estadual Municipal].freeze

  def to_s
    "#{id} - #{inep} - #{name}"
  end
end
