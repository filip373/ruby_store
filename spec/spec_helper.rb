ENV['RACK_ENV'] = 'test'

require 'simplecov'

SimpleCov.start do
  add_filter "/spec/"
end

RSpec.configure do |config|
  config.disable_monkey_patching!
end
