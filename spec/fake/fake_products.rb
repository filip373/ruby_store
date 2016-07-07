class FakeProducts

  attr_reader :list

  def initialize(contains)
    @contains = contains
    @list = 'none'
  end

  def add(multiple_products)
    @list = 'added'
  end

  def remove(multiple_products)
    @list = 'removed'
  end

  def contains(multiple_product)
    @contains
  end
end

