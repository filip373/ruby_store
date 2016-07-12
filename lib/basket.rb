class Basket

  def initialize()
    @products = []
  end

  def add(product)
    @products << product
  end

  def remove(product_id)
    unless contains?(product_id) then
      raise "Cannot remove product of id: #{product_id}, not in basket"
    end
    @products.delete_at(@products.index { |p| p.id == product_id })
  end

  def contains?(product_id)
    @products.any? { |p| p.id == product_id }
  end

  def products
    products_quantities = Hash.new(0)
    @products.each { |p| products_quantities[p] += 1 }
    products_quantities
  end
end
