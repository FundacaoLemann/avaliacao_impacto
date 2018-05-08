class School < ApplicationRecord
  validates :inep, uniqueness: true

  has_many :submissions, foreign_key: "school_inep", primary_key: "inep"
  has_many :collect_entries, foreign_key: "school_inep", primary_key: "inep"
  belongs_to :administration, foreign_key: "adm_cod", primary_key: "cod", optional: true

  ADMINISTRATIONS = %w[Federal Estadual Municipal].freeze
  REGIONS = %w[Norte Sul Nordeste Sudeste Centro-Oeste].freeze
  LOCATIONS = %w[Urbana Rural].freeze

  scope :fundamental, -> { where("num_students_fund > 0") }

  def to_s
    "#{inep} | #{name}"
  end
end
