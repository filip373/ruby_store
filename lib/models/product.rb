class Product
  attr_reader :id, :name, :price

  def initialize(id:, name:, price:, vat:)
    @id = id
    @name = name
    @price = price
    @vat = vat
  end

  def price_with_vat
    (price + price * @vat / 100 / 100).to_i
  end
end
