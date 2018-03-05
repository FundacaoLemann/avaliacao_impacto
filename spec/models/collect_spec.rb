require 'rails_helper'

RSpec.describe Collect, type: :model do
  it { is_expected.to belong_to(:form) }
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
end
