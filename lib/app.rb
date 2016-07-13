require 'sinatra/base'
require 'sinatra/reloader'
require_relative './db/instance'
require_relative './services/store_service'
require_relative './services/basket_service'
require_relative './services/warehouse_service'
require_relative './services/products_service'

class App < Sinatra::Base
  def initialize(app = nil)
    super(app)
    database = Database::Instance.get(settings.environment)
    @products_service = ProductsService.new(database.products)
    @warehouse_service = WarehouseService.new(database.warehouse_products)
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
    products = @warehouse_service.products.map do |warehouse_product|
      [@products_service.fetch(warehouse_product.product_id),
      warehouse_product.quantity]
    end
    erb :offer, locals: {title: 'Offer', products: products}
  end

  get '/basket' do
    products = @basket_service.products.map do |product, quantity|
      [@products_service.fetch(product), quantity]
    end
    erb :basket, locals: {title: 'Basket', products: products,
      total: @products_service.total(products),
      total_with_vat: @products_service.total_with_vat(products)}
  end

  get '/add/:id' do
    id = params[:id].to_i
    halt 404 unless @store_service.can_add?(id)
    @store_service.add_to_basket(id)
    redirect '/basket'
  end

  get '/remove/:id' do
    id = params[:id].to_i
    halt 404 unless @store_service.can_remove?(id)
    @store_service.remove_from_basket(id)
    redirect '/basket'
  end

  get '/product/:id' do
    id = params[:id].to_i
    halt 404 unless @products_service.contains?(id)
    product = @products_service.fetch(id)
    erb :product, locals: {title: product.name, product: product}
  end
end
