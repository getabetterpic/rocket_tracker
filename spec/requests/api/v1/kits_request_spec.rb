require 'rails_helper'

RSpec.describe Api::V1::KitsController, type: :request do
  let(:user) { create :user }
  let(:auth_payload) { { sub: '123', scope: 'read:flight write:flight read:rocket write:rocket' } }
  let(:auth_header) {}
  before do
    allow(JsonWebToken).to receive(:verify).and_return([auth_payload, auth_header])
    allow(User).to receive(:find_or_initialize_by).and_return(user)
  end

  describe 'GET /api/v1/kits' do
    it 'returns success' do
      get '/api/v1/kits', params: { format: :json }
      expect(response).to have_http_status :success
    end
  end

  describe 'POST /api/v1/kits' do
    let(:manufacturer) { create :manufacturer, name: 'PML' }

    it 'creates a kit for the current user' do
      post '/api/v1/kits', params: { kit: { name: 'Black Brant X', manufacturer_id: manufacturer.id }, format: :json }
      expect(response).to have_http_status :created
      expect(user.reload.kits.count).to eq 1
    end

    context 'when save fails' do
      it 'renders the errors' do
        post '/api/v1/kits', params: { kit: { name: '', manufacturer_id: manufacturer.id }, format: :json }
        expect(response).to have_http_status :unprocessable_entity
        expect(JSON.parse(response.body)['errors']).to match_array ["Name can't be blank"]
      end
    end
  end
end
