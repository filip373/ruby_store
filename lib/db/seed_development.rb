require 'sequel'
require_relative 'database'

DB = Database.new.connection
DB[:products].insert(name: 'Book', price: 1244, vat: 833)
DB[:products].insert(name: 'Chair', price: 4322, vat: 1255)
DB[:products].insert(name: 'Ball', price: 522, vat: 950)

products = DB[:products].all
DB[:warehouse_products].insert(product_id: products[0][:id], quantity: 3)
DB[:warehouse_products].insert(product_id: products[1][:id], quantity: 4)
DB[:warehouse_products].insert(product_id: products[2][:id], quantity: 2)

DB[:basket_products].insert(product_id: products[0][:id], quantity: 0)
DB[:basket_products].insert(product_id: products[1][:id], quantity: 0)
DB[:basket_products].insert(product_id: products[2][:id], quantity: 0)

puts 'Database seeded'
