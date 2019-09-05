class SubmissionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_collect_entry, :set_adm, only: :create

  def create
    pipe = Collect.find(submission_params[:collect_id]).pipe

    # If the school is part of a Collect, then include its card info on the Submission object
    if @collect_entry
      submission = Submission.create(
        submission_params.merge(
          collect_entry: @collect_entry,
          administration: @adm,
          card_id: @collect_entry.card_id
        )
      )
    else
      submission = Submission.create(
        submission_params.merge(
          collect_entry: @collect_entry,
          administration: @adm,
        )
      )
    end

    # check for sibling submissions and only update pipefy if none
    # Also, only update Pipefy if the school is part of a Collect
    if !submission.siblings.any? and @collect_entry
      PipeService.first_card_update(@collect_entry, pipe, submission_params)
    end

    head :ok
  end

  def update
    submission = create_submission_from_fa

    # If the submission object could not be created, stop the process now
    unless submission
      return
    end

    pipe = Collect.find(submission_fa_params[:collect_id]).pipe

    if submission.siblings.any?
      max_status = submission.siblings.pluck(:status).max
      if submission_fa_params[:status] == "submitted" && max_status != "submitted"
        PipeService.update_card_to_submitted(submission, pipe)
      elsif submission_fa_params[:status] == "in_progress" && max_status == "redirected"
        PipefyApi.post(pipe.update_card_label(submission.card_id, :in_progress))
      end
    else
      if submission_fa_params[:status] == "in_progress"
        PipefyApi.post(pipe.update_card_label(submission.card_id, :in_progress))
      end

      # Update the Pipefy card, but only do it if the form status is "submitted"
      if submission_fa_params[:status] == "submitted" && max_status != "submitted"
        PipeService.update_card_to_submitted(submission, pipe)
      end
    end

    head :ok
  end

  def quit
    submission = Submission.where(card_id: params[:card_id])
    submission&.update(status: :quitter)
  end

  private

  def set_collect_entry
    @collect_entry = CollectEntry.where(
      collect_id: submission_params[:collect_id],
      school_inep: submission_params[:school_inep]
    ).first
  end

  def set_adm
    @adm = Administration.find_by_cod(submission_params[:adm_cod])
  end

  def create_submission_from_fa
    collect_entry = CollectEntry.where(
      collect_id: submission_fa_params[:collect_id],
      school_inep: submission_fa_params[:school_inep]
    )

    # If there is no collect_entry for the current school,
    # no submission object can be created.
    # Stop this process now
    unless collect_entry.exists?
      return
    end

    collect_entry = collect_entry.first

    adm = Administration.find_by_cod(collect_entry.adm_cod)

    Submission.create(
      submission_fa_params.merge(
        adm_cod: collect_entry.adm_cod,
        collect_entry: collect_entry,
        administration: adm,
        card_id: collect_entry.card_id,
      )
    )
  end

  def submission_params
    params.require(:submission).permit(:school_inep, :status, :school_phone,
      :submitter_name, :submitter_email, :submitter_phone, :response_id,
      :redirected_at, :saved_at, :modified_at, :submitted_at, :form_name,
      :adm_cod, :collect_id, :card_id)
  end

  def submission_fa_params
    params.permit(:form_name, :school_inep, :response_id, :saved_at,
      :modified_at, :submitted_at, :status, :collect_id, :submitter_name,
      :submitter_email, :submitter_phone, :school_phone)
  end
end
