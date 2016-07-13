require_relative '../models/product'
require_relative '../models/warehouse_product'

module Database
  class Development
    attr_reader :products, :warehouse_products

    def initialize
      @products = [
        Product.new(name: 'Book', price: 1244, vat: 833),
        Product.new(name: 'Chair', price: 4322, vat: 1255),
        Product.new(name: 'Ball', price: 522, vat: 950)
      ]

      @warehouse_products = [
        WarehouseProduct.new(product_id: @products[0].id, quantity: 3),
        WarehouseProduct.new(product_id: @products[1].id, quantity: 4),
        WarehouseProduct.new(product_id: @products[2].id, quantity: 2)
      ]
    end
  end
end
