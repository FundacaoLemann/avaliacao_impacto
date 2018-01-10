class Submission < ApplicationRecord
  belongs_to :school
  STATUSES = [
    ['Iniciado', 'redirected'],
    ['Salvo','in_progress'],
    ['Enviado', 'submitted']
  ]

  STATUSES_HASH = {
    redirected: 'Iniciado',
    in_progress: 'Salvo',
    submitted: 'Enviado'
  }

  def redirected_at_parsed
    DateTime.parse(redirected_at).strftime("%d/%m/%Y %H:%M") if redirected_at
  end

  def saved_at_parsed
    parse_date(saved_at)
  end

  def submitted_at_parsed
    parse_date(submitted_at)
  end

  def sample_school?
    School.find(school_id).sample
  end

  def parsed_status
    STATUSES_HASH[status.to_sym]
  end

  def to_s
    "#{school_id} - #{status}"
  end

  private
  def parse_date(date)
    return unless date
    month = date.slice!(0..2)
    date.insert(3,month)
  end
end
