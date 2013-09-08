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
  
  scope :in_category, ->(product_category_id) do 
    includes(:categorizations).where("categorizations.product_category_id" => product_category_id) 
  end
  
  scope :belongs_to_product_type, ->(product_type) do
    where("product_type" => product_type) if product_type && product_type != ''
  end
  
  def price_with_vat
    product = self
    product.price * (1+product.vat)
  end
  
  def types
    product_types = ProductType.new
    product_types.types
  end
  
  after_initialize :default_vat
  
  private
  
  def default_vat
    self.vat = "0.25" if self.vat == 0
  end
  
end
