class OptionsController < ApplicationController
  before_action :set_option, only: %i[show update destroy]

  def index
    render json: Option.all
  end

  def show
    render json: @option
  end

  def create
    option = Option.new(option_params)

    if option.save
      render json: option, status: :created
    else
      render json: option.errors, status: :unprocessable_entity
    end
  end

  def update
    if @option.update(option_params)
      render json: @option
    else
      render json: @option.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @option.destroy
    head :no_content
  end

  private

  def set_option
    @option = Option.find(params[:id])
  end

  def option_params
    params.require(:option).permit(
      :name, :description, :price, :status,
      :menu_id, :created_by, :updated_by
    )
  end
end
