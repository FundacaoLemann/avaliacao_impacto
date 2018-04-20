class CollectEntriesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_collect_entry, only: :update

  def update
    @collect_entry&.update(collect_entry_params)
    # this is a quick fix because I could not filter the in progress label on pipefy
    if collect_entry_params[:quitter]
      submission = Submission.where(card_id: collect_entry_params[:card_id])
      submission&.update(status: :quitter)
    end

    head :ok
  end

  private
  def set_collect_entry
    @collect_entry = CollectEntry.find_by_card_id(
      collect_entry_params[:card_id]
    )
  end

  def collect_entry_params
    params.require(:collect_entry).permit(:card_id, :substitute, :quitter)
  end
end
