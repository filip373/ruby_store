class ProductsService
  def initialize(products)
    @products = products
  end

  def fetch(product_id)
    @products.find { |product| product.id == product_id }
  end

  def total(products_quantities)
    products_quantities.reduce(0) do |sum, (product, quantity)|
      sum += product.price * quantity
    end
  end

  def total_with_vat(products_quantities)
    products_quantities.reduce(0) do |sum, (product, quantity)|
      sum += product.price_with_vat * quantity
    end
  end
end
