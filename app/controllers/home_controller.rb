class HomeController < ApplicationController
  def index
    @states = State.all.order(:name)
    @cities = @states.first.cities.order(:name)
  end

  def search
    query = School.ransack(
      name_cont: home_params[:school],
      cod_municipio_eq: home_params[:city],
      tp_dependencia_desc_eq: home_params[:administration]
    )
    @schools = query.result(distinct: true).limit(5)
  end

  private
  def home_params
    params.permit(:school, :city, :administration)
  end
end
