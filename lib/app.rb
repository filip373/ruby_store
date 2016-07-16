require 'sinatra/base'
require 'sinatra/reloader'
require 'dotenv'
require_relative './db/database'
require_relative './services/store_service'
require_relative './services/product_service'
require_relative './services/basket_service'
require_relative './services/warehouse_service'

class App < Sinatra::Base
  def initialize(app = nil)
    super(app)
    Dotenv.load(
      File.expand_path("../../.env.#{ENV['RACK_ENV']}", __FILE__),
      File.expand_path("../../.env",  __FILE__)
    )
    database = Database.new.connection
    @product_service = ProductService.new(database[:products])
    @warehouse_service = WarehouseService.new(database[:warehouse_products])
    @basket_service = BasketService.new(database[:basket_products])
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
      [@product_service.fetch(warehouse_product.product_id),
       warehouse_product.quantity]
    end
    erb :offer, locals: {title: 'Offer', products: products}
  end

  get '/basket' do
    products = @basket_service.products.map do |basket_product|
      [@product_service.fetch(basket_product.product_id),
       basket_product.quantity]
    end
    erb :basket, locals: {
      title: 'Basket', products: products,
      total: @product_service.total(products),
      total_with_vat: @product_service.total_with_vat(products)
    }
  end

  post '/add/:id' do
    id = params[:id].to_i
    halt 404 unless @store_service.can_add?(id)
    @store_service.add_to_basket(id)
    redirect '/basket'
  end

  post '/remove/:id' do
    id = params[:id].to_i
    halt 404 unless @store_service.can_remove?(id)
    @store_service.remove_from_basket(id)
    redirect '/basket'
  end

  get '/product/:id' do
    id = params[:id].to_i
    halt 404 unless @product_service.contains?(id)
    product = @product_service.fetch(id)
    erb :product, locals: {title: product.name, product: product}
  end
end
