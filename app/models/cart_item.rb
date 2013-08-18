class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product
  
  validates :image_nr, presence: true
  
end
