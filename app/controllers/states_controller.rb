class StatesController < ApplicationController
  before_action :set_state

  def show
    @cities = @state.cities.order(:name)
  end

  private

  def set_state
    @state = State.find(params[:id])
  end
end
