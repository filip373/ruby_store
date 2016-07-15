require_relative '../models/multiple_product'

class WarehouseService

  def initialize(multiple_products)
    @multiple_products = multiple_products
  end

  def add(product_id)
    multiple_product = find_by_id(product_id)
    @multiple_products.where(product_id: product_id)
      .update(quantity: multiple_product[:quantity] + 1)
  end

  def remove(product_id)
    unless contains?(product_id) then
      raise "Cannot remove product of id: #{product_id}, not in products"
    end
    multiple_product = find_by_id(product_id)
    @multiple_products.where(product_id: product_id)
      .update(quantity: multiple_product[:quantity] - 1)
  end

  def contains?(product_id)
    product = find_by_id(product_id)
    !product.nil? && product[:quantity] > 0
  end

  def products
    @multiple_products.where { quantity > 0 }.map do |product|
      MultipleProduct.new(product)
    end
  end

  private
  def find_by_id(id)
    @multiple_products[product_id: id]
  end
end
