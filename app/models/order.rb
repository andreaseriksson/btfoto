class Order < ActiveRecord::Base
  
  validates :first_name,  presence: true, length: { minimum: 2 }
  validates :family_name,  presence: true, length: { minimum: 2 }
  validates :phone,  presence: true, length: { minimum: 2 }
  validates :email,  presence: true, format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, multiline: true }
  validates :address1,  presence: true, length: { minimum: 2 }
  validates :zip,  presence: true, length: { minimum: 2 }
  validates :city,  presence: true, length: { minimum: 2 }
  
  has_many :order_items, -> { includes(:product) }
  
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
  
end
