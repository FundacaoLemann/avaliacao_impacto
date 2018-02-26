class Collect < ApplicationRecord
  belongs_to :form
  has_and_belongs_to_many :administrations
  enum status: [:created, :in_progress, :paused, :archived]
  validates :name, :form_id, :deadline, presence: true

  def form_sections=(items)
    items.delete('')
    super items
  end

  def parsed_form_sections
    form_sections.join(" ")
  end
end
