class ProductCategory < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  has_many :categorizations
  has_many :products, through: :categorizations
  
  validates :name, presence: true
end
