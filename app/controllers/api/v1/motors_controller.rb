class Api::V1::MotorsController < Api::V1::BaseController
  def index
    @motors = Motor.includes(:manufacturer).order(code: :asc)
                .paginate(page: params[:page] || 1, per_page: 50)
    @motors = @motors.where('code ILIKE ?', "%#{params[:search]}%") if params[:search].present?
  end
end
