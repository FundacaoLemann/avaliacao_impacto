class Administration < ApplicationRecord
  has_and_belongs_to_many :collects
  has_many :schools, foreign_key: "adm_cod", primary_key: "cod"
  has_many :submissions, foreign_key: "adm_cod", primary_key: "cod"
  has_many :collect_entries, foreign_key: "adm_cod", primary_key: "cod"
  belongs_to :city, foreign_key: "city_ibge_code", primary_key: "ibge_code",  optional: true
  belongs_to :state, optional: true

  enum adm: { federal: 1, estadual: 2, municipal: 3, privada: 4 }
  validates :name, uniqueness: true

  def self.allowed_administrations(adm)
    where(adm: adm)
      .joins(:collects)
      .where(collects: { status: "in_progress"})
  end

  def self.find_administration_by_city_or_state(city_or_state)
    return Administration.where(city_ibge_code: city_or_state) if city_or_state.to_s.length > 2
    Administration.where(state_id: city_or_state)
  end
end
