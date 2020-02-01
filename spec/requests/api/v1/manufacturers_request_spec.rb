require 'rails_helper'

RSpec.describe Api::V1::ManufacturersController, type: :request do
  describe 'GET /api/v1/manufacturers' do
    let!(:manufacturer) { create :manufacturer }

    it 'returns a list of manufacturers' do
      get '/api/v1/manufacturers', params: { format: :json }
      expect(response).to have_http_status :success
      expect(JSON.parse(response.body).dig('manufacturers', 0, 'name')).to eq manufacturer.name
    end
  end

  describe 'POST /api/v1/manufacturers' do
    let(:user) { create :user }
    let(:auth_payload) { {} }
    let(:auth_header) { {} }
    before do
      allow(JsonWebToken).to receive(:verify).and_return([auth_payload, auth_header])
      allow(User).to receive(:find_or_initialize_by).and_return(user)
    end

    it 'creates a new manufacturer' do
      post '/api/v1/manufacturers', params: { manufacturer: { name: 'Apogee' }, format: :json }
      expect(response).to have_http_status :created
      expect(Manufacturer.count).to eq 1
    end

    context 'when save fails' do
      it 'returns the errors' do
        post '/api/v1/manufacturers', params: { manufacturer: { name: '' }, format: :json }
        expect(response).to have_http_status :unprocessable_entity
        expect(JSON.parse(response.body)['errors']).to match_array ["Name can't be blank"]
      end
    end
  end
end
