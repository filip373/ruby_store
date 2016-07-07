class FakeMultipleProduct
  attr_reader :product, :quantity

  def initialize(product, quantity)
    @product = product
    @quantity = quantity
  end

  def add(quantity)
    @quantity += quantity
  end

  def subtract(quantity)
    @quantity -= quantity
  end
end

