class SubmissionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_submission, only: :update

  def create
    collect_entry = CollectEntry.where(
      collect_id: submission_params[:collect_id],
      school_inep: submission_params[:school_inep]
    ).first
    adm = Administration.find_by_cod(submission_params[:adm_cod])
    Submission.new(submission_params.merge(collect_entry: collect_entry, administration: adm)).save

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
      school_inep: params[:school_inep]
    ).last
  end

  def submission_params
    params.require(:submission).permit(:school_inep, :status, :school_phone,
      :submitter_name, :submitter_email, :submitter_phone, :response_id,
      :redirected_at, :saved_at, :modified_at, :submitted_at, :form_name,
      :adm_cod, :collect_id, :card_id)
  end

  def submission_fa_params
    params.permit(:form_name, :school_inep, :response_id, :saved_at,
      :modified_at, :submitted_at, :status, :collect_id)
  end
end
