class Collect < ApplicationRecord
  belongs_to :form
  enum status: [:created, :in_progress, :paused, :archived]
  attribute :administrations_raw
  validates :name, :administrations_raw, :form_id, :deadline, presence: true

  def administrations_raw=(items)
    self.administrations = items.split("\r\n")
  end

  def administrations_raw
    administrations.join("\n")
  end

  def form_sections=(items)
    items.delete('')
    super items
  end

  def parsed_form_sections
    form_sections.join(" ")
  end

  def parsed_administrations
    administrations.join("<br>")
  end
end
