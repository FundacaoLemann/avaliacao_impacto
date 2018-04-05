class Collect < ApplicationRecord
  belongs_to :form
  has_many :collect_entries
  has_many :submissions
  has_and_belongs_to_many :administrations

  enum status: [:created, :in_progress, :paused, :archived]
  validates :name, :form_id, :deadline, presence: true

  FORM_ASSEMBLY_EQUIVALENT = {
    'A' => "tfa_63=1",
    'B' => "tfa_64=1",
    'C' => "tfa_65=1",
    'D' => "tfa_66=1",
    'E' => "tfa_2567=1",
    'F' => "tfa_2568=1",
    'G' => "tfa_5733=1",
    'H' => "tfa_5734=1",
    'I' => "tfa_5735=1",
    'J' => "tfa_5736=1",
    'K' => "tfa_5737=1",
    'L' => "tfa_5738=1",
    'M' => "tfa_5739=1",
    'N' => "tfa_5740=1",
    'O' => "tfa_5741=1",
  }.freeze

  # this is needed because ActiveAdmin is sending an empty string
  def form_sections=(items)
    items.delete('')
    super items
  end

  def parsed_form_sections
    form_sections.join(" ")
  end

  def sections_to_form_assembly_params
    fa_params = ''
    form_sections.each do |section|
      fa_params << FORM_ASSEMBLY_EQUIVALENT[section] << '&'
    end
    fa_params
  end

  def self.in_progress_by_administration(adm_id)
    where(status: :in_progress)
      .joins(:administrations)
      .where(administrations: { id: adm_id }).first
  end

  def parsed_deadline
    self.deadline.strftime("%d/%m/%Y %H:%M")
  end

  def attributes
    super.merge({parsed_deadline: parsed_deadline})
  end
end
