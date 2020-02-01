require 'rails_helper'

RSpec.describe Api::V1::MotorsController, type: :request do
  describe '/api/v1/motors' do
    it 'returns success' do
      get '/api/v1/motors', params: { format: :json }
      expect(response).to have_http_status :ok
    end
  end
end
