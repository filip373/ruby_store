class PrintedStore

  def initialize(store)
    @store = store
  end

  def warehouse
    output = "Products in warehouse:"
    products = ''
    @store.warehouse_state.each do |p,q|
      products << "\n#{q} #{p.name}(s) left"
    end
    output << (products.empty? ? ' none' : products)
  end

  def basket
    output = 'Products in basket:'
    state = @store.basket_state
    products = ''
    state.each do |p,q|
      products << "\n#{q} #{p.name}(s) x #{format_money(p.price)} = #{p.price * q}"
    end
    if products.empty?
      output << ' none'
    else
      output << products
      output << "\n#{format_money(total(state))} in total"
      output << "\n#{format_money(total_with_vat(state))} with vat"
    end
  end

  private

  def total(state)
    state.reduce(0) { |sum,(p,q)| sum += p.price * q }
  end

  def total_with_vat(state)
    state.reduce(0) { |sum,(p,q)| sum += p.price_with_vat * q }
  end

  def format_money(price)
    '%.2f' % price
  end
end

