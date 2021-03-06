class Submission < ApplicationRecord
  belongs_to :school, foreign_key: "school_inep", primary_key: "inep", optional: true
  belongs_to :collect, optional: true
  belongs_to :collect_entry, optional: true
  belongs_to :administration, foreign_key: "adm_cod", primary_key: "cod", optional: true
  delegate :group, :quitter, :substitute, to: :collect_entry, allow_nil: true

  # ordered by magnificence
  enum status: { redirected: 0, in_progress: 1, submitted: 2, quitter: 3 }

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
    collection ||= statuses.collect { |k, v| [Submission.human_attribute_name(k), v] }
  end

  def contacts
    contacts = ""
    contacts << "Telefone da escola: #{school_phone}\n" if school_phone
    contacts << "Nome do diretor: #{submitter_name}\n" if submitter_name
    contacts << "Celular do diretor: #{submitter_phone}\n" if submitter_phone
    contacts << "Email do diretor: #{submitter_email}\n" if submitter_email
    contacts
  end

  def siblings
    Submission
    .where.not(id: id)
    .where(
      school_inep: school_inep,
      collect: collect,
      collect_entry: collect_entry
    )
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
