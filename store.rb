class Store

  def initialize(basket:, warehouse:)
    @basket = basket
    @warehouse = warehouse
  end

  def add_to_basket(multiple_product)
    @warehouse.remove(multiple_product)
    @basket.add(multiple_product)
  end

  def remove_from_basket(multiple_product)
    @basket.remove(multiple_product)
    @warehouse.add(multiple_product)
  end

  def print_basket
    @basket.print
  end

  def print_warehouse
    @warehouse.print
  end
end
