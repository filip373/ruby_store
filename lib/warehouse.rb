class Warehouse

  def initialize(products)
    @products = products
  end

  def add(product)
    @products.add(product)
  end

  def remove(product)
    raise "Cannot remove #{product}, not in warehouse" unless contains?(product)
    @products.remove(product)
  end

  def contains?(product)
    @products.all.any? { |p| p.id == product.id }
  end

  def state 
    state = "Products in warehouse:"

    products_quantities = Hash.new(0)
    @products.all.each { |p| products_quantities[p] += 1 }
    products_quantities.each do |p,q|
      state << "\n#{q} #{p.name}(s) left"
    end
    state
  end

end
