require_relative '../models/product'
require_relative '../models/warehouse_product'

module Database
  class Test
    attr_reader :products, :warehouse_products

    def initialize
      @products = [
        Product.new(id: 50, name: 'Table', price: 5598, vat: 750),
        Product.new(id: 51, name: 'TV', price: 22594, vat: 2199),
        Product.new(id: 52, name: 'Notebook', price: 50099, vat: 2000)
      ]

      @warehouse_products = [
        WarehouseProduct.new(product_id: 50, quantity: 1),
        WarehouseProduct.new(product_id: 51, quantity: 1),
        WarehouseProduct.new(product_id: 52, quantity: 0)
      ]
    end
  end
end
