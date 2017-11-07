class Submission < ApplicationRecord
  belongs_to :school
  before_update :set_status

  def set_status
    self.status = 'in_progress'
    self.status = 'submitted' if submitted_at
  end
end
