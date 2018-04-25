require "rails_helper"

RSpec.describe State, type: :model do
  it { should have_many(:cities) }

  describe "#to_s" do
    it "returns as acronym - name" do
      state = build(:state)

      expect(state.to_s).to eq("#{state.acronym} - #{state.name}")
    end
  end
end
