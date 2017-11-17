class HomeController < ApplicationController
  def index
    load_state_and_cities
  end

  def follow_up
    load_state_and_cities
  end

  def search
    @q = School.ransack(
      name_cont: params[:school],
      unidade_federativa_eq: state_name,
      municipio_eq: params[:city],
      tp_dependencia_desc_eq: params[:administration]
    )
    @schools = @q.result(distinct: true).limit(5)
  end

  private
  def state_name
    params[:state].blank? ? '' : State.find(params[:state]).name
  end

  def load_state_and_cities
    @states = State.all
    @cities = @states.first.cities.order(:name)
  end
end
