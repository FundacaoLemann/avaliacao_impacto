class SubmissionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_submission, only: :update

  def create
    Submission.new(submission_params).save
    head :ok
  end

  def update
    @submission.update(submission_fa_params) if @submission
    head :ok
  end

  private
  def set_submission
    @submission = Submission.where(
      form_name: params[:form_name],
      school_id: params[:school_id]
    ).last
  end

  def submission_params
    params.require(:submission).permit(:school_id, :status, :school_phone,
      :submitter_name, :submitter_email, :submitter_phone, :response_id,
      :redirected_at, :saved_at, :modified_at, :submitted_at, :form_name, :administration)
  end

  def submission_fa_params
    params.permit(:form_name, :school_id, :response_id, :saved_at,
      :modified_at, :submitted_at, :status)
  end
end
