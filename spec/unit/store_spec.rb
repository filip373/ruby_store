require_relative('../../lib/store')
require_relative('../../lib/product')
require_relative('../../lib/products')
require_relative('../../lib/warehouse')
require_relative('../../lib/basket')

RSpec.describe Store do

  product1 = Product.new(name: 'Ball', price: 23.55, vat: 21.0)
  product2 = Product.new(name: 'Book', price: 9.34, vat: 9.5)

  subject(:store) do
    Store.new(warehouse: Warehouse.new(Products.new([product1, product1])),
              basket: Basket.new(Products.new))
  end

  describe '#add' do
    context 'product is available in warehouse' do
      it 'returns true' do
        expect(store.add_to_basket(product1)).to eql(true)
      end
    end

    context 'product is not available in warehouse' do
      it 'returns false' do
        expect(store.add_to_basket(product2)).to eql(false)
      end
    end
  end

  describe '#remove' do
    context 'product is available in warehouse' do
      before { store.add_to_basket(product1) }
      it 'returns true' do
        expect(store.remove_from_basket(product1)).to eql(true)
      end
    end

    context 'product is not available in warehouse' do
      it 'returns false' do
        expect(store.remove_from_basket(product1)).to eql(false)
      end
    end

  end

  describe '#basket_state' do
    context 'basket is empty' do
      it 'does not return any product' do
        expect(store.basket_state).to eql("Products in basket:\n0.00 in total\n0.00 with vat")
      end
    end
    
    context 'basket contains products' do
      before do
        store.add_to_basket(product1)
        store.add_to_basket(product1)
      end
      it 'returns containing products' do
        expect(store.basket_state).to eql("Products in basket:\n2 Ball(s) x 23.55 "\
                                          "= 47.1\n47.10 in total\n56.99 with vat")
      end
    end
  end

  describe '#warehouse_state' do
    context 'warehouse is empty' do
      before do
        store.add_to_basket(product1)
        store.add_to_basket(product1)
      end
      it 'does not return any product' do
        expect(store.warehouse_state).to eql("Products in warehouse:")
      end
    end
    
    context 'warehouse contains products' do
      it 'returns containing products' do
        expect(store.warehouse_state).to eql("Products in warehouse:\n2 Ball(s) left")
      end
    end
  end
end

