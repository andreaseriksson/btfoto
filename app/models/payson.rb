class Payson

  include ActionView::Helpers::NumberHelper

  def initialize(order, cart)
    @order = order
    @cart = cart
  end

  def gateway_uri
    ENV['GATEWAY_URI']
  end

  def owner_email
    ENV['OWNER_EMAIL']
  end

  def agent_id
    ENV['AGENT_ID']
  end

  def hash
    ENV['HASH']
  end

  def return_uri
    "#{ENV['RETURN_URI']}?token=#{order_nr}"
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
    @order.order_nr
  end

  private

  def to_curr(num)
    number_with_precision(num, precision: 2, separator: ',', delimiter: '')
  end
end
