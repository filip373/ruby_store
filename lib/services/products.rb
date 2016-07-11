class Products
  def initialize(products)
    @products = products
  end

  def fetch(product_id)
    @products.find { |p| p.id == product_id }
  end
end

