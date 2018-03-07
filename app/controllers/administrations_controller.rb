class AdministrationsController < ApplicationController
  def allowed_administrations
    @state_allowed_administrations = Administration.state_administrations
    @city_allowed_administrations = Administration.city_administrations
  end

  def show
    if params[:city]
      @city = City.where(ibge_code: params[:city])
      @administration = Administration.where(city_id: @city.ids.first)
    else
      @administration = Administration.where(state_id: params[:state])
    end

    render json: @administration.first
  end
end
