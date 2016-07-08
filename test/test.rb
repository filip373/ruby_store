require_relative('../lib/product')
require_relative('../lib/products')
require_relative('../lib/basket')
require_relative('../lib/warehouse')
require_relative('../lib/store')

product1 = Product.new(name: 'Ball', price: 23.55, vat: 21.0)
product2 = Product.new(name: 'Book', price: 8.19, vat: 8.0)
product3 = Product.new(name: 'Chair', price: 65.84, vat: 30.0)

@store = Store.new({
  basket: Basket.new(Products.new()),
  warehouse: Warehouse.new(Products.new([
    product1, product1, product1, product1, product1, product2, product2]))
  })


def add_to_basket(product)
  puts "Adding #{product.name} to basket: " + operation_state(@store.add_to_basket(product))
end

def remove_from_basket(product)
  puts "Removing #{product.name} from basket: " + operation_state(@store.remove_from_basket(product))
end

def operation_state(bool)
  bool ? 'success' : 'failure'
end

puts @store.basket_state
puts @store.warehouse_state

# adding product to basket
add_to_basket(product1)

puts @store.basket_state
puts @store.warehouse_state

puts "Trying to add product which is not in warehouse:"
add_to_basket(product3)

# adding another products to basket
add_to_basket(product1)
add_to_basket(product2)
add_to_basket(product2)

puts @store.basket_state
puts @store.warehouse_state

puts "Trying to remove product which is not in basket:"
remove_from_basket(product3)

# removing product from basket
remove_from_basket(product2)

puts @store.basket_state
puts @store.warehouse_state
