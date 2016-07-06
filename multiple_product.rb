class MultipleProduct
  attr_reader :product, :quantity

  def initialize(product:, quantity:)
    @product = product
    @quantity = quantity
  end

  def add(quantity)
    @quantity += quantity
  end

  def subtract(quantity)
    @quantity -= quantity
  end

  def to_s
    "#{@quantity} #{@product.name}(s)"
  end

  def single_price
    @product.price
  end

  def total
    @quantity * @product.price
  end

  def total_with_vat
    @quantity * @product.price * (1 + @product.vat / 100.0)
  end

end
