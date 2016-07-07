require_relative('../lib/products')
require_relative('./fake/fake_multiple_product')

RSpec.describe Products do

  let(:multiple_products) {
    [FakeMultipleProduct.new('foo', 5), FakeMultipleProduct.new('bar', 4)] }
  subject(:products) { Products.new(multiple_products) }

  context '#add' do
    it 'adds 2 foo products to list' do
      products.add(FakeMultipleProduct.new('foo', 2))
      expect(products.list.any? { |p| p.product == 'foo' && p.quantity == 7 } )
      .to be(true)
    end
  end
  context '#remove' do
    it 'removes 3 bar products from list' do
      products.remove(FakeMultipleProduct.new('bar', 3))
      expect(products.list.any? { |p| p.product == 'bar' && p.quantity == 1 } )
      .to be(true)
    end
  end
  context '#contains' do
    it 'returns true for containing product of greater quantity' do
      expect(products.contains(FakeMultipleProduct.new('foo', 2)))
      .to be(true)
    end
    it 'returns true for containing product of equal quantity' do
      expect(products.contains(FakeMultipleProduct.new('foo', 5)))
      .to be(true)
    end
    it 'returns false for containing product of lower quantity' do
      expect(products.contains(FakeMultipleProduct.new('bar', 5)))
      .to be(false)
    end
    it 'returns false for not containing product' do
      expect(products.contains(FakeMultipleProduct.new('something else', 5)))
      .to be(false)
    end
  end
  context '#list' do
    it 'returns list of containing multiple products objects' do
      expect(products.list).to eql(multiple_products)
    end
  end
end

