class SubmissionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_submission, only: :update

  def create
    Submission.new(submission_params).save
    head :ok
  end

  def update
    @submission.update(submission_fa_params)
    head :ok
  end

  private
  def set_submission
    @submission = Submission.where(
      school_id: params[:school_id],
      submitter_email: params[:submitter_email]
    ).first
  end

  def submission_params
    params.require(:submission).permit(:school_id, :status, :school_phone,
      :submitter_name, :submitter_email, :submitter_phone, :response_id,
      :redirected_at, :saved_at, :modified_at, :submitted_at)
  end

  def submission_fa_params
    params.permit(:school_id, :submitter_email, :response_id, :saved_at,
      :modified_at, :submitted_at)
  end
end
