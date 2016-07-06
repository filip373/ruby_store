class Basket

  def initialize(products)
    @products = products
  end

  def add(multiple_product)
    @products.add(multiple_product)
    puts "#{multiple_product} added to basket"
  end

  def remove(multiple_product)
    unless @products.contains(multiple_product)
      raise "Cannot remove #{multiple_product}, it is not in basket"
    end
    @products.remove(multiple_product)
    puts "#{multiple_product} removed from basket"
  end

  def print
    puts 'Products in basket:'

    @products.list.each do |p|
      if p.quantity > 0
        puts "#{p}, #{p.quantity} x #{p.single_price} = "\
          "#{format_money(p.total)}"
      end
    end

    puts "#{format_money(total)} in total"
    puts "#{format_money(total_with_vat)} with vat"
  end

  private

    def total
      @products.list.reduce(0) { |sum, p| sum += p.total }
    end

    def total_with_vat
      @products.list.reduce(0) { |sum, p| sum += p.total_with_vat }
    end

    def format_money(price)
      sprintf('%.2f', price)
    end
end
