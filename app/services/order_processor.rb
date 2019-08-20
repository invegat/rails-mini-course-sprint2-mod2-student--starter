class OrderProcessor
  # class OrderProcessorError < StandareError
  # end

  attr_reader :order, :products
  def initialize(order)
    @order = order
    product_ids = OrderProduct.where(order_id: @order.id).pluck(:product_id)
    @products = Product.find(product_ids)  
  end

  def ship
    if products_available?
      products.each {|p| p.reduce_inventory}
      order.ship
    else
      false
    end
  end

  private

  def products_available?
      products.count == products.select {|p| p.available?}.count
  end


end
