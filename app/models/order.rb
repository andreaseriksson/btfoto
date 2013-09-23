class Order < ActiveRecord::Base
  
  validates :first_name,  presence: true, length: { minimum: 2 }
  validates :family_name,  presence: true, length: { minimum: 2 }
  validates :phone,  presence: true, length: { minimum: 2 }
  validates :email,  presence: true, format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, multiline: true }
  validates :address1,  presence: true, length: { minimum: 2 }
  validates :zip,  presence: true, length: { minimum: 2 }
  validates :city,  presence: true, length: { minimum: 2 }
  
  has_many :order_items
  
  before_create { generate_token(:token) }
  
  default_scope -> { order("created_at DESC") }
  
  
  def generate_token(column)
	  begin
      self[column] = SecureRandom.urlsafe_base64
    end while Order.exists?(column => self[column])
	end
  
  def confirm
    order = self
    order.confirmed = true
    order.save
  end
  

  def order_pictures order_items
    pictures = []
    order_items.each do |order_item|
      pictures << Picture.current_image(order_item).first
    end
    pictures
  end 
  
  def summary
    order = self
    order_items = []
    
    sum_with_vat = 0
    sum_vat = 0
    prepaid_fee = 0
    delivery = order.shipping_cost
    extra_shipment = 0
    
    if order.extra_shipment == true
      delivery = delivery - CONFIG[:shipping_fee]
      extra_shipment = CONFIG[:shipping_fee]
    end
    
    order.order_items.each do |order_item| 
      sum_with_vat = sum_with_vat + order_item.total
      sum_vat = sum_vat + (order_item.vat * order_item.quantity)
    end
    
    prepaid_fee = CONFIG[:prepaid_fee] if order.payment_type = 'cash'
    
    summary = {}
    summary[:sum_without_delivery] = sum_with_vat + prepaid_fee
    summary[:sum] = sum_with_vat + delivery + prepaid_fee + extra_shipment
    summary[:vat] = sum_vat
    summary[:delivery] = delivery
    summary[:extra_shipment] = extra_shipment
    summary[:prepaid_fee] = prepaid_fee
    summary
  end
  
  def order_nr
    self.id + 3200
  end
end
