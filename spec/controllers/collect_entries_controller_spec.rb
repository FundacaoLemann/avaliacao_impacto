require "rails_helper"

RSpec.describe CollectEntriesController, type: :controller do
  describe "PUT #update" do
    context "when the param quitter is present" do
      it "updates both the collect entry and the submission attached to the card id" do
        card_id = 1
        collect_entry = create(:collect_entry, card_id: card_id)
        submission = create(:submission, card_id: card_id)

        request.accept = "application/json"
        put :update, params: { collect_entry: { card_id: 1, quitter: true } }

        expect(collect_entry.reload.quitter).to be_truthy
        expect(submission.reload.status).to eq("quitter")
      end
    end

    context "when the param quitter is not present" do
      it "just updates the collect entry" do
        card_id = 1
        collect_entry = create(:collect_entry, card_id: card_id)
        submission = create(:submission, card_id: card_id, status: :in_progress)

        request.accept = "application/json"
        put :update, params: { collect_entry: { card_id: 1, substitute: true } }

        expect(collect_entry.reload.substitute).to be_truthy
        expect(submission.reload.status).to eq("in_progress")
      end
    end
  end
end
