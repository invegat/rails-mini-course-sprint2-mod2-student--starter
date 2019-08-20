class Product < ApplicationRecord
 
  def reduce_inventory
    if available?
      update({inventory: inventory - 1})
    end
  end

  def available?
     inventory > 0   
  end
end
