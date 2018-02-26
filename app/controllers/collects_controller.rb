class CollectsController < ApplicationController
  def show
    @collect = Collect.where(status: :in_progress)
                      .joins(:administrations)
                      .where(administrations: { id: params[:adm] }).first

    render json: @collect
  end
end
