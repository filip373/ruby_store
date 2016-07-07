require_relative('../lib/multiple_product')
require_relative('./fake/fake_product')

RSpec.describe MultipleProduct do

  let(:fake_product) { FakeProduct.new('book', 23.55, 9.33) }

  context '#add' do
    it 'adds 3 to current product quantity (4)' do
      product = MultipleProduct.new({product: nil, quantity: 4})
      product.add(3)
      expect(product.quantity).to eql(7)
    end
  end

  context '#subtract' do
    it 'subtracts 2 from current product quantity (5)' do
      product = MultipleProduct.new({product: nil, quantity: 5})
      product.subtract(2)
      expect(product.quantity).to eql(3)
    end
  end
  context '#to_s' do
    it 'returns string with quantity and name' do
      expect(MultipleProduct.new({product: fake_product, quantity: 4}).to_s)
      .to eql('4 book(s)') 
    end
  end
  context '#single_price' do
    it 'returns price of single product' do
      expect(MultipleProduct.new({product: fake_product, quantity: 4}).single_price)
      .to eql(23.55)
    end
  end
  context '#total' do
    it 'returns total price of multiple products' do
      expect(MultipleProduct.new({product: fake_product, quantity: 4}).total)
      .to eql(94.2)
    end
  end
  context '#total_with_vat' do
    it 'returns total price of multiple products with vat included' do
      expect(MultipleProduct.new({product: fake_product, quantity: 4}).total_with_vat)
      .to eql(102.98886)
    end
  end
end

