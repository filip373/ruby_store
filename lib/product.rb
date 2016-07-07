class Product
  attr_reader :id, :name, :price, :vat

  def initialize(name:, price:, vat:)
    @name = name
    @price = price
    @vat = vat
  end

end
