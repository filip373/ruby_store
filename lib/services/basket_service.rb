require_relative '../models/multiple_product'

class BasketService

  def initialize(basket_products)
    @basket_products = basket_products
  end

  def add(product_id)
    basket_product = find_by_id(product_id)
    if basket_product.nil? then
      @basket_products.insert(product_id: product_id, quantity: 1)
    else
      @basket_products.where(product_id: product_id)
        .update(quantity: basket_product[:quantity] + 1)
    end
  end

  def remove(product_id)
    unless contains?(product_id) then
      raise "Cannot remove product of id: #{product_id}, not in products"
    end
    basket_product = find_by_id(product_id)
    if basket_product[:quantity] == 1 then
      @basket_products.where(product_id: product_id).delete
    else
      @basket_products.where(product_id: product_id)
        .update(quantity: basket_product[:quantity] - 1)
    end
  end

  def contains?(product_id)
    !find_by_id(product_id).nil?
  end

  def products
    @basket_products.map { |product| MultipleProduct.new(product) }
  end

  private
  def find_by_id(id)
    @basket_products[product_id: id]
  end
end
