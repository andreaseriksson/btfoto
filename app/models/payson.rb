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
    to_curr CONFIG[:shipping_fee]
  end
  
  def order_nr
    @order.token
  end
  
  def hashed_string
    string_to_hash = "#{owner_email}:#{to_curr(@cart.summary[:sum_without_delivery])}:#{to_curr(shipping_fee)}:#{return_uri}:1#{hash}"
    Digest::MD5.hexdigest(string_to_hash)
  end
  
  def sum
    to_curr @cart.summary[:sum_without_delivery]
  end
  
  private
  
  def to_curr(num)
    number_with_precision(num, :precision => 2, :separator => ',', :delimiter => '')
  end
  
end