class Collect < ApplicationRecord
  belongs_to :form
  attr_accessor :administrations_raw

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
