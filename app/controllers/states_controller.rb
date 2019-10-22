class StatesController < ApplicationController
  before_action :set_state

  def show
    @cities = [City.new(name: '')] + @state.cities.order(:name)
  end

  def cities
    cities = @state.cities.order(:name)
    render json: cities
  end

  private
  def set_state
    @state = State.find(state_params[:id])
  end

  def state_params
    params.permit(:id)
  end
end
