class Products

  def initialize(multiple_products)
    @multiple_products = multiple_products
  end

  def add(multiple_product)
    matching_product =
      @multiple_products.find { |p| p.product == multiple_product.product }
    if matching_product.nil?
      @multiple_products << multiple_product
    else
      matching_product.add(multiple_product.quantity)
    end
  end

  def remove(multiple_product)
    unless contains(multiple_product) then
      raise "Cannot remove #{multiple_product}, it is not available"
    end
    matching_product =
      @multiple_products.find { |p| p.product == multiple_product.product }
    matching_product.subtract(multiple_product.quantity)
  end

  def contains(multiple_product)
    @multiple_products.any? do |p|
      p.product == multiple_product.product && p.quantity >= multiple_product.quantity
    end
  end

  def list
    @multiple_products
  end
end
