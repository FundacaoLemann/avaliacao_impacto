require 'rails_helper'

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
    before do
      @school = create :school, name: 'Testing school'
      @another_school = create :school, name: 'Another school'
    end

    let(:expected_json) {
      {
        "schools" => [
          {
            "name" => @school.to_s,
            "school_id" => @school.id
          }
        ]
      }
    }

    let(:all_schools) {
      {
        "schools" => [
          {
            "name" => @school.to_s,
            "school_id" => @school.id
          },
          {
            "name" => @another_school.to_s,
            "school_id" => @another_school.id
          }
        ]
      }
    }

    it "returns only the matching schools" do
      request.accept = 'application/json'
      get :search, params: { school: 'testing' }

      expect(JSON.parse(response.body)).to eq(expected_json)
    end

    it "returns only the matching schools" do
      request.accept = 'application/json'
      get :search, params: { school: 'school' }

      expect(JSON.parse(response.body)).to eq(all_schools)
    end
  end
end
