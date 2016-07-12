class WarehouseProduct
  attr_reader :product_id, :quantity

  def initialize(product_id:, quantity:)
    @product_id = product_id
    @quantity = quantity
  end

  def increase
    @quantity += 1
  end

  def decrease
    @quantity -= 1
  end
end

