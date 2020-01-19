require 'json_web_token'

# frozen_string_literal: true
module Secured
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request!
  end

  SCOPES = {}.freeze

  private

  def authenticate_request!
    @auth_payload, @auth_header = auth_token
    @current_user ||= find_user

    render json: { errors: ['Insufficient scope'] }, status: :unauthorized unless scope_included
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  def http_token
    if request.headers['Authorization'].present?
      request.headers['Authorization'].split(' ').last
    end
  end

  def auth_token
    JsonWebToken.verify(http_token)
  end

  def scope_included
    if SCOPES[request.env['PATH_INFO']].nil?
      true
    else
      (String(@auth_payload['scope']).split(' ') & (SCOPES[request.env['PATH_INFO']])).any?
    end
  end

  def find_user
    user = User.find_or_initialize_by(sub: @auth_payload['sub'])
    get_user_info(user) unless user.persisted?
    user
  end

  def get_user_info(user)
    headers = { 'Authorization' => "Bearer #{http_token}" }
    resp = HTTParty.get('https://getabetterpic.auth0.com/userinfo', headers: headers)
    user.update(name: resp['name'], email: resp['email'])
  end
end
