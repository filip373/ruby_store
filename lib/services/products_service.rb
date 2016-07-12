class ProductsService
  def initialize(products)
    @products = products
  end

  def fetch(product_id)
    @products.find { |p| p.id == product_id }
  end

  def total(products_quantities)
    products_quantities.reduce(0) { |sum,(p,q)| sum += p.price * q }
  end

  def total_with_vat(products_quantities)
    products_quantities.reduce(0) { |sum,(p,q)| sum += p.price_with_vat * q }
  end
end

