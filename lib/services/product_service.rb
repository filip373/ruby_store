require_relative '../models/product'

class ProductService
  def initialize(products)
    @products = products
  end

  def fetch(product_id)
    Product.new(@products[id: product_id])
  end

  def contains?(product_id)
    !@products[id: product_id].nil?
  end

  def total(products_quantities)
    products_quantities.reduce(0) do |sum, (product, quantity)|
      sum += product.price * quantity
    end
  end

  def total_with_vat(products_quantities)
    products_quantities.reduce(0) do |sum, (product, quantity)|
      sum += product.price_with_vat * quantity
    end
  end
end
