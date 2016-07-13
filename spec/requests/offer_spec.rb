require 'web_helper'

RSpec.describe 'GET /offer', type: :request do
  context 'when offer is not empty' do
    before { get '/offer' }
    it 'returns ok http code' do
      expect(last_response).to be_ok
    end
    it 'returns products in offer' do
      body = last_response.body
      expect(body).to include('Table')
      expect(body).to include('TV')
    end
  end

  context 'when offer is empty' do
    before(:all) do
      get '/add/50'
      get '/add/51'
    end
    after(:all) do
      get '/remove/50'
      get '/remove/51'
    end
    before { get '/offer' }
    it 'returns ok http code' do
      expect(last_response).to be_ok
    end
    it 'contains message about no products in offer' do
      expect(last_response.body).to include('No products currently in offer')
    end
  end
end
