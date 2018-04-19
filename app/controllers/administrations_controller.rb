class AdministrationsController < ApplicationController
  def allowed_administrations
    @state_allowed_administrations = Administration.allowed_administrations(:estadual)
    @city_allowed_administrations = Administration.allowed_administrations(:municipal)
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
