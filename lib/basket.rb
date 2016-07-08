class Basket

  def initialize(products)
    @products = products
  end

  def add(product)
    @products.add(product)
  end

  def remove(product)
    raise "Cannot remove #{product}, not in basket" unless contains?(product)
    @products.remove(product)
  end

  def contains?(product)
    @products.all.any? { |p| p.id == product.id }
  end

  def state
    state = 'Products in basket:'
    
    products_quantities = Hash.new(0)
    @products.all.each { |p| products_quantities[p] += 1 }
    products_quantities.each do |p,q|
      state << "\n#{q} #{p.name}(s) x #{format_money(p.price)} = "\
       "#{p.price * q}"
    end

    state << "\n#{format_money(total)} in total"
    state << "\n#{format_money(total_with_vat)} with vat"
  end

  private

    def total
      @products.all.reduce(0) { |sum,p| sum += p.price }
    end

    def total_with_vat
      @products.all.reduce(0) { |sum,p| sum += p.price_with_vat }
    end

    def format_money(price)
      '%.2f' % price
    end
end
