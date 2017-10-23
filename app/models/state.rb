class State < ApplicationRecord
  has_many :cities

  def to_s
    acronym + " - " + name
  end
end
