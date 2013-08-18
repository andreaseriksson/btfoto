class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  
  def total
    self.price * (1+self.vat)
  end
    
end
