require "rails_helper"

RSpec.describe FormsController do
  describe "GET #show" do
    it "returns the form as json" do
      form = create(:form)
      request.accept = 'application/json'
      get :show, params: { id: form.id }

      expect(response.body).to eq(form.to_json)
    end
  end
end
