class Products

  def initialize(array = [])
    @array = array
  end

  def add(product)
    @array << product
  end

  def remove(product)
    index = @array.index { |p| p.id == product.id }
    raise "Cannot remove #{product}, it is not available" if index.nil?
    @array.delete_at(index)
  end

  def all
    @array
  end
end
