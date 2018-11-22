require "rails_helper"
RSpec.describe SubmissionsController, type: :controller do
  let!(:form) { create(:form) }
  let!(:administration) { create(:administration) }
  let!(:pipe) { create(:pipe) }
  let!(:collect) { create(:collect, administrations: [administration], form: form, pipe: pipe) }
  let!(:school) { create(:school, adm_cod: administration.cod) }
  let!(:collect_entry) { create(:collect_entry, collect: collect, school_inep: school.inep, adm_cod: administration.cod) }

  before do
    allow(PipeService).to receive(:first_card_update).and_return(nil)
    allow(PipeService).to receive(:update_card_to_submitted).and_return(nil)
    allow(PipefyApi).to receive(:post).and_return(nil)
  end

  describe "POST #create" do
    context "when Submission is new" do
      let(:params) do
        {
          submission: FactoryBot.attributes_for(:submission,
            collect: collect,
            collect_entry: collect_entry
          ).merge(collect_id: collect_entry.collect.id, school_inep: collect_entry.school.inep)
        }
      end

      it "creates a new Submission" do
        expect {
          post :create, params: params
        }.to change(Submission, :count).by(1)
      end

      it "calls PipeService.first_card_update" do
        expect(PipeService).to receive(:first_card_update)

        post :create, params: params
      end
    end

    context "when the submission is a sibling" do
      let(:submission) do
        create(:submission,
          school_inep: school.inep,
          collect: collect,
          collect_entry: collect_entry,
          adm_cod: administration.cod
        )
      end

      let!(:sibling_submission) do
        create(:submission,
          school_inep: school.inep,
          collect: collect,
          collect_entry: collect_entry,
          adm_cod: administration.cod
        )
      end

      let(:params) do
        {
          submission: submission.attributes.merge(
            collect_id: submission.collect.id,
            school_inep: submission.school.inep
          )
        }
      end

      it "does not call PipeService#first_card_update" do
        expect(submission.siblings.any?).to be_truthy
        expect(PipeService).not_to receive(:first_card_update)

        post :create, params: params
      end

      it "create a new submission" do
        expect {
          post :create, params: params
        }.to change(Submission, :count)
      end
    end
  end

  describe "POST #update" do
    context "when the origin submission is missing" do
      let(:new_school_inep) { "0101" }
      let!(:another_collect_entry) do
        create(:collect_entry,
          collect: collect,
          school_inep: new_school_inep,
          adm_cod: administration.cod
        )
      end
      let(:params) do
        {
          school_inep: new_school_inep,
          collect_id: collect.id,
          form_name: form.name
        }
      end

      it "creates a new Submission" do
        expect {
          post :update, params: params
        }.to change(Submission, :count).by(1)
      end

      context "and status is in_progress" do
        it "calls Pipefy.post" do
          expect(PipefyApi).to receive(:post)

          post :update, params: params.merge(status: 'in_progress')
        end

        it "does not calls Pipefy.update_card_to_submitted" do
          expect(PipeService).not_to receive(:update_card_to_submitted)

          post :update, params: params.merge(status: 'in_progress')
        end
      end

      context "and status is submitted" do
        it "calls PipeService.update_card_to_submitted" do
          expect(PipeService).to receive(:update_card_to_submitted)

          post :update, params: params.merge(status: 'submitted')
        end
      end
    end

    context "when submission has siblings" do
      let(:status) { :redirected }
      let(:fa_status) { :redirected }
      let!(:submission) do
        create(:submission,
          school_inep: school.inep,
          collect: collect,
          collect_entry: collect_entry,
          adm_cod: administration.cod,
          form_name: form.name,
          status: status
        )
      end

      let!(:sibling_submission) do
        create(:submission,
          school_inep: school.inep,
          collect: collect,
          collect_entry: collect_entry,
          adm_cod: administration.cod,
          form_name: form.name,
          status: status
        )
      end

      let(:params) do
        params = {
          school_inep: school.inep,
          collect_id: collect.id,
          form_name: form.name,
          status: fa_status
        }
      end

      it "creates another Submission" do
        expect {
          post :update, params: params
        }.to change(Submission, :count).by(1)
      end

      context "and the max status from siblings is redirected" do
        it "returns redirected as max status" do
          expect(submission.siblings.pluck(:status).max).to eq('redirected')
        end

        context "and the FA param is in_progress" do
          let(:fa_status) { :in_progress }

          it "updates the card to in_progress" do
            expect(PipefyApi).to receive(:post)

            post :update, params: params
          end
        end

        context "and the FA param is submitted" do
          let(:fa_status) { :submitted }

          it "updates the card to submitted" do
            expect(PipeService).to receive(:update_card_to_submitted)

            post :update, params: params
          end
        end
      end

      context "and the max status from siblings is in_progress" do
        let(:status) { :in_progress }
        it "returns in_progress as max status" do
          expect(submission.siblings.pluck(:status).max).to eq('in_progress')
        end

        context "and the FA param is in_progress" do
          let(:fa_status) { :in_progress }

          it "does nothing" do
            expect(PipefyApi).not_to receive(:post)
            expect(PipeService).not_to receive(:update_card_to_submitted)

            post :update, params: params
          end
        end

        context "and the FA param is submitted" do
          let(:fa_status) { :submitted }

          it "updates the card to submitted" do
            expect(PipeService).to receive(:update_card_to_submitted)

            post :update, params: params
          end
        end
      end

      context "and the max status from siblings is submitted" do
        let(:status) { :submitted }
        it "returns submitted as max status" do
          expect(submission.siblings.pluck(:status).max).to eq('submitted')
        end

        context "and the FA param is in_progress" do
          let(:fa_status) { :in_progress }
          it "does nothing" do
            expect(PipefyApi).not_to receive(:post)
            expect(PipeService).not_to receive(:update_card_to_submitted)

            post :update, params: params
          end
        end

        context "and the FA param is submitted" do
          let(:fa_status) { :submitted }
          it "does nothing" do
            expect(PipefyApi).not_to receive(:post)
            expect(PipeService).not_to receive(:update_card_to_submitted)

            post :update, params: params
          end
        end
      end
    end
  end
end
