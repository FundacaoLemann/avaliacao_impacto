class FormsController < ApplicationController
  def show
    @form = Form.find(params[:id])

    render json: @form
  end
end
