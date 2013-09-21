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
    sum_without_vat = 0
    delivery = order.shipping_cost
    
    order.order_items.each do |order_item| 
      sum_with_vat = sum_with_vat + (order_item.price * (1+order_item.vat) * order_item.quantity)
      sum_without_vat = sum_without_vat + (order_item.price * order_item.quantity)
    end
    
    summary = {}
    summary[:sum_without_delivery] = sum_with_vat
    summary[:sum] = sum_with_vat + delivery
    summary[:vat] = sum_with_vat - sum_without_vat
    summary[:delivery] = delivery
    summary
  end
  
end
