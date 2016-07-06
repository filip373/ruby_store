class Warehouse

  def initialize(products)
    @products = products
  end

  def add(multiple_product)
    @products.add(multiple_product)
    puts "#{multiple_product} added to warehouse"
  end

  def remove(multiple_product)
    unless contains(multiple_product)
      raise "Cannot remove #{multiple_product}, not in warehouse"
    end
    @products.remove(multiple_product)
    puts "#{multiple_product} removed from warehouse"
  end

  def contains(multiple_product)
    @products.contains(multiple_product)
  end

  def print
    puts 'Products in warehouse:'

    @products.list.each do |p|
      puts "#{p} left"
    end
  end

end
