class School < ApplicationRecord
  validates :inep, uniqueness: true
  ADMINISTRATIONS = %w[Federal Estadual Municipal].freeze

  def to_s
    "#{inep} - #{name}"
  end
end
