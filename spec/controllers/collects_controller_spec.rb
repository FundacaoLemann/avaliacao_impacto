require "rails_helper"

RSpec.describe CollectsController, type: :controller do
  describe "GET #show" do
    it "returns only the first collect for the passed administration" do
      adm = create(:administration)
      collect = create(:collect, status: :in_progress, administrations: [adm])
      create(:collect, status: :in_progress, administrations: [adm])

      request.accept = "application/json"
      get :show, params: { adm: adm.id }

      expect(response.body).to eq(collect.to_json)
    end
  end
end
