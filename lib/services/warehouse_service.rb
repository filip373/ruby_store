class WarehouseService

  attr_reader :products

  def initialize(warehouse_products)
    @products = warehouse_products
  end

  def add(product_id)
    find_by_id(product_id).increase
  end

  def remove(product_id)
    unless contains?(product_id) then
      raise "Cannot remove product of id: #{product_id}, not in warehouse"
    end
    find_by_id(product_id).decrease
  end

  def contains?(product_id)
    @products.any? { |p| p.product_id == product_id }
  end

  private
    def find_by_id(product_id)
      @products.find { |p| p.product_id == product_id }
    end
end