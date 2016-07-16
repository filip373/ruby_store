require 'web_helper'

RSpec.describe 'GET /product/:id', type: :request do
  context 'when given existing product id' do
    before { get '/product/50' }
    it 'returns OK HTTP code' do
      expect(last_response).to be_ok
    end
    it 'returns valid HTTP content type' do
      expect(last_response.headers['Content-Type']).to include('text/html')
    end
    it 'contains valid product name' do
      expect(last_response.body).to include('Table')
    end
  end

  context 'when given not existing product id' do
    before { get '/product/36735' }
    it 'returns 404 HTTP code' do
      expect(last_response.status).to eql(404)
    end
  end
end
