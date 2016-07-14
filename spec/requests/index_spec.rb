require 'web_helper'

RSpec.describe 'GET /', type: :request do
  before {  get '/' }
  it 'returns OK HTTP code' do
    expect(last_response).to be_ok
  end
  it 'returns HTTP content-type' do
    expect(last_response.headers['Content-Type']).to include('text/html')
  end
  it 'contains welcome message' do
    expect(last_response.body).to include('Welcome')
  end
end
