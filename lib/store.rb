class Store

  def initialize(basket:, warehouse:)
    @basket = basket
    @warehouse = warehouse
  end

  def add_to_basket(product)
    if @warehouse.contains?(product)
      @warehouse.remove(product)
      @basket.add(product)
      true
    else
      false
    end
  end

  def remove_from_basket(product)
    if @basket.contains?(product)
      @basket.remove(product)
      @warehouse.add(product)
      true
    else
      false
    end
  end

  def basket_state 
    @basket.state
  end

  def warehouse_state
    @warehouse.state
  end
end
