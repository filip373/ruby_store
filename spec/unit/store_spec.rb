require_relative '../../lib/models/product'
require_relative '../../lib/models/warehouse_product'
require_relative '../../lib/services/store_service'
require_relative '../../lib/services/warehouse_service'
require_relative '../../lib/services/basket_service'

RSpec.describe StoreService do

  product1 = Product.new(name: 'Ball', price: 23.55, vat: 21.0)
  product2 = Product.new(name: 'Book', price: 9.34, vat: 9.5)

  subject do
    StoreService.new(warehouse: WarehouseService.new([
      WarehouseProduct.new(product_id: product1.id, quantity: 2)
    ]), basket: BasketService.new)
  end

  describe '#can_add?' do
    context 'when given product is in warehouse' do
      it 'returns true' do
        expect(subject.can_add?(product1.id)).to be(true)
      end
    end

    context 'when given product is not in warehouse' do
      it 'returns false' do
        expect(subject.can_add?(product2.id)).to be(false)
      end
    end
  end

  describe '#can_remove?' do
    context 'when given product is in basket' do
      before { subject.add_to_basket(product1.id) }
      it 'returns true' do
        expect(subject.can_remove?(product2.id)).to be(false)
      end
    end

    context 'when given product is not in basket' do
      it 'returns false' do
        expect(subject.can_remove?(product2.id)).to be(false)
      end
    end
  end

  describe '#add_to_basket' do
    context 'when product is in warehouse' do
      it 'does not raise error' do
        expect { subject.add_to_basket(product1.id) }.to_not raise_error
      end
      it 'adds product to basket' do
        subject.add_to_basket(product1.id)
        expect(subject.basket_state).to eql(product1.id => 1)
      end
      it 'removes product from warehouse' do
        subject.add_to_basket(product1.id)
        state = subject.warehouse_state
        expect(state.length).to eql(1)
        expect(state[0].product_id).to eql(product1.id)
        expect(state[0].quantity).to eql(1)
      end
    end

    context 'when product is not in warehouse' do
      it 'raises error' do
        expect { subject.add_to_basket(product2.id) }.to raise_error(/Cannot remove/)
      end
    end
  end

  describe '#remove_from_basket' do
    context 'when product is in warehouse' do
      before { subject.add_to_basket(product1.id) }
      it 'does not raise error' do
        expect { subject.remove_from_basket(product1.id) }.not_to raise_error
      end
      it 'removes product from basket' do
        subject.remove_from_basket(product1.id)
        expect(subject.basket_state).to be_empty
      end
      it 'adds product to warehouse' do
        subject.remove_from_basket(product1.id)
        state = subject.warehouse_state
        expect(state.length).to eql(1)
        expect(state[0].product_id).to eql(product1.id)
        expect(state[0].quantity).to eql(2)
      end
    end

    context 'when product is not in warehouse' do
      it 'raises error' do
        expect { subject.remove_from_basket(product1.id) }.to raise_error(/Cannot remove/)
      end
    end
  end

  describe '#basket_state' do
    context 'when basket is empty' do
      it 'does not return any product' do
        expect(subject.basket_state).to be_empty
      end
    end

    context 'when basket contains products' do
      before do
        subject.add_to_basket(product1.id)
        subject.add_to_basket(product1.id)
      end
      it 'returns containing products' do
        state = subject.basket_state
        expect(state.length).to eql(1)
        expect(state).to include(product1.id => 2)
      end
    end
  end

  describe '#warehouse_state' do
    context 'when warehouse is empty' do
      before do
        subject.add_to_basket(product1.id)
        subject.add_to_basket(product1.id)
      end
      it 'does not return any product' do
        expect(subject.warehouse_state).to be_empty
      end
    end

    context 'when warehouse contains products' do
      it 'returns containing products' do
        state = subject.warehouse_state
        expect(state.length).to eql(1)
        expect(state[0].product_id).to eql(product1.id)
        expect(state[0].quantity).to eql(2)
      end
    end
  end
end

