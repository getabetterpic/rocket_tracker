class Api::V1::ManufacturersController < Api::V1::BaseController
  include Secured

  skip_before_action :authenticate_request!, except: [:create]

  def index
    @manufacturers = Manufacturer.order('LOWER(name) ASC').all
  end

  def create
    @manufacturer = Manufacturer.new(manufacturer_params)
    if @manufacturer.save
      render json: {}, status: :created
    else
      render json: { errors: @manufacturer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def manufacturer_params
    params.require(:manufacturer).permit(:name)
  end
end
