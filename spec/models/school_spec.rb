require 'rails_helper'

RSpec.describe School, type: :model do
  it { is_expected.to have_many(:submissions) }

  describe ".municipal_on_sample_grouped_by_adm" do
    it "returns the city on sample schools grouped by dependencia and municipio" do
      first_school = create(:school, sample: true, tp_dependencia_desc: "Municipal", municipio: "Natal")
      second_school = create(:school, sample: true, tp_dependencia_desc: "Municipal", municipio: "São Bento")

      create(:school, sample: false, tp_dependencia_desc: "Municipal", municipio: "Natal")
      create(:school, sample: false, tp_dependencia_desc: "Federal", municipio: "Natal")
      create(:school, sample: false, tp_dependencia_desc: "Estadual", municipio: "Natal")

      result = School.municipal_on_sample_grouped_by_adm

      expect(result).to include(
        {
          ["Municipal", "Natal"]=> [first_school],
          ["Municipal", "São Bento"]=> [second_school]
        }
      )
      expect(result.size).to eq(2)
      expect(School.count).to eq(5)
    end
  end

  describe ".estadual_on_sample_grouped_by_adm" do
    it "returns the state on sample schools grouped by dependencia and unidade federativa" do
      first_school = create(:school, sample: true, tp_dependencia_desc: "Estadual", unidade_federativa: "Paraíba")
      second_school = create(:school, sample: true, tp_dependencia_desc: "Estadual", unidade_federativa: "Rio Grande do Norte")

      create(:school, sample: false, tp_dependencia_desc: "Municipal", unidade_federativa: "Paraíba")
      create(:school, sample: false, tp_dependencia_desc: "Federal", unidade_federativa: "Paraíba")
      create(:school, sample: false, tp_dependencia_desc: "Estadual", unidade_federativa: "Paraíba")

      result = School.estadual_on_sample_grouped_by_adm

      expect(result).to include(
        {
          ["Estadual", "Paraíba"]=> [first_school],
          ["Estadual", "Rio Grande do Norte"]=> [second_school]
        }
      )
      expect(result.size).to eq(2)
      expect(School.count).to eq(5)
    end
  end

  describe ".federal_on_sample_grouped_by_adm" do
    it "returns the country on sample schools" do
      first_school = create(:school, sample: true, tp_dependencia_desc: "Federal")
      second_school = create(:school, sample: true, tp_dependencia_desc: "Federal")

      create(:school, sample: false, tp_dependencia_desc: "Municipal")
      create(:school, sample: false, tp_dependencia_desc: "Federal")
      create(:school, sample: false, tp_dependencia_desc: "Estadual")

      result = School.federal_on_sample_grouped_by_adm

      expect(result).to include(first_school, second_school)
      expect(result.size).to eq(2)
      expect(School.count).to eq(5)
    end
  end

  describe ".count_on_sample" do
    it "returns the right count for sample schools" do
      create(:school, sample: true)
      create(:school, sample: false)

      expect(School.count_on_sample).to eq(1)
      expect(School.count).to eq(2)
    end
  end

  describe ".count_by_status" do
    it "returns the right count for each submission status for sample schools" do
      sample_school = create(:school, sample: true)
      school = create(:school, sample: false)
      create(:submission, status: :redirected, school: sample_school)
      create(:submission, status: :redirected, school: school)

      create(:submission, status: :in_progress, school: sample_school)
      create(:submission, status: :in_progress, school: school)

      create(:submission, status: :submitted, school: sample_school)
      create(:submission, status: :submitted, school: school)

      expect(School.count_by_status("redirected")).to eq(1)
      expect(School.count_by_status("in_progress")).to eq(1)
      expect(School.count_by_status("submitted")).to eq(1)
    end
  end

  describe "#to_s" do
    it "returns as inep | name" do
      school = build(:school)
      expect(school.to_s).to eq("#{school.inep} | #{school.name}")
    end
  end
end
