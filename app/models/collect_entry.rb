class CollectEntry < ApplicationRecord
  belongs_to :collect
  belongs_to :administration, foreign_key: "adm_cod", primary_key: "cod", optional: true
  belongs_to :school, foreign_key: "school_inep", primary_key: "inep", optional: true
  belongs_to :member, class_name: 'Pipefy::Member', foreign_key: 'member_email', primary_key: 'email', optional: true
end
