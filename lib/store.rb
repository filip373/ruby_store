class Store

  def initialize(basket:, warehouse:)
    @basket = basket
    @warehouse = warehouse
  end

  def add_to_basket(product)
    @warehouse.remove(product.id)
    @basket.add(product)
  end

  def remove_from_basket(product)
    @basket.remove(product.id)
    @warehouse.add(product)
  end

  def can_add?(product_id)
    @warehouse.contains?(product_id)
  end

  def can_remove?(product_id)
    @basket.contains?(product_id)
  end

  def basket_state 
    @basket.products
  end

  def warehouse_state
    @warehouse.products
  end
end
