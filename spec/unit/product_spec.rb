require_relative('../../lib/product')

RSpec.describe Product do

  let(:nil_params) { {name: nil, price: nil, vat: nil} }

  context '.new' do
    it 'takes hash with name, price and vat' do
      expect{Product.new(nil_params)}
      .not_to raise_error
    end
    it 'raises error on hash with no price value' do
      expect{Product.new({name: nil, vat: nil})}
      .to raise_error(ArgumentError)
    end
  end

  context '#name' do
    it 'returns proper name when "foo" given' do
      expect(Product.new({name: 'foo', price: nil, vat: nil}).name)
      .to eql('foo')
    end
    it 'returns proper name when "bar" given' do
      expect(Product.new({name: 'bar', price: nil, vat: nil}).name)
      .to eql('bar')
    end
  end

  context '#price' do
    it 'returns proper price when 50.34 given' do
      expect(Product.new({name: nil, price: 50.34, vat: nil}).price)
      .to eql(50.34)
    end
    it 'returns proper price when 8.12 given' do
      expect(Product.new({name: nil, price: 8.12, vat: nil}).price)
      .to eql(8.12)
    end
  end

  context '#price_with_vat' do
    it 'returns valid price with vat when some price and vat given' do
      expect(Product.new({name: nil, price: 5.34, vat: 8.66}).price_with_vat)
      .to be_within(0.01).of(5.80)
    end
    it 'returns valid price with vat when some other price and vat given' do
      expect(Product.new({name: nil, price: 7.23, vat: 34.12}).price_with_vat)
      .to be_within(0.01).of(9.70)
    end
  end
end

