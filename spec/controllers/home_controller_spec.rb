require "rails_helper"

RSpec.describe HomeController, type: :controller do
  describe "GET #index" do
    before do
      create_list :city, 2
    end

    it "renders the index template" do
      get :index

      expect(response).to render_template(:index)
    end
  end

  describe "GET #search" do
    render_views

    let!(:form) { create(:form) }
    let!(:administration) { create(:administration) }
    let!(:collect) { create(:collect, administrations: [administration], form: form) }
    let!(:school) { create(:school, name: "Testing school", cod_municipio: administration.cod, tp_dependencia_desc: "Estadual", num_students_fund: 1) }
    let!(:another_school) { create(:school, name: "Another school", cod_municipio: administration.cod, tp_dependencia_desc: "Estadual", num_students_fund: 1) }
    let!(:collect_entry) do
      create(:collect_entry, :sample,
        collect: collect,
        school_inep: school.inep,
        adm_cod: administration.cod
      )
    end

    let(:expected_json) {
      {
        "schools" => [
          {
            "name" => school.name,
            "school_id" => school.inep
          }
        ]
      }
    }

    let(:all_schools) {
      {
        "schools" => [
          {
            "name" => school.name,
            "school_id" => school.inep
          },
          {
            "name" => another_school.name,
            "school_id" => another_school.inep
          }
        ]
      }
    }

    it "returns only the matching schools" do
      request.accept = "application/json"
      get :search, params: {
        school: "testing",
        city: school.cod_municipio,
        tp_dependencia_desc: "Estadual",
        adm_cod: administration.cod,
        collect_id: collect.id
      }

      expect(JSON.parse(response.body)).to eq(expected_json)
    end

    it "returns only the matching schools" do
      request.accept = "application/json"
      get :search, params: {
        school: "school",
        city: school.cod_municipio,
        tp_dependencia_desc: "Estadual",
        adm_cod: administration.cod,
        collect_id: collect.id
      }

      expect(JSON.parse(response.body)).to eq(all_schools)
    end
  end
end
