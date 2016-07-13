require_relative 'development'
require_relative 'test'

module Database
  class Instance
    def self.get(environment)
      if environment == :test then
        Database::Test.new
      else
        Database::Development.new
      end
    end
  end
end
