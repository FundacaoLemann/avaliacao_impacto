require "rails_helper"

RSpec.describe Submission, type: :model do
  it { should belong_to(:school) }
  it { should belong_to(:collect) }
  it { should belong_to(:collect_entry) }
  it { should belong_to(:administration) }
  it { should define_enum_for(:status) }

  describe "#redirected_at_parsed" do
    it "returns redirected_at in the correct format" do
      submission = build(:submission, redirected_at: "2017-11-14 11:16:00 -0300")

      expect(submission.redirected_at_parsed).to eq("14/11/2017 11:16")
    end
  end

  describe "#saved_at_parsed" do
    it "returns saved_at in the correct format" do
      submission = build(:submission, saved_at: "2017-11-14 11:16:00 -0300")

      expect(submission.saved_at_parsed).to eq("14/11/2017 11:16")
    end
  end

  describe "#submitted_at_parsed" do
    it "returns submitted_at in the correct format" do
      submission = build(:submission, submitted_at: "2017-11-14 11:16:00 -0300")

      expect(submission.submitted_at_parsed).to eq("14/11/2017 11:16")
    end
  end

  describe "#parsed_status_date" do
    context "when submitted_at exists" do
      it "returns submitted_at_parsed" do
        submission = build(:submission,
          submitted_at: "2017-11-14 11:16:00 -0300",
          saved_at: "2017-10-14 11:16:00 -0300",
          redirected_at: "2017-09-14 11:16:00 -0300"
        )

        expect(submission.parsed_status_date).to eq("14/11/2017 11:16")
      end
    end

    context "when submitted_at does not exists" do
      context "when saved_at exists" do
        it "returns saved_at_parsed" do
          submission = build(:submission,
            submitted_at: nil,
            saved_at: "2017-10-14 11:16:00 -0300",
            redirected_at: "2017-09-14 11:16:00 -0300"
          )

          expect(submission.parsed_status_date).to eq("14/10/2017 11:16")
        end
      end

      context "when redirected_at exists" do
        it "returns submitted_at_parsed" do
          submission = build(:submission,
            submitted_at: nil,
            saved_at: nil,
            redirected_at: "2017-09-14 11:16:00 -0300"
          )

          expect(submission.parsed_status_date).to eq("14/09/2017 11:16")
        end
      end
    end
  end

  describe ".statuses_for_select" do
    it "returns as array with translated keys" do
      expect(Submission.statuses_for_select).to eq(
        [
          ["Iniciado", 0],
          ["Salvo", 1],
          ["Enviado", 2],
          ["Desistente", 3]
        ]
      )
    end
  end

  describe "#to_s" do
    it "returns as id school_id - status" do
      submission = build(:submission)

      expect(submission.to_s).to eq("#{submission.id} #{submission.school_id} - #{submission.status}")
    end
  end
end
