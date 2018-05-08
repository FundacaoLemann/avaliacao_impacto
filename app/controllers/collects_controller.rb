class CollectsController < ApplicationController
  def show
    collect = Collect.in_progress_by_administration(collect_params[:adm])

    render json: collect
  end

  private
  def collect_params
    params.permit(:adm)
  end
end
