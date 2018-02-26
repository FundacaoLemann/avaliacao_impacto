class Administration < ApplicationRecord
  belongs_to :state, optional: true
  belongs_to :city, optional: true
  has_and_belongs_to_many :collects

  enum adm: [:federal, :estadual, :municipal]
  validates :name, uniqueness: true
end
