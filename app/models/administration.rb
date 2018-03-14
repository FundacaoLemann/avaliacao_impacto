class Administration < ApplicationRecord
  has_and_belongs_to_many :collects

  enum adm: { federal: 1, estadual: 2, municipal: 3, privada: 4 }
  validates :name, uniqueness: true

  scope :state_administrations, -> { where(adm: :estadual) }
  scope :city_administrations, -> { where(adm: :municipal) }
end
