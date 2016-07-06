require_relative('./product')
require_relative('./multiple_product')
require_relative('./products')
require_relative('./basket')
require_relative('./warehouse')
require_relative('./store')

product1 = Product.new({name: 'Ball', price: 23.55, vat: 21.0})
product2 = Product.new({name: 'Book', price: 8.19, vat: 8.0})
product3 = Product.new({name: 'Chair', price: 65.84, vat: 30.0})

store = Store.new({
  basket: Basket.new(Products.new([])),
  warehouse: Warehouse.new(Products.new([
    MultipleProduct.new({product: product1, quantity: 5}),
    MultipleProduct.new({product: product2, quantity: 2}),
    MultipleProduct.new({product: product3, quantity: 0})]))
  })

store.print_basket
store.print_warehouse
puts "-"

store.add_to_basket(MultipleProduct.new({product: product1, quantity: 2}))
puts "-"

store.print_basket
store.print_warehouse
puts "-"

store.add_to_basket(MultipleProduct.new({product: product2, quantity: 2}))
puts "-"

store.print_basket
store.print_warehouse
puts "-"

store.remove_from_basket(MultipleProduct.new({product: product1, quantity: 1}))
puts "-"

store.print_basket
store.print_warehouse
puts "-"


store.remove_from_basket(MultipleProduct.new({product: product2, quantity: 3}))
puts "-"

store.print_basket
store.print_warehouse
puts "-"
