require "rails_helper"
RSpec.describe SubmissionsController, type: :controller do
  let!(:form) { create(:form) }
  let!(:administration) { create(:administration) }
  let!(:collect) { create(:collect, administrations: [administration], form: form) }
  let!(:school) { create(:school, adm_cod: administration.cod) }
  let!(:collect_entry) do
    create(:collect_entry,
      collect: collect,
      school_inep: school.inep,
      adm_cod: administration.cod
    )
  end

  before do
    controller.stub(:first_card_update) { nil }
    controller.stub(:card_update) { nil }
  end

  describe "POST #create" do
    context "when Submission is new" do
      it "creates a new Submission" do
        params = {
          submission: FactoryBot.attributes_for(:submission,
            collect: collect,
            collect_entry: collect_entry
          ).merge(collect_id: collect_entry.collect.id, school_inep: collect_entry.school.inep)
        }

        expect {
          post :create, params: params
        }.to change(Submission, :count).by(1)
      end
    end

    context "when Submission is from the same school and collect" do
      let!(:submission) do
        create(:submission,
          school_inep: school.inep,
          collect: collect,
          collect_entry: collect_entry,
          adm_cod: administration.cod
        )
      end

      it "does not create a new submission" do
        params = {
          submission: submission.attributes
            .merge(collect_id: submission.collect.id, school_inep: submission.school.inep)
        }

        expect {
          post :create, params: params
        }.not_to change(Submission, :count)
      end
    end
  end

  describe "POST #update" do
    context "when Submission is missing" do
      let(:new_school_inep) { "0101" }
      let!(:another_collect_entry) do
        create(:collect_entry,
          collect: collect,
          school_inep: new_school_inep,
          adm_cod: administration.cod
        )
      end

      it "creates a new Submission" do
        params = {
          school_inep: new_school_inep,
          collect_id: collect.id,
          form_name: form.name
        }

        expect {
          post :update, params: params
        }.to change(Submission, :count).by(1)
      end
    end

    context "when Submission already exists" do
      let!(:submission) do
        create(:submission, :redirected,
          school_inep: school.inep,
          collect: collect,
          collect_entry: collect_entry,
          adm_cod: administration.cod,
          form_name: form.name
        )
      end

      let(:params) do
        params = {
          school_inep: school.inep,
          collect_id: collect.id,
          form_name: form.name,
          status: :submitted
        }
      end

      it "updates the existing Submission" do
        post :update, params: params
        expect(submission.reload.status).to eq("submitted")
      end

      it "does not create a new submission" do
        expect {
          post :update, params: params
        }.not_to change(Submission, :count)
      end
    end
  end
end
