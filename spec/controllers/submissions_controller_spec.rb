require 'rails_helper'
RSpec.describe SubmissionsController, type: :controller do
  xdescribe "POST #create" do
    context "with valid params" do
      it "creates a new Submission" do
        expect {
          post :create, params: { submission: FactoryBot.attributes_for(:submission) }
        }.to change(Submission, :count).by(1)
      end

      it "redirects to the created submission" do
        post :create, params: { submission: FactoryBot.attributes_for(:submission) }
        expect(response.body).should be_blank
      end
    end
  end
end
