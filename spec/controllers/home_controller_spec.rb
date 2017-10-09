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
    before(:all) do
      @mec_school = create :mec_school, name: 'Testing mec school'
      @another_mec_school = create :mec_school, name: 'Another Mec school'
    end

    let(:expected_json) {
      {
        "mec_schools" => [
          {
            "name" => @mec_school.to_s
          }
        ]
      }
    }

    let(:all_mec_schools) {
      {
        "mec_schools" => [
          {
            "name" => @mec_school.to_s
          },
          {
            "name" => @another_mec_school.to_s
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
      get :search, params: { school: 'mec' }

      expect(JSON.parse(response.body)).to eq(all_mec_schools)
    end
  end
end
