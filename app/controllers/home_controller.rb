class HomeController < ApplicationController
  def index
    @states = State.all.order(:name)
    @cities = @states.first.cities.order(:name)
  end

  def search
    query = School.fundamental.ransack(
      name_cont: home_params[:school],
      cod_municipio_eq: home_params[:city],
      tp_dependencia_desc_eq: home_params[:administration]
    )
    result = query.result(distinct: true).limit(15)

    @schools = result.reject { |school| unpermitted_collect_entries.include?(school.inep) }
  end

  private
  def home_params
    params.permit(:school, :city, :administration, :collect_id, :adm_cod) 
  end

  def unpermitted_collect_entries
    CollectEntry.where(
      collect_id: home_params[:collect_id],
      adm_cod: home_params[:adm_cod],
      group: :recapture
    ).pluck(:school_inep)
  end
end
