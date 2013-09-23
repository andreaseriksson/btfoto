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
    to_curr @order.shipping_cost
  end
  
  def order_nr
    @order.token
  end
  
  def hashed_string
    string_to_hash = "#{owner_email}:#{self.sum}:#{to_curr(shipping_fee)}:#{return_uri}:1#{hash}"
    Digest::MD5.hexdigest(string_to_hash)
  end
  
  def sum
    to_curr @order.summary[:sum_without_delivery]
  end
  
  def first_name
    @order.first_name
  end
  
  def family_name
    @order.family_name
  end
  
  def email
    @order.email
  end
  
  def order_id
    @order.id
  end
  
  private
  
  def to_curr(num)
    number_with_precision(num, :precision => 2, :separator => ',', :delimiter => '')
  end
  
end