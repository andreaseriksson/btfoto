class Product < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  has_many :cart_items
  
  validates :name, presence: true
  validates_presence_of :image
  
end
