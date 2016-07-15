require 'sequel'
require 'sequel-fixture'
require_relative '../../lib/models/product'
require_relative '../../lib/models/multiple_product'
require_relative '../../lib/services/store_service'
require_relative '../../lib/services/products_service'

RSpec.describe StoreService do

  before(:all) do
    Sequel::Fixture.path = File.join(File.dirname(__FILE__), 'fixtures')
  end

  let(:database) { Sequel.sqlite }
  let(:fixtures) { Sequel::Fixture.new :simple, database }

  after(:each) { fixtures.rollback }
  let(:warehouse_service) { ProductsService.new(database[:warehouse_products]) }
  let(:basket_service) { ProductsService.new(database[:basket_products]) }

  subject do
    fixtures
    StoreService.new(warehouse_service: warehouse_service,
                     basket_service: basket_service)
  end

  describe '#can_add?' do
    context 'when given product is in warehouse' do
      it 'returns true' do
        expect(subject.can_add?(1)).to be(true)
      end
    end

    context 'when given product has 0 quantity' do
      it 'returns false' do
        expect(subject.can_add?(2)).to be(false)
      end
    end

    context 'when given product is not in warehouse' do
      it 'returns false' do
        expect(subject.can_add?(3)).to be(false)
      end
    end
  end

  describe '#can_remove?' do
    context 'when given product is in basket' do
      before { subject.add_to_basket(1) }
      it 'returns true' do
        expect(subject.can_remove?(1)).to be(true)
      end
    end

    context 'when given product is not in basket' do
      it 'returns false' do
        expect(subject.can_remove?(1)).to be(false)
      end
    end
  end

  describe '#add_to_basket' do
    context 'when product is in warehouse' do
      it 'does not raise error' do
        expect { subject.add_to_basket(1) }.to_not raise_error
      end
      it 'adds product to basket' do
        subject.add_to_basket(1)
        products = basket_service.products
        expect(products.length).to eql(1)
        expect(products[0].product_id).to eql(1)
        expect(products[0].quantity).to eql(1)
      end
      it 'removes product from warehouse' do
        subject.add_to_basket(1)
        state = warehouse_service.products
        expect(state.length).to eql(1)
        expect(state[0].product_id).to eql(1)
        expect(state[0].quantity).to eql(1)
      end
    end

    context 'when product quantity equals 0 in warehouse' do
      it 'raises error' do
        expect { subject.add_to_basket(2) }.to raise_error(/Cannot remove/)
      end
    end

    context 'when product of given id is not in warehouse' do
      it 'raises error' do
        expect { subject.add_to_basket(3) }.to raise_error(/Cannot remove/)
      end
    end
  end

  describe '#remove_from_basket' do
    context 'when product is in warehouse' do
      before { subject.add_to_basket(1) }
      it 'does not raise error' do
        expect { subject.remove_from_basket(1) }.not_to raise_error
      end
      it 'removes product from basket' do
        subject.remove_from_basket(1)
        expect(basket_service.products).to be_empty
      end
      it 'adds product to warehouse' do
        subject.remove_from_basket(1)
        state = warehouse_service.products
        expect(state.length).to eql(1)
        expect(state[0].product_id).to eql(1)
        expect(state[0].quantity).to eql(2)
      end
    end

    context 'when product is not in basket' do
      it 'raises error' do
        expect { subject.remove_from_basket(1) }.to raise_error(/Cannot remove/)
      end
    end
  end
end
