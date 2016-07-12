class StoreService

  def initialize(basket:, warehouse:)
    @basket = basket
    @warehouse = warehouse
  end

  def add_to_basket(product_id)
    @warehouse.remove(product_id)
    @basket.add(product_id)
  end

  def remove_from_basket(product_id)
    @basket.remove(product_id)
    @warehouse.add(product_id)
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
    @warehouse.products.select { |wp| wp.quantity > 0 }
  end
end
