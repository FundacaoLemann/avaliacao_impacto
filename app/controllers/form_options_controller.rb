class FormOptionsController < ApplicationController
  def allowed_administrations
    @state_allowed_administrations = FormOption.where(dependencia_desc: 'Estadual')
    @city_allowed_administrations = FormOption.where(dependencia_desc: 'Municipal')
  end
end
