require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      raise ActiveRecord::RecordNotFound
    end
  end

  describe "handling RecordNotFound exceptions" do
    it "renders a 404 message" do
      get :index

      expect(response.status).to eq(404)
    end
  end
end
