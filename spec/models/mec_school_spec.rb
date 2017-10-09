require 'rails_helper'

RSpec.describe MecSchool, type: :model do
  describe 'uniqueness of inep' do
    let(:inep) { 123 }
    let!(:mec_school) { create :mec_school, inep: :inep }
    
    it 'invalidates the model with the same inep' do
      another_mec_school = build :mec_school, inep: :inep
      expect(another_mec_school).to be_invalid
    end
  end
end
