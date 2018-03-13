class School < ApplicationRecord
  validates :inep, uniqueness: true
  ADMINISTRATIONS = %w[Federal Estadual Municipal].freeze
  has_many :submissions
  has_one :administration, foreign_key: 'cod', primary_key: 'adm_cod'

  scope :municipal_on_sample_grouped_by_adm, ->{
    where(sample: true, tp_dependencia_desc: 'Municipal').
    group_by{ |s| [s.tp_dependencia_desc, s.municipio] }
  }

  scope :count_on_sample, ->{
    where(sample: true).count
  }

  scope :count_by_status, -> (status) {
    where(sample: true).includes(:submissions).where(submissions: { status: status }).count
  }

  scope :estadual_on_sample_grouped_by_adm, ->{
    where(sample: true, tp_dependencia_desc: 'Estadual').
    group_by{ |s| [s.tp_dependencia_desc, s.unidade_federativa] }
  }

  scope :federal_on_sample_grouped_by_adm, ->{
    where(sample: true, tp_dependencia_desc: 'Federal')
  }

  def to_s
    "#{inep} | #{name}"
  end
end
