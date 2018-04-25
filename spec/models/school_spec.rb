require "rails_helper"

RSpec.describe School, type: :model do
  it { is_expected.to have_many(:submissions) }
  it { is_expected.to have_many(:collect_entries) }
  it { is_expected.to belong_to(:administration) }
  it { is_expected.to validate_uniqueness_of(:inep) }

  describe "#to_s" do
    it "returns as inep | name" do
      school = build(:school)

      expect(school.to_s).to eq("#{school.inep} | #{school.name}")
    end
  end

  describe ".fundamental" do
    it "returns only fundamental schools" do
      school = create(:school, num_students_fund: 1)
      second_school = create(:school, num_students_fund: 0)

      expect(School.fundamental).to eq([school])
    end
  end
end
