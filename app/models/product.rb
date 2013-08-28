class Product < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  has_many :categorizations
  has_many :product_categories, through: :categorizations
  
  has_many :cart_items
  has_many :order_items
  
  validates :name, presence: true
  validates_presence_of :image
  
  scope :in_category, ->(product_category_id) { includes(:categorizations).where("categorizations.product_category_id" => product_category_id) }
  
  def price_with_vat
    product = self
    product.price * (1+product.vat)
  end
  
end
