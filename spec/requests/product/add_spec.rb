require 'web_helper'

RSpec.describe 'GET /add/:id', type: :request do
  context 'when product is in offer' do
     before { get '/add/50' }
     after { get '/remove/50' }
     it 'returns redirect http status' do
       expect(last_response).to be_redirect
     end
     it 'adds product to basket' do
       follow_redirect!
       expect(last_request.url).to include('/basket')
       expect(last_response.body).to include('Table')
     end
  end

  context 'when product is not in offer' do
    before { get '/add/52' }
    it 'returns 404 http code' do
      expect(last_response.status).to be(404)
    end
  end

  context 'when product of given id does not exist' do
    before { get '/add/552' }
    it 'returns 404 http code' do
      expect(last_response.status).to be(404)
    end
  end
end
