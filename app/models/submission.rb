class Submission < ApplicationRecord
  belongs_to :school, foreign_key: "school_inep", primary_key: "inep", optional: true
  belongs_to :collect, optional: true
  belongs_to :collect_entry, optional: true
  belongs_to :administration, foreign_key: "adm_cod", primary_key: "cod", optional: true
  delegate :group, to: :collect_entry, allow_nil: true

  STATUSES = [:redirected, :in_progress, :submitted].freeze

  def redirected_at_parsed
    parse_date_to_br_format(redirected_at)
  end

  def saved_at_parsed
    parse_date_to_br_format(saved_at)
  end

  def submitted_at_parsed
    parse_date_to_br_format(submitted_at)
  end

  def parsed_status_date
    submitted_at_parsed || saved_at_parsed || redirected_at_parsed
  end

  def self.statuses_for_select
    collection ||= STATUSES.collect { |k| [Submission.human_attribute_name(k), k.to_s] }
  end

  def to_s
    "#{id} #{school_id} - #{status}"
  end

  private
  def parse_date_to_br_format(date)
    DateTime.parse(date).strftime("%d/%m/%Y %H:%M")
  rescue ArgumentError, TypeError
    date
  end
end
