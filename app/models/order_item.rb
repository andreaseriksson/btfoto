class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  
  def total
    self.price * self.quantity
  end
    
end
