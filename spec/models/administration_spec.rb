require 'rails_helper'

RSpec.describe Administration, type: :model do
  it { is_expected.to have_and_belong_to_many(:collects) }
  it { is_expected.to validate_uniqueness_of(:name) }

  describe ".state_administrations" do
    it "returns only the state administration" do
      state_administration = create(:administration, adm: :estadual)
      create(:administration, adm: :municipal)
      create(:administration, adm: :federal)

      expect(Administration.state_administrations).to eq([state_administration])
    end
  end

  describe ".city_administrations" do
    it "returns only the city administration" do
      city_administration = create(:administration, adm: :municipal)
      create(:administration, adm: :estadual)
      create(:administration, adm: :federal)

      expect(Administration.city_administrations).to eq([city_administration])
    end
  end
end
