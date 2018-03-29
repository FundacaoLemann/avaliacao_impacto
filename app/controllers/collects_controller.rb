class CollectsController < ApplicationController
  def show
    @collect = Collect.in_progress_by_administration(params[:adm])

    render json: @collect
  end
end
