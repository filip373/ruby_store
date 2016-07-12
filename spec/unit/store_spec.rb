require_relative '../../lib/models/product'
require_relative '../../lib/models/warehouse_product'
require_relative '../../lib/services/store_service'
require_relative '../../lib/services/warehouse_service'
require_relative '../../lib/services/basket_service'

RSpec.describe StoreService do

  product1 = Product.new(name: 'Ball', price: 23.55, vat: 21.0)
  product2 = Product.new(name: 'Book', price: 9.34, vat: 9.5)
  product3 = Product.new(name: 'Chair', price: 12.55, vat: 21.4)

  let(:warehouse_service) do
    WarehouseService.new([
      WarehouseProduct.new(product_id: product1.id, quantity: 2),
      WarehouseProduct.new(product_id: product2.id, quantity: 0)
    ])
  end

  let(:basket_service) do
    BasketService.new
  end

  subject do
    StoreService.new(warehouse_service: warehouse_service,
                     basket_service: basket_service)
  end

  describe '#can_add?' do
    context 'when given product is in warehouse' do
      it 'returns true' do
        expect(subject.can_add?(product1.id)).to be(true)
      end
    end

    context 'when given product has 0 quantity' do
      it 'returns false' do
        expect(subject.can_add?(product2.id)).to be(false)
      end
    end

    context 'when given product is not in warehouse' do
      it 'returns false' do
        expect(subject.can_add?(product3.id)).to be(false)
      end
    end
  end

  describe '#can_remove?' do
    context 'when given product is in basket' do
      before { subject.add_to_basket(product1.id) }
      it 'returns true' do
        expect(subject.can_remove?(product1.id)).to be(true)
      end
    end

    context 'when given product is not in basket' do
      it 'returns false' do
        expect(subject.can_remove?(product1.id)).to be(false)
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
        expect(basket_service.products).to eql(product1.id => 1)
      end
      it 'removes product from warehouse' do
        subject.add_to_basket(product1.id)
        state = warehouse_service.products
        expect(state.length).to eql(1)
        expect(state[0].product_id).to eql(product1.id)
        expect(state[0].quantity).to eql(1)
      end
    end

    context 'when product quantity equals 0 in warehouse' do
      it 'raises error' do
        expect { subject.add_to_basket(product2.id) }.to raise_error(/Cannot remove/)
      end
    end

    context 'when product of given id is not in warehouse' do
      it 'raises error' do
        expect { subject.add_to_basket(product3.id) }.to raise_error(/Cannot remove/)
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
        expect(basket_service.products).to be_empty
      end
      it 'adds product to warehouse' do
        subject.remove_from_basket(product1.id)
        state = warehouse_service.products
        expect(state.length).to eql(1)
        expect(state[0].product_id).to eql(product1.id)
        expect(state[0].quantity).to eql(2)
      end
    end

    context 'when product is not in basket' do
      it 'raises error' do
        expect { subject.remove_from_basket(product1.id) }.to raise_error(/Cannot remove/)
      end
    end
  end

  describe '#basket_state' do
    context 'when basket is empty' do
      it 'does not return any product' do
        expect(basket_service.products).to be_empty
      end
    end

    context 'when basket contains products' do
      before do
        subject.add_to_basket(product1.id)
        subject.add_to_basket(product1.id)
      end
      it 'returns containing products' do
        state = basket_service.products
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
        expect(warehouse_service.products).to be_empty
      end
    end

    context 'when warehouse contains products' do
      it 'returns containing products' do
        state = warehouse_service.products
        expect(state.length).to eql(1)
        expect(state[0].product_id).to eql(product1.id)
        expect(state[0].quantity).to eql(2)
      end
    end
  end
end

