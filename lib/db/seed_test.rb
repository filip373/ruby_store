require 'sequel'
require_relative 'database'

DB = Database.new.connection
DB[:products].insert(id: 50, name: 'Table', price: 5598, vat: 750)
DB[:products].insert(id: 51, name: 'TV', price: 22594, vat: 2199)
DB[:products].insert(id: 52, name: 'Notebook', price: 50099, vat: 2000)

DB[:warehouse_products].insert(product_id: 50, quantity: 1)
DB[:warehouse_products].insert(product_id: 51, quantity: 1)
DB[:warehouse_products].insert(product_id: 52, quantity: 0)

DB[:basket_products].insert(product_id: 50, quantity: 0)
DB[:basket_products].insert(product_id: 51, quantity: 0)
DB[:basket_products].insert(product_id: 52, quantity: 0)

puts 'Database seeded'
