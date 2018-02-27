class StatesController < ApplicationController
  before_action :set_state

  def show
    @cities = @state.cities.order(:name)
  end

  def cities
    @cities = @state.cities.order(:name)
    render json: @cities
  end

  private

  def set_state
    @state = State.find(params[:id])
  end
end
