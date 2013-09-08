class Payson
  
  include ActionView::Helpers::NumberHelper
  
  def initialize(order, cart)
    @order = order
    @cart = cart
  end
  
  def gateway_uri
    CONFIG[:gateway_uri]
  end
  
  def owner_email
    CONFIG[:owner_email]
  end
  
  def agent_id
    CONFIG[:agent_id]
  end
  
  def hash
    CONFIG[:hash]
  end
  
  def return_uri
    "#{CONFIG[:return_uri]}?token=#{order_nr}"
  end
  
  def shipping_fee
    to_curr @cart.summary[:delivery]
  end
  
  def order_nr
    @order.token
  end
  
  def hashed_string
    string_to_hash = "#{owner_email}:#{self.sum}:#{to_curr(shipping_fee)}:#{return_uri}:1#{hash}"
    Digest::MD5.hexdigest(string_to_hash)
  end
  
  def sum
    if @cart.days_left >= 0
      sum = @cart.summary[:sum_after_discount]
    else
      sum = @cart.summary[:sum_without_delivery]
    end
    to_curr sum
  end
  
  private
  
  def to_curr(num)
    number_with_precision(num, :precision => 2, :separator => ',', :delimiter => '')
  end
  
end