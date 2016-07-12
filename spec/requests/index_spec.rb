require 'web_helper'

RSpec.describe 'GET /', type: :request do
  it 'returns 200 HTTP code' do
    get '/'
    expect(last_response.status).to eql(200)
  end
end

