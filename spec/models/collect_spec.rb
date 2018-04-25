require "rails_helper"

RSpec.describe Collect, type: :model do
  it { is_expected.to belong_to(:form) }
  it { is_expected.to belong_to(:pipe) }
  it { is_expected.to have_many(:collect_entries) }
  it { is_expected.to have_many(:submissions) }
  it { is_expected.to have_and_belong_to_many(:administrations) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:form_id) }
  it { is_expected.to validate_presence_of(:deadline) }

  describe "#form_sections" do
    it "returns form_sections without an empty string" do
      collect = build(:collect, form_sections: ["", "A", "B"])

      expect(collect.form_sections).to eq(["A", "B"])
    end
  end

  describe "#parsed_form_sections" do
    it "returns form sections joined by empty space" do
      collect = build(:collect, form_sections: ["A", "B"])

      expect(collect.parsed_form_sections).to eq("A B")
    end
  end

  describe "#sections_to_form_assembly_params" do
    it "maps the right values" do
      collect = build(:collect)

      expect(collect.sections_to_form_assembly_params).to eq(
        "tfa_63=1&tfa_64=1&tfa_65=1&tfa_66=1&tfa_2567=1&tfa_2568=1&tfa_5733=1&"\
        "tfa_5734=1&tfa_5735=1&tfa_5736=1&tfa_5737=1&tfa_5738=1&tfa_5739=1&"\
        "tfa_5740=1&tfa_5741=1&"
      )
    end
  end

  describe ".in_progress_by_administration" do
    it "returns the right collect" do
      adm = create(:administration)
      collect = create(:collect, status: :in_progress, administrations: [adm])
      create(:collect, status: :created, administrations: [adm])
      create(:collect, status: :paused, administrations: [adm])
      create(:collect, status: :archived, administrations: [adm])

      expect(Collect.in_progress_by_administration(adm.id)).to eq(collect)
    end
  end

  describe "#parsed_deadline" do
    it "returns the deadline in the desired format" do
      collect = build(:collect, deadline: DateTime.new(2001, 2, 3, 4, 5))

      expect(collect.parsed_deadline).to eq("03/02/2001 04:05")
    end
  end

  describe "#attributes" do
    it "returns the attrs with the parsed_deadline" do
      collect = build(:collect)

      expect(collect.attributes.keys).to include(:parsed_deadline)
    end
  end

  describe "#cloneable?" do
    subject { collect.cloneable? }

    context "when there is collect_entries and pipe_id" do
      let(:collect_entries) { build_list :collect_entry, 2 }
      let(:collect) { build :collect, collect_entries: collect_entries, pipe_id: 1 }

      it { is_expected.to be_falsey }
    end

    context "when there is collect_entries and no pipe_id" do
      let(:collect_entries) { build_list :collect_entry, 2 }
      let(:collect) { build :collect, collect_entries: collect_entries, pipe_id: nil }

      it { is_expected.to be_truthy }
    end

    context "when there is pipe_id and no collect_entries" do
      let(:collect) { build :collect, pipe_id: 1 }

      it { is_expected.to be_falsey }
    end

    context "when there is no collect_entries and no pipe_id" do
      let(:collect) { build :collect, pipe_id: nil }

      it { is_expected.to be_falsey }
    end
  end
end
