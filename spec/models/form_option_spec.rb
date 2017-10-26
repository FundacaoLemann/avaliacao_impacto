require 'rails_helper'

RSpec.describe FormOption, type: :model do
  describe "#sections_to_form_assembly_params" do
    let!(:form_option) { create :form_option }

    it 'returns the correct form assembly params' do
      expect(form_option.sections_to_form_assembly_params).to eq('tfa_63=1&tfa_64=1&tfa_65=1&')
    end
  end
end
