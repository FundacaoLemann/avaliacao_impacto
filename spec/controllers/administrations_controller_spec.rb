require 'rails_helper'

RSpec.describe AdministrationsController, type: :controller do
  render_views
  describe "GET #allowed_administrations" do
    let!(:city_administration) { create(:administration, adm: :municipal) }
    let!(:state_administration) { create(:administration, adm: :estadual) }
    let(:expected_json) {
      {
        "state_allowed_administrations" => [
          state_administration.state_id
        ],
        "city_allowed_administrations" => [
          city_administration.city_id
        ]
      }
    }

    it "returns state and city administrations grouped" do
      request.accept = 'application/json'
      get :allowed_administrations

      expect(JSON.parse(response.body)).to eq(expected_json)
    end
  end

  describe "GET #show" do
    let!(:city_administration) { create(:administration, adm: :municipal) }
    let!(:state_administration) { create(:administration, adm: :estadual) }

    context "when params contains city" do
      it "returns the correct city administration" do
        request.accept = 'application/json'
        get :show, params: { city: city_administration.city.ibge_code }

        expect(response.body).to eq(city_administration.to_json)
      end
    end

    context "when params does not contains city" do
      it "returns the state administration" do
        request.accept = 'application/json'
        get :show, params: { state: state_administration.state_id }

        expect(response.body).to eq(state_administration.to_json)
      end
    end
  end
end
