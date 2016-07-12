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
      Product.new(name: 'Book', price: 1244, vat: 833),
      Product.new(name: 'Chair', price: 4322, vat: 1255),
      Product.new(name: 'Ball', price: 522, vat: 950)
    ]
    @products_service = ProductsService.new(products)
    @warehouse_service = WarehouseService.new([
      WarehouseProduct.new(product_id: products[0].id, quantity: 3),
      WarehouseProduct.new(product_id: products[1].id, quantity: 4),
      WarehouseProduct.new(product_id: products[2].id, quantity: 2)
    ])
    @basket_service = BasketService.new
    @store_service = StoreService.new(
      basket_service: @basket_service,
      warehouse_service: @warehouse_service
    )
  end

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index, locals: {title: 'Home'}
  end

  get '/offer' do
    products = @warehouse_service.products.map do |wp|
      [@products_service.fetch(wp.product_id), wp.quantity]
    end
    erb :offer, locals: {title: 'Offer', products: products}
  end

  get '/basket' do
    products = @basket_service.products.map { |p,q| [@products_service.fetch(p), q] }
    erb :basket, locals: {title: 'Basket', products: products,
      total: @products_service.total(products),
      total_with_vat: @products_service.total_with_vat(products)}
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

