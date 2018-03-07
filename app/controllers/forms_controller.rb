class FormsController < ApplicationController
  before_action :set_form, only: :show

  def show
    render json: @form
  end

  private

  def set_form
    @form = Form.find(params[:id])
  end
end
