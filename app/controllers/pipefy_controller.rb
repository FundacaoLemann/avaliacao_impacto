class PipefyController < ApplicationController
  skip_before_action :verify_authenticity_token

  def card_moved
    collect_entry = CollectEntry.find_by_card_id(pipe_params[:card_id])
    case pipe_params[:current_phase]
    when "Desistentes"
      collect_entry.update(quitter: true)
      ReplaceQuitterWorker.perform_async(collect_entry.id)
    when "Triagem"
      return unless pipe_params[:group] == "Repescagem"
      collect_entry.update(substitute: true)
    end
  end

  def clone_pipe
    collect = Collect.find(params[:collect_id])
    pipe_service = PipeService.new(collect)
    pipe = pipe_service.clone
    collect.update(pipe: pipe)
    PipefyApi.post(pipe.update_pipe_name(collect.name))
    pipe_service.create_cards(pipe.pipefy_id)

    redirect_to admin_collects_path,
      notice: "O processo de integração com o pipefy foi iniciado, por favor acompanhe o progresso no próprio pipefy."
  end

  private
  def pipe_params
    params.permit(:collect_id, :current_phase, :card_id, :group)
  end
end
