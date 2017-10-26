class FormOption < ApplicationRecord
  FORM_ASSEMBLY_EQUIVALENT = {
    'A' => "tfa_63=1",
    'B' => "tfa_64=1",
    'C' => "tfa_65=1",
    'D' => "tfa_66=1",
    'E' => "tfa_2567=1",
    'F' => "tfa_2568=1"
  }.freeze

  # active admin related changes, can't put as private
  # remove extra blank item from active admin
  def sections_to_show=(items)
    items.delete("")
    super items
  end

  def sections_to_form_assembly_params
    fa_params = ''
    sections_to_show.each do |section|
      fa_params << FORM_ASSEMBLY_EQUIVALENT[section] << '&'
    end
    fa_params
  end
end
