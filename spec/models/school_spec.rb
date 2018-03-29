require 'rails_helper'

RSpec.describe School, type: :model do
  it { is_expected.to have_many(:submissions) }

  describe "#to_s" do
    it "returns as inep | name" do
      school = build(:school)
      expect(school.to_s).to eq("#{school.inep} | #{school.name}")
    end
  end
end
