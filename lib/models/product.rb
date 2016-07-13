class Product
  attr_reader :id, :name, :price

  @@id = 0
  def initialize(name:, price:, vat:)
    @id = next_id
    @name = name
    @price = price
    @vat = vat
  end

  def price_with_vat
    (price + price * @vat / 100 / 100).to_i
  end

  private
    def next_id
      @@id += 1
    end
end
