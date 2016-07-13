require 'web_helper'

RSpec.describe 'GET /basket', type: :request do
  context 'when basket is empty' do
    before { get '/basket' }
    it 'returns ok http code' do
      expect(last_response).to be_ok
    end
    it 'contains empty basket info' do
      expect(last_response.body).to include('Your basket is empty')
    end
  end
  context 'when basket is not empty' do
    before(:all) { get '/add/50' }
    after(:all) { get '/remove/50' }
    before do
      get '/basket'
    end
    it 'returns ok http code' do
      expect(last_response).to be_ok
    end
    it 'contains product name' do
      expect(last_response.body).to include('Table')
    end
  end
end
