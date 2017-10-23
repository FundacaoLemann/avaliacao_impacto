class HomeController < ApplicationController
  def index
    @states = State.all
    @cities = @states.first.cities.order(:name)
  end

  def search
    @q = School.ransack(
      name_cont: params[:school],
      unidade_federativa_eq: state_name,
      municipio_eq: params[:city],
      tp_dependencia_desc_eq: params[:administration]
    )
    @schools = @q.result(distinct: true)
  end

  private
  def state_name
    params[:state].blank? ? '' : State.find(params[:state]).name
  end
end
