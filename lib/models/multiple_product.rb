class MultipleProduct
  attr_reader :id, :product_id, :quantity

  def initialize(id:, product_id:, quantity:)
    @id = id
    @product_id = product_id
    @quantity = quantity
  end
end
