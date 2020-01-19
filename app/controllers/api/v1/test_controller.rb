class Api::V1::TestController < Api::V1::BaseController
  include Secured

  def secured
    render json: {
      msg: 'Your Access Token was successfully validated!',
      token: @auth_payload,
      user: current_user
    }, status: :ok
  end
end
