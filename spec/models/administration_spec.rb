require "rails_helper"

RSpec.describe Administration, type: :model do
  it { is_expected.to have_and_belong_to_many(:collects) }
  it { is_expected.to have_many(:schools) }
  it { is_expected.to have_many(:submissions) }
  it { is_expected.to have_many(:collect_entries) }
  it { is_expected.to belong_to(:city) }
  it { is_expected.to belong_to(:state) }

  it { is_expected.to validate_uniqueness_of(:name) }

  describe ".allowed_administrations" do
    let(:in_progress_collect) { build(:collect, status: :in_progress) }

    it "returns only the given adm administrations" do
      state_administration = create(:administration, adm: :estadual, collects: [in_progress_collect])
      create(:administration, adm: :municipal)
      create(:administration, adm: :federal)

      expect(Administration.allowed_administrations(:estadual)).to eq([state_administration])
    end

    it "returns only the administrations attached to a in_progress collect" do
      archived_collect = build(:collect, status: :archived)
      state_administration = create(:administration, adm: :estadual, collects: [in_progress_collect])
      another_state_administration = create(:administration, adm: :estadual, collects: [archived_collect])
      create(:administration, adm: :municipal)
      create(:administration, adm: :federal)

      expect(Administration.allowed_administrations(:estadual)).to eq([state_administration])
    end
  end

  describe ".find_administration_by_city_or_state" do
    context "when params is the city ibge code" do
      it "returns the correct city administration" do
        city = create(:city)
        city_administration = create(:administration, city_ibge_code: city.ibge_code, adm: :municipal)

        expect(Administration.find_administration_by_city_or_state(city.ibge_code)).to eq([city_administration])
      end
    end

    context "when params is the state id" do
      it "returns the state administration" do
        state = create(:state)
        state_administration = create(:administration, state_id: state.id, adm: :estadual)

        expect(Administration.find_administration_by_city_or_state(state.id)).to eq([state_administration])
      end
    end
  end
end
