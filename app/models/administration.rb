class Administration < ApplicationRecord
  has_and_belongs_to_many :collects
  has_many :schools, foreign_key: 'adm_cod', primary_key: 'cod'
  has_many :submissions, foreign_key: 'administration', primary_key: 'cod'
  has_many :collect_entries, foreign_key: 'adm_cod', primary_key: 'cod'
  belongs_to :city, foreign_key: 'ibge_code', primary_key: 'city_ibge_code',  optional: true
  belongs_to :state, optional: true

  enum adm: { federal: 1, estadual: 2, municipal: 3, privada: 4 }
  validates :name, uniqueness: true

  scope :state_administrations, -> { where(adm: :estadual) }
  scope :city_administrations, -> { where(adm: :municipal) }
  scope :country_administrations, -> { where(adm: :federal) }
  scope :private_administrations, -> { where(adm: :privada) }

  def self.allowed_administrations(adm)
    where(adm: adm)
      .joins(:collects)
      .where(collects: { status: 'in_progress'})
  end
end
