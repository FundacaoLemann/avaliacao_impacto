require "rails_helper"

RSpec.describe StatesController, type: :controller do
  let!(:state) { create(:state) }
  let!(:city) { create(:city, state: state) }

  describe "GET #show" do
    render_views
    it "returns cities as options_from_collection_for_select" do
      request.accept = 'application/javascript'
      get :show, params: { id: state.id }, xhr: true

      expect(response.body).to eq(
        "$(\"[name='city_ibge_code']\").html(\"<option value=\\\"#{city.ibge_code}\\\">#{city.name}<\\/option>\");\n"
      )
    end
  end

  describe "GET #cities" do
    it "returns cities as json" do
      request.accept = 'application/json'
      get :cities, params: { id: state.id }

      expect(response.body).to include(city.to_json)
    end
  end
end
