class AdministrationsController < ApplicationController
  def allowed_administrations
    @state_allowed_administrations = Administration.state_administrations
    @city_allowed_administrations = Administration.city_administrations
  end

  def show
    if params[:city_or_state].length > 2
      @administration = Administration.where(city_ibge_code: params[:city_or_state])
    else
      @administration = Administration.where(state_id: params[:city_or_state])
    end
    render json: @administration.first
  end
end
