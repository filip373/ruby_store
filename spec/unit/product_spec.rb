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
    context 'when 50.34 given' do
      it 'returns 50.34' do
        expect(Product.new(name: nil, price: 50.34, vat: nil).price)
        .to eql(50.34)
      end
    end
    context 'when 8.12 given' do
      it 'returns 8.12' do
        expect(Product.new(name: nil, price: 8.12, vat: nil).price)
        .to eql(8.12)
      end
    end
  end

  describe '#price_with_vat' do
    context 'when some vat and price given' do
      it 'returns valid price with vat' do
        expect(Product.new(name: nil, price: 5.34, vat: 8.66).price_with_vat)
        .to be_within(0.01).of(5.80)
      end
    end
    context 'when some other vat and price given' do
      it 'returns valid price with vat' do
        expect(Product.new(name: nil, price: 7.23, vat: 34.12).price_with_vat)
        .to be_within(0.01).of(9.70)
      end
    end
  end
end

