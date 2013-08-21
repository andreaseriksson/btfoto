class Product < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  has_many :categorizations
  has_many :product_categories, through: :categorizations
  
  has_many :cart_items
  
  validates :name, presence: true
  validates_presence_of :image
  
  def price_with_vat
    product = self
    product.price * (1+product.vat)
  end
  
end
