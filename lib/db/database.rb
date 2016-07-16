require 'sequel'

class Database
  attr_reader :connection
  def initialize
    @connection = Sequel.connect(
      adapter: ENV['db_adapter'], user: ENV['db_user'],
      password: ENV['db_password'], host: ENV['db_host'],
      database: ENV['db_name']
    )
  end
end
