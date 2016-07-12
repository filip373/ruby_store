require 'sinatra/base'
require 'sinatra/reloader'
require_relative './models/product'
require_relative './models/warehouse_product'
require_relative './services/store_service'
require_relative './services/basket_service'
require_relative './services/warehouse_service'
require_relative './services/products_service'

class App < Sinatra::Base

  def initialize(app = nil)
    super(app)
    products = [
      Product.new(name: 'Book', price: 12.44, vat: 8.33),
      Product.new(name: 'Chair', price: 43.22, vat: 12.55),
      Product.new(name: 'Ball', price: 5.22, vat: 9.50)
    ]
    @products_service = ProductsService.new(products)
    @store_service = StoreService.new(
      basket_service: BasketService.new,
      warehouse_service: WarehouseService.new([
        WarehouseProduct.new(product_id: products[0].id, quantity: 3),
        WarehouseProduct.new(product_id: products[1].id, quantity: 4),
        WarehouseProduct.new(product_id: products[2].id, quantity: 2)
    ]))
  end

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index, locals: {title: 'Home'}
  end

  get '/offer' do
    products = @store_service.warehouse_state.map do |wp|
      [@products_service.fetch(wp.product_id), wp.quantity]
    end
    erb :offer, locals: {title: 'Offer', products: products}
  end

  get '/basket' do
    products = @store_service.basket_state.map { |p,q| [@products_service.fetch(p), q] }
    erb :basket, locals: {title: 'Basket', products: products}
  end

  get '/add/:id' do
    @store_service.add_to_basket(params[:id].to_i)
    redirect '/basket'
  end

  get '/remove/:id' do
    @store_service.remove_from_basket(params[:id].to_i)
    redirect '/basket'
  end

  get '/product/:id' do
    product = @products_service.fetch(params[:id].to_i)
    erb :product, locals: {title: product.name, product: product}
  end
end

