class Api::V1::KitsController < ApplicationController
  include Secured

  skip_before_action :authenticate_request!, only: [:all]
  before_action :load_kit!, only: [:show, :update]

  def all
    @kits = Kit.all
    @kits = @kits.where(manufacturer: params[:manufacturer_id]) if params[:manufacturer_id].present?
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

  def show; end

  def update
    if @user_kit.update(update_kit_params)
      render 'show', status: :ok
    else
      render json: { errors: @kit.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def load_kit!
    @kit = current_user.kits.find_by!(id: params[:id])
    @user_kit = current_user.user_kits.find_by(kit_id: params[:id])
  end

  def kit_params
    params.require(:kit).permit(:name, :manufacturer_id)
  end

  def update_kit_params
    params.require(:kit).permit(:notes)
  end
end
