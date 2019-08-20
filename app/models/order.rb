class Order < ApplicationRecord

  def products
    product_ids = OrderProduct.where(order_id: id).pluck(:product_id)
    Product.find(product_ids)    
  end
  def shippable?
    status != "shipped" && OrderProduct.where(order_id: id).count > 0 
  end
  def ship
    if shippable?
      if update(status: "shipped")
        # render json: self, status: :ok, location: api_v1_order_url(self)
        true
      else
        # render json: self.errors, status: :unprocessable_entity,  message: "There was a problem shipping your order." 
        false
      end
    else
      # render json: {message: "There was a problem shipping your order."}
      false
    end
  end    
end
