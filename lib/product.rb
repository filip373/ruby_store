class Product
  attr_reader :id, :name, :price, :vat

  @@id = 0

  def initialize(name:, price:, vat:)
    @@id = next_id
    @name = name
    @price = price
    @vat = vat
  end

  private

    def next_id
      @@id += 1
    end
end
