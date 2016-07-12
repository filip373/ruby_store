class BasketService

  def initialize()
    @products_ids = []
  end

  def add(product_id)
    @products_ids << product_id
  end

  def remove(product_id)
    unless contains?(product_id) then
      raise "Cannot remove product of id: #{product_id}, not in basket"
    end
    @products_ids.delete_at(@products_ids.index do |id|
      id == product_id
    end)
  end

  def contains?(product_id)
    @products_ids.any? { |p| p == product_id }
  end

  def products
    products_quantities = Hash.new(0)
    @products_ids.each { |p| products_quantities[p] += 1 }
    products_quantities
  end
end
