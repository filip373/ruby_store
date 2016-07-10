require_relative('../lib/product')
require_relative('../lib/basket')
require_relative('../lib/warehouse')
require_relative('../lib/store')
require_relative('../lib/printed_store')

product1 = Product.new(name: 'Ball', price: 23.55, vat: 21.0)
product2 = Product.new(name: 'Book', price: 8.19, vat: 8.0)
product3 = Product.new(name: 'Chair', price: 65.84, vat: 30.0)

@store = Store.new(
  basket: Basket.new,
  warehouse: Warehouse.new([
    product1, product1, product1, product1, product1, product2, product2])
)

@printed_store = PrintedStore.new(@store)

def add_to_basket(product)
  return "Cannot add #{product.name} to basket, it is not in warehouse" unless @store.can_add?(product.id)
  @store.add_to_basket(product)
  "Added #{product.name} to basket"
end

def remove_from_basket(product)
  return "Cannot remove #{product.name} from basket, it is not in basket" unless @store.can_remove?(product.id)
  @store.remove_from_basket(product)
  "Removed #{product.name} from basket"
end

puts @printed_store.basket
puts @printed_store.warehouse

# adding product to basket
puts add_to_basket(product1)

puts @printed_store.basket
puts @printed_store.warehouse

puts "Trying to add product which is not in warehouse:"
puts add_to_basket(product3)

# adding another products to basket
puts add_to_basket(product1)
puts add_to_basket(product2)
puts add_to_basket(product2)

puts @printed_store.basket
puts @printed_store.warehouse

puts "Trying to remove product which is not in basket:"
puts remove_from_basket(product3)

# removing product from basket
puts remove_from_basket(product2)

puts @printed_store.basket
puts @printed_store.warehouse
