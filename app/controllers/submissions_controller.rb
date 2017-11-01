class SubmissionsController < ApplicationController
  def create
    Submission.new(submission_params).save
    head :ok
  end

  private
  def submission_params
    params.require(:submission).permit(:school_id, :status, :school_phone, 
      :submitter_name, :submitter_email, :submitter_phone, :response_id, 
      :redirected_at, :created_at, :modified_at, :submitted_at)
  end
end
