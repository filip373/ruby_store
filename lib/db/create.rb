require 'sequel'
require_relative 'database'

DB = Database.new.connection
DB.create_table :products do
  primary_key :id
  String :name
  Integer :price
  Integer :vat
end

DB.create_table :warehouse_products do
  primary_key :id
  foreign_key :product_id, :products
  Integer :quantity
end

DB.create_table :basket_products do
  primary_key :id
  foreign_key :product_id, :products
  Integer :quantity
end

puts 'Database created'
