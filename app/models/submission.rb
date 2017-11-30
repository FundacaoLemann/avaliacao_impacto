class Submission < ApplicationRecord
  belongs_to :school
  STATUSES = [
    ['Não iniciado',''],
    ['Iniciado', 'redirected'],
    ['Em progresso','in_progress'],
    ['Enviado', 'submitted']
  ]

  def redirected_at_parsed
    DateTime.parse(redirected_at).strftime("%d/%m/%Y %H:%M") if redirected_at
  end

  def saved_at_parsed
    parse_date(saved_at)
  end

  def submitted_at_parsed
    parse_date(submitted_at)
  end

  private
  def parse_date(date)
    return unless date
    month = date.slice!(0..2)
    date.insert(3,month)
  end
end
