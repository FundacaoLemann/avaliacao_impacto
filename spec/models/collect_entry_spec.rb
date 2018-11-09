require "rails_helper"

RSpec.describe CollectEntry, type: :model do
  it { is_expected.to belong_to(:collect) }
  it { is_expected.to belong_to(:administration) }
  it { is_expected.to belong_to(:school) }
  it { should define_enum_for(:group) }

  describe 'group' do
    let(:collect_entry) { create(:collect_entry, group: group) }

    context 'Repescagem' do
      let(:group) { "Repescagem" }

      it "allow Repescagem as a value" do
        expect(collect_entry.recapture?).to be_truthy
      end
    end

    context 'Amostra' do
      let(:group) { "Amostra" }

      it "allow Amostra as a value" do
        expect(collect_entry.sample?).to be_truthy
      end
    end
  end

  describe '#grupo' do
    let(:collect_entry) { create(:collect_entry, group: group) }

    context 'Repescagem' do
      let(:group) { "Repescagem" }

      it "returns Repescagem" do
        expect(collect_entry.grupo).to eq("Repescagem")
      end
    end

    context 'recapture' do
      let(:group) { "recapture" }

      it "returns Repescagem" do
        expect(collect_entry.grupo).to eq("Repescagem")
      end
    end

    context 'Amostra' do
      let(:group) { "Amostra" }

      it "returns Amostra" do
        expect(collect_entry.grupo).to eq("Amostra")
      end
    end

    context 'sample' do
      let(:group) { "sample" }

      it "returns Amostra" do
        expect(collect_entry.grupo).to eq("Amostra")
      end
    end
  end
end
