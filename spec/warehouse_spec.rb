require_relative('../lib/warehouse')
require_relative('./fake/fake_products')
require_relative('./fake/fake_multiple_product')

RSpec.describe Warehouse do
  fake_products = FakeProducts.new(true)
  fake_product = FakeMultipleProduct.new('foo', 5)
  subject(:warehouse) { Warehouse.new(fake_products) }

  context '#add' do
    it 'adds product to products' do
      warehouse.add(fake_product)
      expect(fake_products.list).to eql('added')
    end
  end
  context '#remove' do
    it 'removes product from products when products contain product' do
      warehouse.remove(fake_product)
      expect(fake_products.list).to eql('removed')
    end
    it 'throws exception when products does not contains product' do
      expect {
        Warehouse.new(FakeProducts.new(false)).remove(fake_product)
      }.to raise_error(/Cannot remove/)
    end
  end
  context '#contains' do
    it 'returns true if Products object returns true' do
      expect(warehouse.contains('a')).to be(true)
    end
    it 'returns false if Products object returns false' do
      expect(Warehouse.new(FakeProducts.new(false)).contains('a')).to be(false)
    end
  end
end

