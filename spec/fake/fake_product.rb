class FakeProduct 
  attr_reader :name, :price, :vat

  def initialize(name, price, vat)
    @name = name
    @price = price
    @vat = vat
  end
end

