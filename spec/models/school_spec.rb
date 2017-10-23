require 'rails_helper'

RSpec.describe School, type: :model do
  describe 'uniqueness of inep' do
    let(:inep) { 123 }
    let!(:school) { create :school, inep: :inep }
    
    it 'invalidates the model with the same inep' do
      another_school = build :school, inep: :inep
      expect(another_school).to be_invalid
    end
  end
end
