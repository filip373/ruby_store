require 'rack/test'
require 'spec_helper'
require_relative '../lib/app'

module AppHelper
  def app
    App
  end
end

RSpec.configure do |config|
  config.include Rack::Test::Methods, type: :request
  config.include AppHelper, type: :request
end

