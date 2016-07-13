class StoreService

  def initialize(basket_service:, warehouse_service:)
    @basket_service = basket_service
    @warehouse_service = warehouse_service
  end

  def add_to_basket(product_id)
    @warehouse_service.remove(product_id)
    @basket_service.add(product_id)
  end

  def remove_from_basket(product_id)
    @basket_service.remove(product_id)
    @warehouse_service.add(product_id)
  end

  def can_add?(product_id)
    @warehouse_service.contains?(product_id)
  end

  def can_remove?(product_id)
    @basket_service.contains?(product_id)
  end
end
