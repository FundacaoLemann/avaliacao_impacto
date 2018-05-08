require "rails_helper"

RSpec.describe AdministrationsController, type: :controller do
  render_views
  describe "GET #allowed_administrations" do
    let!(:in_progress_collect) { build(:collect, status: :in_progress) }
    let!(:city_administration) { create(:administration, adm: :municipal, collects: [in_progress_collect]) }
    let!(:state_administration) { create(:administration, adm: :estadual, collects: [in_progress_collect]) }
    let(:expected_json) {
      {
        "state_allowed_administrations" => [
          state_administration.state_id
        ],
        "city_allowed_administrations" => [
          city_administration.city_ibge_code
        ]
      }
    }

    it "returns state and city administrations grouped" do
      request.accept = "application/json"
      get :allowed_administrations

      expect(JSON.parse(response.body)).to eq(expected_json)
    end
  end

  describe "GET #show" do
    let!(:state) { create(:state) }
    let!(:city) { create(:city) }
    let!(:city_administration) { create(:administration, city_ibge_code: city.ibge_code, adm: :municipal) }
    let!(:state_administration) { create(:administration, state_id: state.id, adm: :estadual) }

    context "when params is the city ibge code" do
      it "returns the correct city administration" do
        request.accept = "application/json"
        get :show, params: { city_or_state: city.ibge_code }

        expect(response.body).to eq(city_administration.to_json)
      end
    end

    context "when params is the state id" do
      it "returns the state administration" do
        request.accept = "application/json"
        get :show, params: { city_or_state: state.id }

        expect(response.body).to eq(state_administration.to_json)
      end
    end
  end
end
