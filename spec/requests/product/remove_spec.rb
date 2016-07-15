require 'web_helper'

RSpec.describe 'POST /remove/:id', type: :request do
  context 'when product is in basket' do
     before do
       post '/add/50'
       post '/remove/50'
     end
     it 'returns redirect http status' do
       expect(last_response).to be_redirect
     end
     it 'adds product to basket' do
       follow_redirect!
       expect(last_request.url).to include('/basket')
       expect(last_response.body).to include('Your basket is empty')
     end
  end

  context 'when product is not in basket' do
    before { post '/remove/52' }
    it 'returns 404 http code' do
      expect(last_response.status).to be(404)
    end
  end

  context 'when product of given id does not exist' do
    before { post '/remove/552' }
    it 'returns 404 http code' do
      expect(last_response.status).to be(404)
    end
  end
end
