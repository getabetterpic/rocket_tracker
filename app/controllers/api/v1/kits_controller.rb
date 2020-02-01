class Api::V1::KitsController < ApplicationController
  include Secured

  def all
    @kits = Kit.all
    @kits = Kit.where(manufacturer: params[:manufacturer_id]) if params[:manufacturer_id].present?
    render 'index'
  end

  def index
    @kits = current_user.kits.all
  end

  def create
    @kit = Kit.new(kit_params)
    if @kit.save && current_user.kits << @kit
      render json: { kit: @kit }, status: :created
    else
      render json: { errors: @kit.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @kit = current_user.kits.find!(params[:id])
  end

  private

  def kit_params
    params.require(:kit).permit(:name, :manufacturer_id)
  end
end
