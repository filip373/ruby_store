require_relative '../../lib/models/product'

RSpec.describe Product do

  let(:nil_params) { {name: nil, price: nil, vat: nil} }

  describe '.new' do
    context 'when hash with name, price and vat given' do
      it 'does not throw error' do
        expect{ Product.new(nil_params) }
        .not_to raise_error
      end
    end
    context 'when hash with name and vat given' do
      it 'raises ArgumentError' do
        expect{ Product.new(name: nil, vat: nil) }
        .to raise_error(ArgumentError)
      end
    end
  end

  describe '#name' do
    context 'when "foo" given' do
      it 'returns "foo"' do
        expect(Product.new(name: 'foo', price: nil, vat: nil).name)
        .to eql('foo')
      end
    end
    context 'when "bar" given' do
      it 'returns "bar"' do
        expect(Product.new(name: 'bar', price: nil, vat: nil).name)
        .to eql('bar')
      end
    end
  end

  describe '#price' do
    context 'when 5034 given' do
      it 'returns 5034' do
        expect(Product.new(name: nil, price: 5034, vat: nil).price)
        .to eql(5034)
      end
    end
    context 'when 812 given' do
      it 'returns 812' do
        expect(Product.new(name: nil, price: 812, vat: nil).price)
        .to eql(812)
      end
    end
  end

  describe '#price_with_vat' do
    context 'when some vat and price given' do
      it 'returns valid price with vat' do
        expect(Product.new(name: nil, price: 534, vat: 866).price_with_vat)
        .to eql(580)
      end
    end
    context 'when some other vat and price given' do
      it 'returns valid price with vat' do
        expect(Product.new(name: nil, price: 723, vat: 3412).price_with_vat)
        .to eql(969)
      end
    end
  end
end

