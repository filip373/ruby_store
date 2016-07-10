require_relative('../../lib/printed_store')

RSpec.describe PrintedStore do

  let(:product) { Product.new(name: 'Book', price: 12.33, vat: 8.33) }
  let(:store) { Store.new(warehouse: warehouse, basket: Basket.new) }
  subject { PrintedStore.new(store) }

  describe '#basket' do
    context 'when basket is empty' do
      let(:warehouse) { nil }
      it 'returns none' do
        expect(subject.basket).to eql('Products in basket: none')
      end
    end

    context 'when basket contains products' do
      let(:warehouse) { Warehouse.new([product]) }
      before { store.add_to_basket(product) }
      it 'returns products, their prices and total price' do
        expect(subject.basket).to eql("Products in basket:\n1 Book(s) x 12.33 = 12.33\n12.33 in total\n13.36 with vat")
      end
    end
  end

  describe '#warehouse' do
    context 'when warehouse is empty' do
      let(:warehouse) { Warehouse.new([]) }
      it 'returns none' do
        expect(subject.warehouse).to eql('Products in warehouse: none')
      end
    end

    context 'when warehouse contains products' do
      let(:warehouse) { Warehouse.new([product]) }
        it 'returns containing products' do
          expect(subject.warehouse).to eql("Products in warehouse:\n1 Book(s) left")
        end
    end
  end
end

