class AdministrationsController < ApplicationController
  def allowed_administrations
    @state_allowed_administrations = Administration.allowed_administrations(:estadual)
    @city_allowed_administrations = Administration.allowed_administrations(:municipal)
  end

  def show
    administration = Administration.find_administration_by_city_or_state(
      administration_params[:city_or_state]
    )

    render json: administration.first
  end

  private
  def administration_params
    params.permit(:city_or_state)
  end
end
