require 'sinatra/base'
require 'sinatra/reloader'
require_relative './models/product'
require_relative './services/store'
require_relative './services/basket'
require_relative './services/warehouse'
require_relative './services/products'

class App < Sinatra::Base

  def initialize(app = nil)
    super(app)
    product1 = Product.new(name: 'Book', price: 12.44, vat: 8.33)
    product2 = Product.new(name: 'Chair', price: 43.22, vat: 12.55)
    product3 = Product.new(name: 'Ball', price: 5.22, vat: 9.50)
    @products = Products.new([product1, product2, product3])
    @store = Store.new(basket: Basket.new, warehouse: Warehouse.new([
      product1.id, product1.id, product1.id, product2.id, product2.id, product3.id
    ]))
  end

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index, locals: {title: 'Home'}
  end

  get '/offer' do
    products = @store.warehouse_state.map { |p,q| [@products.fetch(p), q] }
    erb :offer, locals: {title: 'Offer', products: products}
  end

  get '/basket' do
    products = @store.basket_state.map { |p,q| [@products.fetch(p), q] }
    erb :basket, locals: {title: 'Basket', products: products}
  end

  get '/add/:id' do
    @store.add_to_basket(params[:id].to_i)
    redirect '/basket'
  end

  get '/remove/:id' do
    @store.remove_from_basket(params[:id].to_i)
    redirect '/basket'
  end

  get '/product/:id' do
    product = @products.fetch(params[:id].to_i)
    erb :product, locals: {title: product.name, product: product}
  end
end

