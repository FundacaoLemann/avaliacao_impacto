class CollectEntry < ApplicationRecord
  belongs_to :collect
  belongs_to :administration, foreign_key: "adm_cod", primary_key: "cod", optional: true
  belongs_to :school, foreign_key: "school_inep", primary_key: "inep", optional: true
  belongs_to :member, class_name: 'Pipefy::Member', foreign_key: 'member_email', primary_key: 'email', optional: true

  scope :substitutes, -> { where substitute: true }

  enum group: { recapture: 0, Repescagem: 0, sample: 1, Amostra: 1 }

  def self.groups_for_filter
    collection ||= groups.collect { |k, v| [CollectEntry.human_attribute_name(k), v] }
  end

  def grupo
    if group == "sample" || group == 1
      return "Amostra"
    elsif group == "recapture" || group == 0
      return "Repescagem"
    end
  end
end
