class Contact < ApplicationRecord
  belongs_to :collect
  belongs_to :school, foreign_key: "school_inep", primary_key: "inep", optional: true
end
