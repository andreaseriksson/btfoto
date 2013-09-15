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
    includes(:categorizations).where("categorizations.product_category_id" => product_category_id).order("name") 
  end
  
  scope :belongs_to_product_type, ->(product_type) do
    where("product_type" => product_type) if product_type && product_type > 0
  end
  
  def price
    if self[:discount].to_f > 0
      self[:discount]
    else
      self[:price]
    end
  end
   
  def price_before_discount
    self[:price]
  end
  
  def price_with_vat
    product = self
    vat = 1+product.vat
    product.price.to_f * vat
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
